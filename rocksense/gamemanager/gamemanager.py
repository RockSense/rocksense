import threading

import time
from datetime import datetime

import random
from random import randint

import xml.etree.ElementTree as ET

from users.usermanager import Usermanager
from users.user import User

from gpio.wallmanager import Wallmanager
import gpio.led

from gamemanager.game import Game
from gamemanager.score import Score

from func_timeout import func_timeout
from func_timeout import FunctionTimedOut

from PySide2.QtCore import QObject, Slot, Signal


class Gamemanager(QObject):

    chosen_game: Game = None
    games_list: list = [] # list of all existing games
    active_user: User = Usermanager.current_user
    scores_list: list = [] # list of all existing scores
    score_count: int = 0 # score count for catch it
    current_game_scores: list = [] # list of all scores for chosen_game
    isFinished = Signal()
    current_score = 0 # score variable for getthemall

    @staticmethod
    def load_xml_games():

        tree = ET.parse('gamemanager/games.xml')
        root = tree.getroot()

        for elements in root.findall('game'):
            ident = int(elements.find("id").text)
            game_name = elements.find("title").text
            timer = int(elements.find("timer").text)
            zones = elements.find('wallzones').text
            zones = zones.split(',')
            zones = [int(i) for i in zones]  # transforms strings from xml-file to int
            holds_needed = []
            for hold in Wallmanager.current_wall.hold_list:
                for i in range(len(zones)):
                    if hold.zone == zones[i]:  # assigns correct holds to given zones
                        holds_needed.append(hold)
            current_game = Game(ident, game_name, holds_needed, timer)
            Gamemanager.games_list.append(current_game)

    @staticmethod
    def load_xml_scores():
        try:
            tree = ET.parse('gamemanager/scores.xml')
            root = tree.getroot()

            for elements in root.findall('score'):
                user_ident = int(elements.find('user_id').text)
                game_ident = int(elements.find('game_id').text)
                user_score = float(elements.find('user_score').text)
                timestamp = elements.find('timestamp').text
                score = Score(game_ident, user_ident, user_score, timestamp)
                Gamemanager.scores_list.append(score)
        except IOError:
            print('Could not read file. Creating a new one when saving.')

    @staticmethod
    def save_games():
        data = ET.Element('games')

        for game_data in Gamemanager.games_list:
            gamedata = ET.SubElement(data, 'game')
            ident = ET.SubElement(gamedata, 'id')
            ident.text = str(game_data.game_id)
            game_name = ET.SubElement(gamedata, 'title')
            game_name.text = str(game_data.game_name)
            timer = ET.SubElement(gamedata, 'timer')
            timer.text = str(game_data.timer)

        mydata = ET.tostring(data, encoding='unicode')
        myfile = open('gamemanager/games.xml', 'w')
        myfile.write(mydata)

    @staticmethod
    def save_scores():
        data = ET.Element('scores')

        for score_data in Gamemanager.scores_list:
            scoredata = ET.SubElement(data, 'score')
            game_ident = ET.SubElement(scoredata, 'game_id')
            game_ident.text = str(score_data.currentlyclimbing_id)
            user_ident = ET.SubElement(scoredata, 'user_id')
            user_ident.text = str(score_data.user_id)
            user_score = ET.SubElement(scoredata, 'user_score')
            user_score.text = str(score_data.user_score)
            timestamp = ET.SubElement(scoredata, 'timestamp')
            timestamp.text = str(score_data.timestamp)

        mydata = ET.tostring(data, encoding='unicode')
        myfile = open('scores.xml', 'w')
        myfile.write(mydata)

    @Slot(str)
    def set_chosen_game(self, index):
        if int(index) == 0:
            Gamemanager.chosen_game = Gamemanager.games_list[0]
            # print(Gamemanager.chosen_game) just for checking
        elif int(index) == 1:
            Gamemanager.chosen_game = Gamemanager.games_list[1]
            # print(Gamemanager.chosen_game) just for checking

    @Slot()
    def start_getthemall(self):  # starts a thread so game can run in the background
        climbthread = threading.Thread(target=Gamemanager.get_them_all, args=(self,), daemon=True)
        climbthread.start()

    @Slot()
    def start_catchit(self):  # starts a thread so game can run in the background
        gamethread = threading.Thread(target=Gamemanager.catch_it, daemon=True)
        gamethread.start()

    @Slot(result=str)
    def show_current_score(self):  # exposes Score from Get Them All to QML
        return str(Gamemanager.current_score)

    @Slot(result=str)
    def show_score_count(self):  # exposes Count from CatchIt to QML
        return str(Gamemanager.score_count)

    @Slot(result=int)
    def set_timer(self):  # exposes Timer for CatchIt to QML
        return Gamemanager.chosen_game.timer

    def get_them_all(self):
        Wallmanager.start_listener(Gamemanager.chosen_game.hold_list)
        holdlist_length = len(Gamemanager.chosen_game.hold_list)
        active_holds = []

        for i in range(holdlist_length // 3):  # uses only a third of holds in one zone
            randomizer = random.sample(range(holdlist_length), holdlist_length // 3)  # creates a list of unique random
                                                                                      # numbers
        for j in range(len(randomizer)):
            h = Gamemanager.chosen_game.hold_list[randomizer[j]]
            # print(h) just for checking
            active_holds.append(h) # adds corresponding holds to a list for further use
            h.led.led_on("red")

            print("Let's go!! \n")
            still_holds_to_get = True
            touched_holds = 0

            start = time.time()
            while still_holds_to_get:
                #inp = (int)(input())  # just for checking without sensor
                for hold in active_holds:
                    if hold.touched:  # or inp == hold.hold_id:  just for checking without sensor
                        print("Led off")
                        hold.led.led_off()
                        touched_holds += 1
                        if touched_holds == len(active_holds):
                            still_holds_to_get = False
                            print("done")

        self.isFinished.emit()  # emits a Signal to GameCountdown.qml to tell that the climbing is done
        stop = time.time()
        Gamemanager.current_score = round((stop - start),3) # rounds measured time to 3 numbers after comma
        # print("Time elapsed: " + str(Gamemanager.current_score)) just for checking
        score = Score(Gamemanager.chosen_game.game_id, Usermanager.current_user.id_number, Gamemanager.current_score,
                      datetime.now().strftime('%Y-%m-%d %H:%M:%S')) # creates a new score object with timestamp
        Gamemanager.scores_list.append(score)
        Gamemanager.save_scores()  # saves scores to xml-file directly when a new one is created
        gpio.led.all_led_off()
        Wallmanager.reset(Gamemanager.chosen_game.hold_list)

    @staticmethod
    def catch_it_logic():
        Wallmanager.start_listener(Gamemanager.chosen_game.hold_list)
        Gamemanager.score_count = 0  # set score count to zero again

        holdlist_length = len(Gamemanager.chosen_game.hold_list)
        possible_holds = Gamemanager.chosen_game.hold_list
        random_index = randint(0, holdlist_length - 1)
        active_hold = possible_holds[random_index]

        while True:
            random_index = randint(0, holdlist_length - 1)
            pending_hold = possible_holds[random_index]

            if pending_hold.zone == active_hold.zone:
                continue
            else:
                active_hold = pending_hold
                hold_open = True
                while hold_open:
                    active_hold.led.led_on('blue')
                    # print("Led on") just for checking
                    # inp = int(input())  # just for checking without sensors

                    if active_hold.touched:  # or inp == active_hold.hold_id:  just for checking without sensors
                        active_hold.led.led_off()
                        # print("Led off")
                        Gamemanager.score_count += 1
                        hold_open = False

    @staticmethod
    def catch_it():
        timeout = Gamemanager.chosen_game.timer
        try:
            func_timeout(timeout, Gamemanager.catch_it_logic) #  exits the game immediately after time runs out
        except FunctionTimedOut:
            print("Ende" + str(Gamemanager.score_count))
        score = Score(Gamemanager.chosen_game.game_id, Usermanager.current_user.id_number, Gamemanager.score_count,
                      datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
        Gamemanager.scores_list.append(score)
        Gamemanager.save_scores()

    @Slot(int, int, result=str)
    def get_score(self, rank: int, game: int):  # exposes selected score of selected game to QML
        scores_list_game = []
        if game == 0:
            print("Game0 ausgewählt")
            for score in Gamemanager.scores_list:
                if score.currentlyclimbing_id == game:
                    scores_list_game.append(score)

        elif game == 1:
            print("Game1 ausgewählt")
            for score in Gamemanager.scores_list:
                if score.currentlyclimbing_id == game:
                    scores_list_game.append(score)

        else:
            pass

        list_sorted = sorted(scores_list_game, key=lambda score: score.user_score)

        list_ranked_user = []
        for entry in Usermanager.user_list:
            for user in list_sorted:
                if int(user.user_id) == int(entry.id_number):  # translates given user_id to corresponding username
                    name = entry.firstname
                    list_ranked_user.append(name)

        return str(list_ranked_user[rank]) + "\n" + str(list_sorted[rank].user_score)

    @staticmethod
    def leaderboard_total():  # shows a maximum of three scores (less, if there aren't enough saved)
        global scores_list
        global chosen_game
        global current_game_scores

        for score in scores_list:
            if(score.currentlyclimbing_id == chosen_game.game_id):
                current_game_scores.append(score)

        print("\n -----LEADERBOARD-----\n")
        list_sorted = sorted(current_game_scores, key = lambda score: score.user_score)

        if len(list_sorted)> 3:
            for i in range(3):
                if chosen_game.timer==0:
                    print(str(list_sorted[i]))
                else:
                    print(str(list_sorted[len(list_sorted)-1-i]))
        else:
            for j in range(len(list_sorted)):
                if chosen_game.timer == 0:
                    print(str(list_sorted[j]))
                else:
                    print(str(list_sorted[len(list_sorted) - 1-j]))

    @staticmethod
    def leaderboard_by_time(period: int):  # could show leaderboard by Day, Month, Year currently unused

        for score in scores_list:
            if score.currentlyclimbing_id == Gamemanager.chosen_game.game_id:
                Gamemanager.current_game_scores.append(score)

        list_sorted = sorted(current_game_scores, key=lambda score: score.timestamp)

        for score in list_sorted:
            year = int(score.timestamp[0:4])
            month = int(score.timestamp[5:7])
            day = int(score.timestamp[8:10])
            if period == year:
                print(score)
            elif period == month:
                print(score)
            elif period == day:
                print(score)
            else:
                continue

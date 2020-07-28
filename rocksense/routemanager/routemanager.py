import threading
import xml.etree.ElementTree as ET
import time
from datetime import datetime
from typing import List
from gamemanager.score import Score
from routemanager.route import Route
from gpio.wallmanager import Wallmanager
import gpio.led
from gpio.hold import Hold
from users.usermanager import Usermanager

from PySide2.QtCore import QObject, Signal, Slot, QStringListModel


class Routemanager(QObject):

    routes_list: list = [] #list of all routes
    current_route: Route = None
    current_route_name: str = ""
    scores_list: list = []
    routes_string_list: list = [] # names of all routes
    chosen_holds_int = [] # IDs of all chosen holds for specific route
    new_route_name = ""
    routelistmodel = QStringListModel() # list of all routes for QML
    isFinished = Signal() # Signal to emit if method is finished
    isStarted = Signal() # Signal to emit if method is started
    current_climbing_time = 0 # saves climbing time

    def __init__(self, parent=None):
        QObject.__init__(self, parent)

    @staticmethod
    def load_xml_routes():
        try:
            tree = ET.parse('routemanager/routes.xml')
            root = tree.getroot()

            for elements in root.findall('route'):
                ident = elements.find("id").text
                route_name = elements.find("name").text
                holds = elements.find("holds").text
                holds = holds.split(",")
                holds = [int(i) for i in holds]
                actual_holds = []
                for hold in Wallmanager.current_wall.hold_list:
                    for i in range(len(holds)):
                        if hold.hold_id == holds[i]:
                            actual_holds.append(hold)  # transforms given hold numbers to the actual hold object

                starthold_index = int(elements.find("start").text)
                endhold_index = int(elements.find("end").text)

                new_route = Route(ident, route_name, actual_holds, starthold_index, endhold_index)
                Routemanager.routes_list.append(new_route)
                print(new_route.route_name + " added..")
        except IOError:
            print("Could not read file. Creating a new one when saving.")

    @staticmethod
    def load_xml_times():
        try:
            tree = ET.parse('routemanager/climbingtimes.xml')
            root = tree.getroot()

            for elements in root.findall('time'):
                route_ident = elements.find('route_id').text
                user_ident = elements.find('user_id').text
                climbingtime = elements.find('climbingtime').text
                timestamp = elements.find('timestamp').text

                new_score = Score(route_ident, user_ident, climbingtime, timestamp)
                Routemanager.scores_list.append(new_score)
                Routemanager.save_times()

        except IOError:
            print('Could not read file. Creating a new one when saving.')  # überflüssig, wird in load database gecacht

    @staticmethod
    def save_routes():
        data = ET.Element('routes')

        for route_data in Routemanager.routes_list:
            routedata = ET.SubElement(data, 'route')
            ident = ET.SubElement(routedata, 'id')
            ident.text = str(route_data.route_id)
            route_name = ET.SubElement(routedata, 'name')
            route_name.text = str(route_data.route_name)
            starthold_index = ET.SubElement(routedata, 'start')
            endhold_index = ET.SubElement(routedata, 'end')

            holds_to_numbers = []  # transforms hold ids to numbers for xml file
            for hold in route_data.hold_list:
                holds_to_numbers.append(hold.hold_id)

            starthold_index.text = str(route_data.start_hold)
            endhold_index.text = str(route_data.end_hold)

            holds = ET.SubElement(routedata, 'holds')
            holds_string = str(holds_to_numbers)
            holds.text = holds_string[1:-1]

        mydata = ET.tostring(data, encoding='unicode')
        myfile = open('routemanager/routes.xml', 'w')
        myfile.write(mydata)

    @staticmethod
    def save_times():
        data = ET.Element('climbingtimes')

        for score_data in Routemanager.scores_list:
            scoredata = ET.SubElement(data, 'time')
            route_ident = ET.SubElement(scoredata, 'route_id')
            route_ident.text = str(score_data.currentlyclimbing_id)
            user_ident = ET.SubElement(scoredata, 'user_id')
            user_ident.text = str(score_data.user_id)
            climbingtime = ET.SubElement(scoredata, 'climbingtime')
            climbingtime.text = str(score_data.user_score)
            timestamp = ET.SubElement(scoredata, 'timestamp')
            timestamp.text = str(score_data.timestamp)

        mydata = ET.tostring(data, encoding='unicode')
        myfile = open('routemanager/climbingtimes.xml', 'w')
        myfile.write(mydata)

    @Slot(str)
    def set_route_name(self, route_name): # gets the routename from NewRouteName.qml and creates new route
        Routemanager.new_route_name = route_name
        Routemanager.routes_string_list.append(route_name)

    @Slot(result=str)
    def show_route_name(self): # shows the route name in QML-Files
        return Routemanager.current_route_name

    def routes_to_string_list(self): # names of all routes are added to string list for qml
        for entry in Routemanager.routes_list:
            Routemanager.routes_string_list.append(entry.route_name)

    def set_stringlistmodel(model): # sets the qml StringListModel for displaying in QML
        model.setStringList(Routemanager.routes_string_list)
        return model

    @Slot(str)
    def set_current_route(self, index): # sets current route from stringListModel
        Routemanager.current_route_name = Routemanager.routes_string_list[int(index)]
        for route in Routemanager.routes_list:
            if Routemanager.current_route_name == route.route_name:
                Routemanager.current_route = route
        for hold in Routemanager.current_route.hold_list:
            if hold.hold_id == Routemanager.current_route.start_hold:
                hold.start = True
            if hold.hold_id == Routemanager.current_route.end_hold:
                hold.end = True

        Routemanager.show_route(Routemanager.current_route)

    @Slot(int)
    def add_to_hold_list(self, index): # adds selected holds to hold_list
        Routemanager.chosen_holds_int.append(int(index))
        print(str(index) + " added")
        Wallmanager.current_wall.hold_list[index].led.led_on("lightblue")

    @Slot(int)
    def remove_from_hold_list(self, index): # removes the holds from hold_list when deselected
        Routemanager.chosen_holds_int.remove(int(index))
        print(str(index) + "removed")
        Wallmanager.current_wall.hold_list[index].led.led_off()

    @Slot()
    def add_new_route(self):
        chosen_holds: List[Hold] = []

        for hold in Wallmanager.current_wall.hold_list:
            for index in Routemanager.chosen_holds_int:
                if hold.hold_id == int(index):
                    hold.start = False # resets both holds for next climbing
                    hold.end = False
                    chosen_holds.append(hold)
                    #print(str(hold) + " appended.")

        new_route = Route(len(Routemanager.routes_list), Routemanager.new_route_name, chosen_holds,
                          chosen_holds[0].hold_id, chosen_holds[len(chosen_holds)-1].hold_id)
        Routemanager.routes_list.append(new_route)

        #for route in Routemanager.routes_list:   checks if start- & endhold assignment works
         #   print("\n" + route.route_name)
          #  for hold in route.hold_list:
           #     print(hold)

        Routemanager.save_routes()
        Routemanager.set_stringlistmodel(Routemanager.routelistmodel)
        Routemanager.chosen_holds_int = []

    def show_route(route: Route):
        gpio.led.all_led_off()
        print("Your current Route is : " + route.route_name)
        print("Needed Holds: ")
        for hold in route.hold_list:
            print(hold)
            if hold.start:
                hold.led.led_on("green")
            elif hold.end:
                hold.led.led_on("red")
            else:
                hold.led.led_on("lightblue")
        Wallmanager.reset(Routemanager.current_route.hold_list)

    @Slot()
    def start_route(self): # starts thread for use while showing stopwatch in QML
        climbthread = threading.Thread(target=Routemanager.start_climbing_route, args=(self,), daemon=True)
        climbthread.start()

    @Slot(result=str)
    def start_climbing_route(self):
        Wallmanager.start_listener(Routemanager.current_route.hold_list)
        end_hold_touched = False
        start_hold_touched = False
        print("Let's go!! \n")

        start = 0
        while not start_hold_touched:
            for hold in Routemanager.current_route.hold_list:
                if hold.start and hold.touched:  # Stopwatch is started when starthold is touched
                    start = time.time()
                    self.isStarted.emit()
                    start_hold_touched = True

        while not end_hold_touched: # runs as long as the endhold isn't touched
            for hold in Routemanager.current_route.hold_list:
                if hold.touched:
                    hold.led.led_off() # turns off the led when the hold is touched
                    if hold.end:
                        end_hold_touched = True
                        print("done")

        stop = time.time()
        Routemanager.current_climbing_time = round((stop - start), 3)

        self.isFinished.emit() # emits signal to RouteCountdown.qml to stop stopwatch
        print("Time elapsed: " + str(Routemanager.current_climbing_time))  # just for checking
        score = Score(Routemanager.current_route.route_id, Usermanager.current_user.id_number,
                      Routemanager.current_climbing_time, datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
        Routemanager.scores_list.append(score)
        Routemanager.save_times()
        gpio.led.all_led_off()

    @Slot(result=str)
    def show_current_climbing_time(self): # eposes current time to QML
        return str(Routemanager.current_climbing_time)


class Game:

    def __init__(self, game_id: str, game_name: str, hold_list: list, timer: int):
        self.game_id = game_id
        self.game_name = game_name
        self.hold_list = hold_list
        self.timer = timer

    def __str__(self):
        return self.game_name

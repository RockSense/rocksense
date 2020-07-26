from typing import List
from gpio.hold import Hold


class Wall:
    def __init__(self, width: int, height: int, zone_edge: int, title: str, wall_id: int):
        self.width = width
        self.height = height
        self.zone_edge = zone_edge  # how many holds should be in one wall zone?
        # Please indicate the edge length (2 for 4 holds, 3 for 9 holds, 4 for 16 holds, ...)
        self.title = title
        self.wall_id = wall_id

        self.hold_list: List[Hold] = []  # container for holds

        # set up zones
        self.horizontal_zones = height // self.zone_edge
        if height % self.zone_edge > 0:
            self.horizontal_zones += 1

        self.vertical_zones = width // self.zone_edge
        if width % self.zone_edge > 0:
            self.vertical_zones += 1

    def __str__(self):
        return "Wall (id: {}, height: {}, width: {}, edge of zones: {}, #holds: {})".format(
            self.wall_id, self.height, self.width, self.zone_edge, len(self.hold_list))

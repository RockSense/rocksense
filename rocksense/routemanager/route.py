
class Route:

    def __init__(self, route_id, route_name, hold_list, start_hold, end_hold):
        self.route_id = route_id
        self.route_name = route_name
        self.hold_list = hold_list
        self.start_hold = start_hold
        self.end_hold = end_hold

    def __str__(self):
        return self.route_name

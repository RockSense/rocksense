class Score:

    def __init__(self, currentlyclimbing_id: int, user_id: int, user_score, timestamp):
        self.currentlyclimbing_id = currentlyclimbing_id
        self.user_id = user_id
        self.user_score = user_score
        self.timestamp = timestamp

    def __str__(self):
        return "user: " + str(self.user_id) + " with score: " + str(self.user_score) + " from: " + str(self.timestamp)




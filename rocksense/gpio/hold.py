from gpio.led import Led
from gpio.sensor import Sensor
import threading
import time


class Hold(threading.Thread):
    touched: bool  # 0 untouched, 1 touched
    start: bool  # is this hold a starting hold?
    end: bool  # is this hold a finishing hold?
    zone: int  # in which zone of the wall is this hold?

    def __init__(self, hold_id: int, x: int, y: int, mcp):
        threading.Thread.__init__(self)
        self.hold_id = hold_id
        self.x = x
        self.y = y
        # defaults
        self.zone = 1  # set hold as zone 1
        self.touched = False  # set hold untouched
        self.start = False  # set hold as not start
        self.end = False  # set hold as not end

        # add led and sensor to hold
        self.led = Led(hold_id)
        self.sensor = Sensor(hold_id, mcp)

    def set_start(self):
        self.start = True

    def set_end(self):
        self.end = True

    def listener(self):
        self.sensor.listener_setup()
        while self.sensor.touches == 0:
            #  checks changes in sensor values (buffer) every 100 Milliseconds
            time.sleep(0.01)
            try:
                if self.sensor.pin.value > 0:
                    print('Sensor {} touched.'.format(self.sensor.sensor_id))
                    self.sensor.touches += 1  # count touches
                    self.touched = True

            except (KeyboardInterrupt, SystemExit):
                self.led.led_off()
                raise Exception("Listener stopped.")

    def __str__(self):
        return "Hold (id: {}, x: {}, y: {}, zone: {}, start: {}, end: {}, touched: {}, " \
               "led_id: {}, sensor_id: {})".format(self.hold_id, self.x, self.y, self.zone,
                                                   self.start, self.end, self.touched,
                                                   self.led.led_id, self.sensor.sensor_id)

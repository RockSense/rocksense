from gpio.wall import Wall
from gpio.hold import Hold
import time
import gpio.led
from typing import List
import xml.etree.ElementTree as ET
import board
import busio
from adafruit_mcp230xx.mcp23017 import MCP23017
from typing import List
from PySide2.QtCore import QObject, Signal, Property, Slot
import threading


class Wallmanager(QObject):
    wall_list: List[Wall] = []

    def __init__(self):
        QObject.__init__(self)
        Wallmanager.current_wall = Wall(3, 9, 3, "test", 0)
        Wallmanager.config_wall(Wallmanager.current_wall)

    @Slot()
    def shutdown_leds(self):
        gpio.led.all_led_off()

    @Slot(str)
    def set_current_wall(self, index):
        for wall in Wallmanager.wall_list:
            if index == 0:
                Wallmanager.current_wall = Wall(3, 9, 3, "prototyp", 0)
            elif index == 1:
                Wallmanager.current_wall = Wall(10, 20, 5, "standard", 1)
        print(Wallmanager.current_wall)

    @Slot()
    def start_startshow(self):  # startshow thread (to parallelize startshow and UI animation)
        startthread = threading.Thread(target=Wallmanager.startshow, daemon=True)  # Rainbow
        startthread.start()
        gpio.led.all_led_off()

    @staticmethod
    def startshow():  # select start show
        print("Startshow läuft")
        # gpio.led.colorWipe("red",0.08)  # Wipe color across display a pixel at a time with 0.08 s delay.
        # gpio.led.rainbow_cycle(0.001)  # Draw rainbow that uniformly distributes itself across all pixels with 1 ms
        gpio.led.theaterChaseRainbow(0.08)  # movie theater light style chaser animation with 0.08 s delay.

    @staticmethod
    def config_wall(wall: Wall):
        # config sensor port expander (16 ports)
        number_holds: int = wall.width * wall.height
        if number_holds % 16 == 0:
            needed_mcps: int = number_holds // 16
        else:
            needed_mcps: int = number_holds // 16 + 1

        # addresses of expander (hex-dez number can be configured with A0, A1 and A2 ports)
        addresses: List = [0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26]
        i2c = busio.I2C(board.SCL, board.SDA)
        mcps: List[MCP23017] = []
        count: int = 0
        while count < needed_mcps:
            mcps.append(MCP23017(i2c, addresses[count]))
            count += 1

        # set up holds
        i: int = 0  # hold id
        j: int = 0  # mcp id
        for x in range(wall.width):
            for y in range(wall.height):
                hold = Hold(i, x, y, mcps[j])
                wall.hold_list.append(hold)
                i += 1
                #  change mcp every 16 holds
                if i == (j + 1) * 16 - 1:
                    j += 1

        # holds' zone
        z: int = 1  # zone id
        while z <= wall.vertical_zones:
            for hold in wall.hold_list:
                if (z * wall.zone_edge) <= hold.x:
                    hold.zone += 1
            z += 1
        z: int = 1
        while z <= wall.horizontal_zones:
            for hold in wall.hold_list:
                if (z * wall.zone_edge) <= hold.y:
                    hold.zone += wall.vertical_zones
            z += 1

    @staticmethod
    def start_listener(hold_list):  # listener thread
        listenerthread = threading.Thread(target=Wallmanager.listener, args=(hold_list,), daemon=True)
        listenerthread.start()

    @staticmethod
    def listener(hold_list):  # listener for all given holds
        for hold in hold_list:
            hold.listener()

    @staticmethod
    def report_hold(hold: Hold):
        if hold.touched:
            print("Hold {} has been touched {} times.".format(hold.hold_id, hold.sensor.touches))
        else:
            print("Hold {} has not been touched.".format(hold.hold_id))

    def reset(hold_list):
        for hold in hold_list:
            hold.touched = False  # set hold untouched
            hold.sensor.touches = 0


if __name__ == "__main__":
    print("Welcome!")
    gpio.led.colorWipe("white", 0.08)
    gpio.led.all_led_off()
    test_wall = Wall(1, 8, 3, "test", 0)
    wallmanager = Wallmanager()
    wallmanager.config_wall(test_wall)
    wallmanager.start_listener(test_wall, 10)

    for hold in test_wall.hold_list:
        wallmanager.report_hold(hold)

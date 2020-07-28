from gpio.wall import Wall
from gpio.wallmanager import Wallmanager
import gpio.led

print("Welcome!")
gpio.led.all_led_off()
test_wall = Wall(1, 9, 3, "test", 0)
wallmanager = Wallmanager()
wallmanager.config_wall(test_wall)
wallmanager.start_listener(test_wall, 20)

for hold in test_wall.hold_list:
    wallmanager.report_hold(hold)
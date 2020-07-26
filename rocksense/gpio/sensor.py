import time
import board
import busio
from adafruit_mcp230xx.mcp23017 import MCP23017
import digitalio


class Sensor:
    touches: int

    def __init__(self, sensor_id: int, mcp: MCP23017):
        self.sensor_id = sensor_id
        # set Input
        self.pin = mcp.get_pin(sensor_id%15)  # 0-15
        # set count touches zero
        self.touches = 0

    def listener_setup(self):  # detect touch signal in specific sensor
        self.pin.direction = digitalio.Direction.INPUT
        self.pin.pull = digitalio.Pull.UP

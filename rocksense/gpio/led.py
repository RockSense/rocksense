import neopixel
import board
import time
import random
from typing import List

LED_COUNT = 30
LED_PIN = board.D18
pixels = neopixel.NeoPixel(LED_PIN, LED_COUNT)


class Led:
    colors = {
        'red': (255, 0, 0),
        'orange': (255, 128, 0),
        'yellow': (255, 255, 0),
        'green': (0, 255, 0),
        'lightblue': (0, 255, 255),
        'blue': (0, 0, 255),
        'violet': (128, 0, 255),
        'pink': (255, 0, 255),
        'magenta': (255, 0, 127),
        'white': (255, 255, 255)}

    def __init__(self, led_id: int):
        self.led_id = led_id
        self.color = None
        # set led off

    def led_on(self, color: str):  # light up specific LED in specific color
        pixels[self.led_id] = Led.colors[color]
        self.color = color

    def change_color(self):
        old_color = self.color
        color_list = list(Led.colors.keys())
        new_color = old_color
        while new_color == old_color:
            new_color = random.choice(color_list)
        self.led_on(new_color)

    def led_off(self):  # switch off specific LED
        pixels[self.led_id] = (0, 0, 0)
        pixels.show()


def all_led_off():  # switch off all LEDs
    pixels.fill((0, 0, 0))
    pixels.show()


def wheel(pos):
    # Input a value 0 to 255 to get a color value.
    # The colours are a transition r - g - b - back to r.
    if pos < 0 or pos > 255:
        r = g = b = 0
    elif pos < 85:
        r = int(pos * 3)
        g = int(255 - pos * 3)
        b = 0
    elif pos < 170:
        pos -= 85
        r = int(255 - pos * 3)
        g = 0
        b = int(pos * 3)
    else:
        pos -= 170
        r = 0
        g = int(pos * 3)
        b = int(255 - pos * 3)
    return r, g, b


def rainbowCycle(wait):  # wait = delay per step, e.g. 1ms = 0.001
    """Draw rainbow that uniformly distributes itself across all pixels."""
    for j in range(255):
        for i in range(LED_COUNT):
            pixel_index = (i * 256 // LED_COUNT) + j
            pixels[i] = wheel(pixel_index & 255)
        pixels.show()
        time.sleep(wait)


def colorWipe(color, wait):  # 50 / 1000
    """Wipe color across display a pixel at a time."""
    if color == "red":
        for i in range(LED_COUNT):
            pixels[i] = (255, 0, 0)
            pixels.show()
            time.sleep(wait)
    elif color == "green":
        for i in range(LED_COUNT):
            pixels[i] = (0, 255, 0)
            pixels.show()
            time.sleep(wait)
    elif color == "blue":
        for i in range(LED_COUNT):
            pixels[i] = (0, 0, 255)
            pixels.show()
            time.sleep(wait)
    elif color == "white":
        for i in range(LED_COUNT):
            pixels[i] = (255, 255, 255)
            pixels.show()
            time.sleep(wait)


def theaterChaseRainbow(wait):  # 50 / 1000
    """Rainbow movie theater light style chaser animation."""
    j: int = 1
    while j < 256:
        for q in range(3):
            for i in range(0, LED_COUNT, 3):
                pixels[i + q] = wheel((i + j) % 255)
            pixels.show()
            time.sleep(wait)
            for i in range(0, LED_COUNT, 3):
                pixels[i + q] = (0, 0, 0)
        j = j + 15  # j = color values, reduces time!


def blink(color: str):
    pixels.fill(Led.colors[color])
    pixels.show()
    time.sleep(0.2)
    all_led_off()
    time.sleep(0.2)
    pixels.fill(Led.colors[color])
    pixels.show()
    time.sleep(0.2)
    all_led_off()
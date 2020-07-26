# Sensor Klasse

## Konstruktor

```python
def __init__(self, sensor_id: int, mcp: MCP23017)
```

Jeder Sensor bekommt eine ID zugewiesen. Diese entspricht der ID seines Griffes und wird bei der Konfiguration der Boulder Wand generiert.
Die Sensoren werden über Port Expandern gebündelt an mehreren PINs eingelesen (MCP).

## Methoden
#### listener_setup
```python
def listener_setup(self)
```
Diese Funktion konfiguriert den Sensoreingang über den Port Expander. Dabei wird z.B. angegeben, dass die Sensoren einen ```INPUT``` liefern, und, dass ein ```PULL-UP``` Widerstand genutzt wird.
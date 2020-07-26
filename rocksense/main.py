# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2 import QtCore
from PySide2.QtCore import QStringListModel, QObject, Signal, Property
from PySide2 import QtQuick
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

from users.usermanager import Usermanager
from gpio.wallmanager import Wallmanager
from routemanager.routemanager import Routemanager
from gamemanager.gamemanager import Gamemanager

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.path.join(os.path.dirname(__file__), "ui/main.qml"))

    # wallmanager
    wallmanager = Wallmanager()
    engine.rootContext().setContextProperty("wallmanager", wallmanager)

    # loads Users
    usermanager = Usermanager()
    usermanager.load_users()
    usermanager.users_to_string_list()
    engine.rootContext().setContextProperty("userListModel", Usermanager.set_string_list_model(Usermanager.model))
    engine.rootContext().setContextProperty("usermanager", usermanager)


    # load Routes to RouteSelection
    routemanager = Routemanager()
    routemanager.load_xml_routes()
    routemanager.routes_to_string_list()
    engine.rootContext().setContextProperty("routeListModel", Routemanager.set_stringlistmodel(Routemanager.routelistmodel))
    engine.rootContext().setContextProperty("routemanager", routemanager)

    # load Games and Scores
    gamemanager = Gamemanager()
    gamemanager.load_xml_scores()
    gamemanager.load_xml_games()
    engine.rootContext().setContextProperty("gamemanager", gamemanager)


    # App starten
    if not engine.rootObjects():
        sys.exit(-1)
    app.exec_()
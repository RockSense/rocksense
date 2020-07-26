import sys

from PySide2.QtCore import QObject, Property, Slot, QStringListModel

import users.user
import xml.etree.ElementTree as ET


class Usermanager(QObject):

    user_string_list = []  # list of all usernames
    user_list: list = []  # list of all users
    current_user: users.user.User = None
    model = QStringListModel() # for UserSelection QML

    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.m_text = ""

    @Slot(str)
    def set_username(self, user_name):
        """
        creates a new user-object and adds it to all needed lists
        """
        users.user.add_user(user_name)  #adds User-Object
        Usermanager.user_string_list.append(user_name)  # appends User to user_string_list
        Usermanager.set_current_user(self, len(Usermanager.user_string_list) - 1)  #set new added user to current_user
        Usermanager.save_users()  # saves all Users to XML-file
        Usermanager.set_string_list_model(Usermanager.model)  # exposes new User to QStringListModel

    @Slot(str)
    def set_current_user(self, index): # sets the current_user
        for user in Usermanager.user_list:
            if Usermanager.user_string_list[int(index)] == user.firstname:
                Usermanager.current_user = user

        print('Selected User: ' + Usermanager.current_user.firstname)

    @Slot(result=str)
    def show_current_user_name(self): # shows current_user to QML
        return Usermanager.current_user.firstname

    @staticmethod
    def set_string_list_model(model): # exposes all usernames to StringListModel in QML UserSelection
        model.setStringList(Usermanager.user_string_list)
        return model

    @staticmethod
    def users_to_string_list(): # exports users form user_list to user_string_list
        for entry in Usermanager.user_list:
            Usermanager.user_string_list.append(entry.firstname)

    @staticmethod
    def load_users():
        """
        reads all user data from xml-document
        """
        user_file = 'users/users.xml'  # in case file can't be read, change path
        try:
            tree = ET.parse(user_file)
            root = tree.getroot()
            root.find('user')
            for child in root.findall('user'):
                firstn = child.find('firstname').text
                idn = child.find('id').text
                new_user = users.user.User(firstn, idn)
                print(new_user.firstname + ' added.')
        except IOError:
            print('Could not read file. Creating a new one when saving.')


    @staticmethod
    def save_users():
        """
        creates a nice and structured xml-document with all user data
        """
        user_file = 'users/users.xml'
        data = ET.Element('users')
        for user_data in Usermanager.user_list:
            userdata = ET.SubElement(data, 'user')
            firstname = ET.SubElement(userdata, 'firstname')
            firstname.text = user_data.firstname
            id_number = ET.SubElement(userdata, 'id')
            id_number.text = str(user_data.id_number)
        mydata = ET.tostring(data, encoding='unicode')
        myfile = open(user_file, 'w')
        myfile.write(mydata)
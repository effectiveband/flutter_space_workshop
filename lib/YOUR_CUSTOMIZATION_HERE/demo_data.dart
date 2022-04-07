import 'package:flutter/material.dart';

class UserData {
  final String photoAsset;
  final String description;
  // You can add some fields that you want

  final UniqueKey key = UniqueKey();

  UserData(this.photoAsset, this.description);
}

class DemoData {
  static final List<UserData> _users = [
    UserData('assets/images/sveta.jpeg',
        'Всем привет, меня зовут Света! Я Expertize Lead в команде Flutter в компании Effective. Давайте вместе познавать Flutter!'),
    UserData('assets/images/roma.jpeg',
        'Привет, меня зовут Рома. Я очень люблю программировать приложения на Flutter! Являюсь разработчиком в компании Effective'),
    UserData('assets/images/marina.jpeg',
        'Привет, меня зовут Марина! Я участник команды Flutter в компании Effective. Я умею создавать крутые приложения используя Flutter'),
    UserData('assets/images/bird.jpeg',
        'Я Дэш. Давай учиться программировать на Flutter вместе <3')
  ];

  List<UserData> get users => _users;
}

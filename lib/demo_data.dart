import 'package:flutter/material.dart';

class ConstellationData {
  final String title;
  final String subTitle;
  final String image;

  final UniqueKey key = UniqueKey();

  ConstellationData(this.title, this.subTitle, this.image);
}

class UserData {
  final String photoAsset;
  final String description;
  // You can add some fields that you want

  final UniqueKey key = UniqueKey();

  UserData(this.photoAsset, this.description);
}

class DemoData {
  static final List<UserData> _users = [
    UserData('assets/images/vk.jpeg',
        'I am 19 years old. I have been programming on Flutter for almost 3 years =)'),
    UserData('assets/images/bird.jpeg',
        'I am Flutter maskot. You can learn Flutter with me <3')
  ];

  List<UserData> get users => _users;
}

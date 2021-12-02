import 'package:flutter/material.dart';
import 'package:workshop_template/demo_data.dart';

//This code if fully customizable
class UserHeroCard extends StatelessWidget {
  final UserData userData;

  const UserHeroCard({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: '${userData.key} ${userData.photoAsset}',
        //You can change child (e.g. you text, or icon, or couple of widgets)
        child: SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            userData.photoAsset,
            fit: BoxFit.cover,
          ),
        ));
  }
}

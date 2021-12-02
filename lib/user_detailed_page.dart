import 'package:flutter/material.dart';
import 'package:workshop_template/demo_data.dart';
import 'package:workshop_template/user_hero_card.dart';

//This code if fully customizable
class UserDetailedPage extends StatelessWidget {
  static String route = 'detailed';
  final Function() backTap;
  final UserData userData;

  const UserDetailedPage(
      {Key? key, required this.backTap, required this.userData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //You can change button style if you want
    final ButtonStyle backButtonStyle = ElevatedButton.styleFrom(
        primary: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10))));

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24),
        width: 600,
        child: Column(
          children: [
            UserHeroCard(
              userData: userData,
            ),

            // Here is your code about yourself

            // -----------------

            ElevatedButton(
              onPressed: backTap,
              child: const Text('Back to home'),
              style: backButtonStyle,
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:workshop_template/YOUR_CUSTOMIZATION_HERE/demo_data.dart';
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
    final Color borderColor = Theme.of(context).colorScheme.primary;

    final ButtonStyle backButtonStyle = ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))));

    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 24),
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      transform: const GradientRotation(math.pi / -4),
                      stops: const [
                        0.0,
                        0.5,
                        0.5,
                        1
                      ],
                      colors: [
                        primaryColor,
                        primaryColor,
                        secondaryColor,
                        secondaryColor
                      ])),
              child: Column(
                children: [
                  Row(
                    children: [
                      UserHeroCard(
                        userData: userData,
                        isOnDetailedPage: true,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          userData.description,
                        ),
                      ),
                    ],
                  ),

                  //Here is your code

                  //-----------------

                  ElevatedButton(
                    onPressed: backTap,
                    child: Text(
                      'Вернуться к списку',
                      style: TextStyle(color: primaryColor),
                    ),
                    style: backButtonStyle,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}

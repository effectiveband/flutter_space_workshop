import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:workshop_template/YOUR_CUSTOMIZATION_HERE/demo_data.dart';
import 'package:workshop_template/YOUR_CUSTOMIZATION_HERE/star_loader.dart';
import 'package:workshop_template/user_hero_card.dart';

//This code if fully customizable
class UserDetailedPage extends StatefulWidget {
  static String route = 'detailed';
  final Function() backTap;
  final UserData userData;

  const UserDetailedPage(
      {Key? key, required this.backTap, required this.userData})
      : super(key: key);

  @override
  State<UserDetailedPage> createState() => _UserDetailedPageState();
}

class _UserDetailedPageState extends State<UserDetailedPage>
    with SingleTickerProviderStateMixin {
  Color get primaryColor => Theme.of(context).colorScheme.primary;
  Color get secondaryColor => Theme.of(context).colorScheme.secondary;
  Color get borderColor => Theme.of(context).colorScheme.primary;

  bool isFrontSideShowed = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isFrontSideShowed = !isFrontSideShowed),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _buildFlipTransion,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: isFrontSideShowed ? _buildFrontCard() : _buildBackCard(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget _buildFlipTransion(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(isFrontSideShowed) != widget?.key);
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFrontCard() {
    final ButtonStyle backButtonStyle = ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))));
    return Align(
      key: const ValueKey(true),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 600,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    UserHeroCard(
                      userData: widget.userData,
                      isOnDetailedPage: true,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        widget.userData.description,
                      ),
                    ),
                  ],
                ),

                //Here is your code

                //-----------------

                ElevatedButton(
                  onPressed: widget.backTap,
                  child: Text(
                    'Вернуться к списку',
                    style: TextStyle(color: primaryColor),
                  ),
                  style: backButtonStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Align(
      key: const ValueKey(false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 200,
              width: 600,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      transform: GradientRotation(math.pi / 4),
                      colors: [Color(0xFF28313b), Color(0xFF485461)])),
              child: const SizedBox(
                height: 200,
                width: 600,
                child: StarField(),
              )),
        ],
      ),
    );
  }
}

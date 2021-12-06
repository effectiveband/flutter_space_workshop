import 'package:workshop_template/YOUR_CUSTOMIZATION_HERE/demo_data.dart';
import 'package:workshop_template/user_hero_card.dart';

import 'package:flutter/material.dart';

class UserListRenderer extends StatefulWidget {
  final int index;
  final Function(UserData) onTap;
  final double hzPadding;
  final UserData userData;

  const UserListRenderer(
      {Key? key,
      this.index = 0,
      required this.onTap,
      this.hzPadding = 0,
      required this.userData})
      : super(key: key);

  @override
  _UserListRendererState createState() => _UserListRendererState();
}

class _UserListRendererState extends State<UserListRenderer> {
  @override
  Widget build(BuildContext context) {
    double leftPadding = widget.index % 2 == 0 ? 0 : widget.hzPadding;
    double rightPadding = widget.index % 2 == 0 ? widget.hzPadding : 0;
    double vtPadding = 24;
    return GestureDetector(
      onTap: () => _handleTap(),
      child: Container(
          padding: EdgeInsets.only(
              top: vtPadding,
              bottom: vtPadding,
              left: leftPadding,
              right: rightPadding),
          alignment: widget.index % 2 == 0
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: UserHeroCard(
            userData: widget.userData,
            isOnDetailedPage: false,
          )),
    );
  }

  void _handleTap() {
    widget.onTap(widget.userData);
  }
}

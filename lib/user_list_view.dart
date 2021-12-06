import 'YOUR_CUSTOMIZATION_HERE/demo_data.dart';
import 'user_list_renderer.dart';
import 'styles.dart';
import 'package:flutter/material.dart';

class UserListView extends StatefulWidget {
  static const route = "UserListView";

  final List<UserData> users;
  final void Function(double) onScrolled;
  final void Function(UserData) onItemTap;
  final void Function() onSettingsButtonTap;

  const UserListView(
      {Key? key,
      required this.onScrolled,
      required this.onItemTap,
      required this.users,
      required this.onSettingsButtonTap})
      : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  double _prevScrollPos = 0;
  double _scrollVel = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: 600,
        child: Stack(
          children: [
            _buildScrollingList(),
            _buildGradientOverlay(),
            _buildHeaderText(),
            _buildSettingsButton()
          ],
        ),
      ),
    );
  }

  Widget _buildScrollingList() {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 150, bottom: 200),
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            return UserListRenderer(
              onTap: widget.onItemTap,
              index: index,
              userData: widget.users[index],
            );
          },
        ),
      ),
    );
  }

  // May be customizable
  Widget _buildHeaderText() {
    return const Positioned(
      width: 180,
      left: 16,
      top: 16,
      child: Text(
        "FLUTTER EFFECTIVE TEAM",
        style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: Fonts.header,
            height: 1.05),
      ),
    );
  }

  // May be customizable
  Widget _buildGradientOverlay() {
    double firstGradientStop = .2;
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: const [
          Colors.black,
          Color(0x00000000),
          Color(0x00000000),
          Colors.black
        ], stops: [
          0,
          firstGradientStop,
          1 - firstGradientStop,
          1
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      ),
    );
  }

  // May be customizable
  Positioned _buildSettingsButton() {
    final ButtonStyle settingsButtonStyle = ElevatedButton.styleFrom(
        primary: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(10))));
    return Positioned(
        right: 16,
        top: 12,
        child: ElevatedButton(
            onPressed: widget.onSettingsButtonTap,
            style: settingsButtonStyle,
            child: const Text('Настройки')));
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    _scrollVel = notification.metrics.pixels - _prevScrollPos;
    widget.onScrolled(_scrollVel);
    _prevScrollPos = notification.metrics.pixels;
    return true;
  }
}

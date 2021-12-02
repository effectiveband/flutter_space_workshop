import 'demo_data.dart';
import 'user_list_renderer.dart';
import 'styles.dart';
import 'package:flutter/material.dart';

class UserListView extends StatefulWidget {
  static const route = "UserListView";

  final List<UserData> users;
  final void Function(double) onScrolled;
  final void Function(UserData) onItemTap;

  const UserListView(
      {Key? key,
      required this.onScrolled,
      required this.onItemTap,
      required this.users})
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
            _buildLocationText()
          ],
        ),
      ),
    );
  }

  Widget _buildScrollingList() {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
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
    );
  }

  // May be customizable
  Widget _buildHeaderText() {
    return const Positioned(
      width: 180,
      left: 16,
      top: 16,
      child: Text(
        "ABOUT YOURSELF",
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
  Positioned _buildLocationText() {
    return const Positioned(
      width: 120,
      right: 16,
      top: 12,
      child: Text(
        "New York City (USA, NY) 40.71 °N - 74.01 °W",
        textAlign: TextAlign.right,
        style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontFamily: Fonts.content,
            height: 1.8),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    _scrollVel = notification.metrics.pixels - _prevScrollPos;
    widget.onScrolled(_scrollVel);
    _prevScrollPos = notification.metrics.pixels;
    return true;
  }
}

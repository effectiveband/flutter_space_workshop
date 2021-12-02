import 'package:workshop_template/user_detailed_page.dart';

import 'demo_data.dart';
import 'star_field/star_field.dart';
import 'widgets/fade_route_builder.dart';
import 'widgets/nested_navigator.dart';
import 'user_list_view.dart';

import 'package:flutter/material.dart';

class ConstellationsListDemo extends StatefulWidget {
  const ConstellationsListDemo({Key? key}) : super(key: key);

  @override
  _ConstellationsListDemoState createState() => _ConstellationsListDemoState();
}

class _ConstellationsListDemoState extends State<ConstellationsListDemo>
    with TickerProviderStateMixin {
  static const double idleSpeed = .2;
  static const double maxSpeed = 10;
  static const int starAnimDurationIn = 4500;

  //double _speed = idleSpeed;
  final GlobalKey<NavigatorState> _navigationStackKey =
      GlobalKey<NavigatorState>();

  final ValueNotifier<double> _speedValue = ValueNotifier(idleSpeed);

  late AnimationController _starAnimController;
  late Animation<double> _starAnimSequence;

  late List<UserData> _userData;

  @override
  void initState() {
    _userData = DemoData().users;
    _starAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: starAnimDurationIn),
      reverseDuration: const Duration(milliseconds: starAnimDurationIn ~/ 3),
    );
    _starAnimController.addListener(() {
      _speedValue.value = _starAnimSequence.value;
    });

    _starAnimSequence = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: idleSpeed, end: -2)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -2, end: 20)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 20, end: 0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      )
    ]).animate(_starAnimController);
    super.initState();
  }

  @override
  void dispose() {
    _starAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int starCount = 400;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ValueListenableBuilder<double>(
            valueListenable: _speedValue,
            builder: (context, value, child) {
              return StarField(starSpeed: value, starCount: starCount);
            },
          ),
          SafeArea(
            child: NestedNavigator(
              navKey: _navigationStackKey,
              routeBuilder: _buildPageRoute,
              onBackPop: _reverseStarAnim,
            ),
          ),
        ],
      ),
    );
  }

  Route _buildPageRoute(RouteSettings route) {
    Widget page;
    if (route.name == UserDetailedPage.route) {
      final userData = route.arguments as UserData;
      page = UserDetailedPage(
        userData: userData,
        backTap: () {
          _navigationStackKey.currentState?.pop();
          _reverseStarAnim();
        },
      );
    } else {
      page = UserListView(
        users: _userData,
        onItemTap: _onItemTap,
        onScrolled: _handleListScroll,
      );
    }
    return FadeRouteBuilder(page: page);
  }

  void _onItemTap(UserData userData) {
    _navigationStackKey.currentState
        ?.pushNamed(UserDetailedPage.route, arguments: userData);
    _starAnimController.forward(from: 0);
  }

  void _handleListScroll(delta) {
    setState(() {
      if (delta == 0) {
        _speedValue.value = idleSpeed;
      } else {
        _speedValue.value = delta.clamp(-maxSpeed, maxSpeed);
      }
    });
  }

  void _reverseStarAnim() {
    if (_starAnimController.isAnimating) {
      _starAnimController.reverse();
    } else {
      _speedValue.value = idleSpeed;
    }
  }
}

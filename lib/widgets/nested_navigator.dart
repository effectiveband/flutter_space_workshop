import 'package:flutter/material.dart';

class NestedNavigator extends StatefulWidget {
  final Route Function(RouteSettings route) routeBuilder;
  final GlobalKey<NavigatorState> navKey;
  final Function onBackPop;

  const NestedNavigator(
      {Key? key,
      required this.routeBuilder,
      required this.navKey,
      required this.onBackPop})
      : super(key: key);

  @override
  _NestedNavigatorState createState() => _NestedNavigatorState();
}

class _NestedNavigatorState extends State<NestedNavigator> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigatorState navigator = widget.navKey.currentState!;
        if (navigator.canPop()) {
          widget.onBackPop();
          return false;
        }
        return true;
      },
      child: Navigator(
        key: widget.navKey,
        onGenerateRoute: (routeSettings) => widget.routeBuilder(routeSettings),
        observers: [
          HeroController(
            createRectTween: (begin, end) =>
                MaterialRectArcTween(begin: begin, end: end),
          )
        ],
      ),
    );
  }
}

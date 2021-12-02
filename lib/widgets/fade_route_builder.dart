import 'package:flutter/material.dart';

class FadeRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final int duration;

  FadeRouteBuilder({required this.page, this.duration = 1000})
      : super(
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
                opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 1, end: 0)
                      .animate(secondaryAnimation),
                  child: child,
                ));
          },
        );
}

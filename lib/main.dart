import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/env.dart';

import 'demo.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  static const String _pkg = 'constellations_list';

  const App({Key? key}) : super(key: key);
  static String get pkg => Env.getPackage(_pkg);
  static String get bundle => Env.getBundle(_pkg);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: const []);
    return const MaterialApp(
      home: ConstellationsListDemo(),
    );
  }
}

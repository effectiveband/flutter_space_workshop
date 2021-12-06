import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared/env.dart';
import 'package:workshop_template/settings/settings_controller.dart';

import 'demo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: const []);
    return ChangeNotifierProvider<SettingsController>(
      create: (context) => SettingsController(),
      child: Builder(
        builder: (context) {
          final SettingsController settingsController =
              Provider.of<SettingsController>(context, listen: true);
          return MaterialApp(
            theme: settingsController.themeData,
            home: const ConstellationsListDemo(),
          );
        },
      ),
    );
  }
}

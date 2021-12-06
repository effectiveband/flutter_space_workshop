import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:workshop_template/settings/planet_theme.dart';
import 'package:workshop_template/settings/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  static String route = 'settings';
  final Function() backTap;

  const SettingsPage({Key? key, required this.backTap}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<PlanetTheme> planetThemes;
  late PlanetTheme _currentTheme;
  late SettingsController _settingsController;

  @override
  void initState() {
    _settingsController = context.read();
    planetThemes = Themes().planetThemes;
    _currentTheme = planetThemes
        .where((theme) => theme.themeData == _settingsController.themeData)
        .first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 24),
        width: 600,
        child: Column(
          children: [
            backButton,
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 170,
              width: 350,
              child: GridView.count(
                crossAxisCount: 4,
                children: planets,
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateTheme(PlanetTheme theme) {
    _settingsController.updateTheme(theme.themeData);
    setState(() {
      _currentTheme = theme;
    });
  }

  List<Widget> get planets {
    List<Widget> planets = [];
    for (PlanetTheme planetTheme in planetThemes) {
      planets.add(InkWell(
        onTap: () => updateTheme(planetTheme),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                color: _currentTheme == planetTheme
                    ? Colors.white
                    : Colors.transparent,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
            height: 85,
            width: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  planetTheme.assetPath,
                  height: 50,
                  width: 50,
                ),
                Text(
                  planetTheme.name,
                  style: TextStyle(
                      color: _currentTheme == planetTheme
                          ? Colors.black
                          : Colors.white),
                )
              ],
            ),
          ),
        ),
      ));
    }
    return planets;
  }

  Widget get backButton {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(25)),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.transparent,
          child: IconButton(
              onPressed: widget.backTap,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}

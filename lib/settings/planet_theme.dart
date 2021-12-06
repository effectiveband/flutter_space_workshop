import 'package:flutter/material.dart';
import 'package:workshop_template/theme/theme.dart';

class PlanetTheme {
  final String name;
  final String assetPath;
  final ThemeData themeData;

  PlanetTheme(this.name, this.assetPath, this.themeData);
}

class Themes {
  static final List<PlanetTheme> _planetThemes = [
    PlanetTheme('Меркурий', 'assets/planets/mercury.png', mercuryTheme),
    PlanetTheme('Венера', 'assets/planets/venus.png', venusTheme),
    PlanetTheme('Земля', 'assets/planets/earth.png', earthTheme),
    PlanetTheme('Марс', 'assets/planets/mars.png', marsTheme),
    PlanetTheme('Юпитер', 'assets/planets/jupiter.png', jupiterTheme),
    PlanetTheme('Сатурн', 'assets/planets/saturn.png', saturnTheme),
    PlanetTheme('Уран', 'assets/planets/uranus.png', uranusTheme),
    PlanetTheme('Нептун', 'assets/planets/neptune.png', neptuneTheme),
  ];

  List<PlanetTheme> get planetThemes => _planetThemes;
}

import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/util/platform.dart';

class SettingsProvider extends ChangeNotifier {
  late bool _darkTheme;
  late int _animationSpeed;
  late Platform _platform;

  bool get darkTheme => _darkTheme;

  Platform get platform => _platform;

  int get animationSpeed => _animationSpeed;

  SettingsProvider({required bool isDarkTheme}) {
    _darkTheme = isDarkTheme;
    _animationSpeed = 2;
  }

  void switchTheme() {
    _darkTheme = !darkTheme;
    notifyListeners();
  }

  void increaseAnimationSpeed() {
    _animationSpeed += 1;
    notifyListeners();
  }

  void decreaseAnimationSpeed() {
    _animationSpeed -= 1;
    notifyListeners();
  }

  void setPlatform(Platform platform) {
    _platform = platform;
    notifyListeners();
  }
}

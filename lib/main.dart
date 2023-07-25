import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen.dart';
import 'package:surf_practice_magic_ball/util/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>(
      create: (BuildContext context) {
        return SettingsProvider(isDarkTheme: true);
      },
      child: Consumer<SettingsProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Magic Ball',
            debugShowCheckedModeBanner: false,
            theme: value.darkTheme
                ? ThemeData(
                    scaffoldBackgroundColor: const Color(0xFF0A112F),
                  )
                : ThemeData(
                    scaffoldBackgroundColor: const Color(0x61DAB7FF),
                  ),
            home: MagicBallScreen(),
          );
        },
      ),
    );
  }
}

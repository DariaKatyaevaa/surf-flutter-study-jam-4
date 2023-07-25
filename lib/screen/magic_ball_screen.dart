import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surf_practice_magic_ball/network/magic_ball_api_client.dart';
import 'package:surf_practice_magic_ball/widget/magic_ball_widget.dart';
import 'package:surf_practice_magic_ball/util/platform.dart';

import '../util/settings_provider.dart';

class MagicBallScreen extends StatelessWidget {
  final _apiClient = MagicBallApiClient();
  final Platform _platform = detectPlatform();

  MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: true);
    settings.setPlatform(_platform);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => _showSettings(context, settings),
                      icon: Icon(
                        Icons.settings_rounded,
                        size: 32.0,
                        color: settings.darkTheme ? Colors.white70 : const Color(0xFF6C698C),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: settings.switchTheme,
                        icon: Icon(
                          settings.darkTheme ? Icons.nightlight_round : Icons.sunny,
                          size: 32.0,
                          color: settings.darkTheme ? Colors.white70 : const Color(0xFF6C698C),
                        )),
                  )
                ],
              ),
              MagicBall(askBallQuestionCallback: _apiClient.askQuestion),
              const SizedBox(height: 64.0),
              Text(
                _platform.getExplanatoryMessage(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: settings.darkTheme ? const Color(0xB5FFFFFF) : const Color(0xFF6C698C),
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettings(
    BuildContext context,
    SettingsProvider provider,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  const Text('animetion speed:'),
                  TextButton(onPressed: provider.increaseAnimationSpeed, child: const Text('+')),
                  TextButton(onPressed: provider.decreaseAnimationSpeed, child: const Text('-')),
                ])
              ],
            ),
          );
        });
  }
}

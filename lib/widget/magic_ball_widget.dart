import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/models/magic_ball_response.dart';
import 'package:surf_practice_magic_ball/util/platform.dart';
import 'package:surf_practice_magic_ball/widget/magic_ball_shadow_widget.dart';

import '../util/settings_provider.dart';

typedef AskBallQuestionCallback = Future<MagicBallResponse?> Function();

class MagicBall extends StatefulWidget {
  final AskBallQuestionCallback askBallQuestionCallback;

  const MagicBall({
    Key? key,
    required this.askBallQuestionCallback,
  }) : super(key: key);

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> with TickerProviderStateMixin {
  bool _tapBall = false;
  String _ballAnswer = '';
  bool _isRed = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    ShakeDetector shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: _onTapOrShakeBall,
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: true);

    final size = Size.square(MediaQuery.of(context).size.shortestSide - 2 * 64.0);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: _onTapOrShakeBall,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(settings.darkTheme ? 'assets/images/ball.png' : 'assets/images/ball_light.png',
              width: size.width),
          if (settings.darkTheme)
            Image.asset(
              'assets/images/star.png',
              width: size.width * 0.55,
            ),
          Image.asset('assets/images/small_star.png', width: size.width * 0.65),
          if (_tapBall)
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.horizontal,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isRed && _ballAnswer.isEmpty)
                    Image.asset(
                      'assets/images/red_shadow.png',
                      width: size.width * 0.7,
                      height: size.width,
                    ),
                  if (!_isRed)
                    Image.asset(
                      settings.darkTheme ? 'assets/images/dark_shadow.png' : 'assets/images/light_shadow.png',
                      width: size.width * 0.7,
                      height: size.width,
                    ),
                  Text(
                    _ballAnswer,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: settings.platform.getTextSize(),
                      color: settings.darkTheme ? Colors.white : const Color(0xFF6C698C),
                    ),
                  ),
                ],
              ),
            ),
          MagicBallShadow(
            width: size.width * 0.4,
            height: size.width,
            blurRadius: 16.0,
            color: _isRed
                ? const Color(0xFFE71515)
                : settings.darkTheme
                    ? const Color(0xFF02D0D1)
                    : const Color(0xFFCBBFFF),
          ),
          MagicBallShadow(
            width: size.width * 0.7,
            blurRadius: size.width * 0.5,
            height: size.width,
            color: settings.darkTheme ? const Color(0xff0800ff) : const Color(0xFF3700FF),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapOrShakeBall() async {
    final deleteAnswer = _tapBall == true && _isRed;
    setState(() {
      _tapBall = !_tapBall;
      _ballAnswer = '';
      _isRed = false;
    });
    if (deleteAnswer) return;
    _toggleContainer();
    final response = await widget.askBallQuestionCallback();
    setState(() {
      _ballAnswer = response != null ? response.reading : '';
      _isRed = response == null;
    });
  }

  void _toggleContainer() {
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateTo(0, duration: const Duration(seconds: 1));
    }
  }
}

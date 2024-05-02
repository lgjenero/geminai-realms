import 'dart:async';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/screens/menu/menu.dart';
import 'package:geminai_realms/services/user/user_service.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/sizes.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final _userLoaded = Completer<void>();
  final _musicLoaded = Completer<void>();

  @override
  void initState() {
    super.initState();
    ref.listenManual(
      userServiceProvider.select((e) => e.loaded),
      (_, loaded) {
        if (loaded && !_userLoaded.isCompleted) {
          _userLoaded.complete();
        }
      },
      fireImmediately: true,
    );

    FlameAudio.bgm.initialize();
    Future.wait([
      FlameAudio.audioCache.load('intro.mp3'),
      FlameAudio.audioCache.load('fantasy.mp3'),
      FlameAudio.audioCache.load('cyberpunk.mp3'),
      FlameAudio.audioCache.load('greek.mp3'),
    ]).then((value) => _musicLoaded.complete());

    if (!kIsWeb) _menu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gameBackground,
      body: SizeLayoutBuilder(
        small: (context, child) => _buildLayout(context, child, SizeLayout.small),
        medium: (context, child) => _buildLayout(context, child, SizeLayout.medium),
        large: (context, child) => _buildLayout(context, child, SizeLayout.large),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, Widget? child, SizeLayout size) {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: Image.asset(
              'assets/images/app_icon.png',
              width: AppSizes.splashIcon(size).width,
              height: AppSizes.splashIcon(size).height,
            ),
          ),
        ),
        if (kIsWeb)
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Center(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.gameForeground,
                  foregroundColor: AppColors.gameBackground,
                  textStyle: AppFonts.instance.gameButton(size),
                ),
                onPressed: _menu,
                child: const Text('Enter'),
              ),
            ),
          ),
      ],
    );
  }

  void _menu() async {
    await _userLoaded.future;
    if (!mounted) return;
    await _musicLoaded.future;
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MenuScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var fadeAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: fadeAnimation,
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }
}

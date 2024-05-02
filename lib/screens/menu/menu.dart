import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/screens/game/game.dart';
import 'package:geminai_realms/screens/menu/widgets/menu_content.dart';
import 'package:geminai_realms/screens/menu/widgets/profile_button.dart';
import 'package:geminai_realms/utils/constants/colors.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  AudioPlayer? _audioPlayer;
  bool _playMusic = false;

  @override
  void initState() {
    super.initState();
    FlameAudio.loopLongAudio('intro.mp3', volume: 0.1).then((player) {
      if (!mounted) {
        player.stop();
        return;
      }
      _audioPlayer = player;
      if (_playMusic) {
        _audioPlayer?.resume();
      } else {
        _audioPlayer?.pause();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shouldPlayMusic = ModalRoute.of(context)?.isCurrent == true;
    if (shouldPlayMusic != _playMusic) {
      _playMusic = shouldPlayMusic;
      if (_playMusic) {
        _audioPlayer?.resume();
      } else {
        _audioPlayer?.pause();
      }
    }

    return Scaffold(
        backgroundColor: AppColors.gameBackground,
        body: Stack(
          children: [
            Positioned.fill(
              child: MenuContent(
                onStartGame: () => _start(context),
                onContinueGame: (slot) => _start(context, slot: slot),
              ),
            ),
            const Positioned(
              top: 8,
              right: 8,
              child: SafeArea(child: ProfileButton()),
            )
          ],
        ));
  }

  void _start(BuildContext context, {String? slot}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => GameScreen(loadSlot: slot),
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
    );
  }
}

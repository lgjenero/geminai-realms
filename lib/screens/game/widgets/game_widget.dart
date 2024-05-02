import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/game/data/game_data.dart';
import 'package:geminai_realms/game/data/game_state_data.dart';
import 'package:geminai_realms/game/state/game_state.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/settings_widget.dart';
import 'package:geminai_realms/screens/game/widgets/choose_length_widget.dart';
import 'package:geminai_realms/screens/game/widgets/choose_realm_widget.dart';
import 'package:geminai_realms/screens/game/widgets/game_play_widget.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/realms.dart';

class GameWidget extends ConsumerWidget {
  const GameWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(gameStateProvider.select((e) => e.status));

    final Widget content;
    switch (status) {
      case GameStatus.loading:
        content = const Center(child: CircularProgressIndicator(color: AppColors.gameForeground));
        break;
      case GameStatus.chooseRealm:
        content = ChooseRealmWidget(onRealmSelected: (realm) => _selectRealm(ref, realm));
        break;
      case GameStatus.chooseLength:
        content = ChooseLengthWidget(onLengthSelected: (length) => _selectLength(ref, length));
      case GameStatus.ready:
      case GameStatus.playing:
      case GameStatus.died:
      case GameStatus.gameOver:
        content = const GamePlayWidget();
        break;
      default:
        content = const SizedBox();
        break;
    }

    return Stack(
      children: [
        Positioned.fill(child: content),
        Positioned(
          top: 8,
          right: 8,
          child: SafeArea(
            left: false,
            bottom: false,
            child: FilledButton(
              onPressed: () => _settings(context),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gameForeground,
                shape: const CircleBorder(),
              ),
              child: const Icon(Icons.settings, color: AppColors.gameBackground),
            ),
          ),
        ),
      ],
    );
  }

  void _selectRealm(WidgetRef ref, AppRealms realm) {
    AppFonts.instance.setRealm(realm);
    ref.read(gameStateProvider.notifier).initializeRealm(realm);
  }

  void _selectLength(WidgetRef ref, GameLength length) {
    ref.read(gameStateProvider.notifier).initializeLength(length);
    ref.read(gameStateProvider.notifier).getIntro();
  }

  void _settings(BuildContext context) {
    SettingsDialog.show(context, onQuit: () {
      Navigator.of(context).pop();
    });
  }
}

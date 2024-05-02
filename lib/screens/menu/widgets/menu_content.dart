import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/login_dialog.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/saves_dialog.dart';
import 'package:geminai_realms/services/auth/auth_service.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/sizes.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class MenuContent extends ConsumerWidget {
  const MenuContent({this.onStartGame, this.onContinueGame, super.key});

  final void Function()? onStartGame;
  final void Function(String slot)? onContinueGame;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizeLayoutBuilder(
      small: (context, child) => _buildLayout(context, ref, SizeLayout.small),
      medium: (context, child) => _buildLayout(context, ref, SizeLayout.medium),
      large: (context, child) => _buildLayout(context, ref, SizeLayout.large),
    );
  }

  Widget _buildLayout(BuildContext context, WidgetRef ref, SizeLayout size) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'GeminAI Realms',
              style: AppFonts.instance.gameTitle(size).copyWith(color: AppColors.gameForeground),
            ),
          ),
          SizedBox(
              height: size == SizeLayout.small
                  ? 20
                  : size == SizeLayout.medium
                      ? 40
                      : 60),
          _buildButtons(context, ref, size),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context, WidgetRef ref, SizeLayout size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.gameForeground,
            foregroundColor: AppColors.gameBackground,
            fixedSize: AppSizes.button(size),
            textStyle: AppFonts.instance.gameButton(size),
          ),
          onPressed: () => onStartGameTap(context, ref),
          child: const Text('Start Game'),
        ),
        const SizedBox(height: 16),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.gameForeground,
            foregroundColor: AppColors.gameBackground,
            fixedSize: AppSizes.button(size),
            textStyle: AppFonts.instance.gameButton(size),
          ),
          onPressed: () => _onContinueGameTap(context),
          child: const Text('Continue Game'),
        ),
      ],
    );
  }

  void _onContinueGameTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          Widget buildDialog(SizeLayout size) => SavesDialog(
              size: size,
              showEmpty: false,
              onBack: () => Navigator.pop(context),
              onSelect: (slot) {
                Navigator.pop(context);
                onContinueGame?.call(slot);
              });

          return Material(
            type: MaterialType.transparency,
            child: Center(
              child: SizeLayoutBuilder(
                small: (_, __) => buildDialog(SizeLayout.small),
                medium: (_, __) => buildDialog(SizeLayout.medium),
                large: (_, __) => buildDialog(SizeLayout.large),
              ),
            ),
          );
        });
  }

  void onStartGameTap(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.read(authServiceProvider).isLoggedIn();
    if (!isLoggedIn) {
      LoginDialog.show(
        context,
        onLogin: () {
          Navigator.pop(context);
          onStartGame?.call();
        },
        onBack: () => Navigator.pop(context),
      );
    } else {
      onStartGame?.call();
    }
  }
}

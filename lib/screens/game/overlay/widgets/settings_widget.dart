import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/game/state/game_state.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/saves_dialog.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/sizes.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class SettingsDialog extends ConsumerStatefulWidget {
  final SizeLayout size;
  final VoidCallback? onQuit;

  const SettingsDialog({required this.size, this.onQuit, super.key});

  @override
  ConsumerState<SettingsDialog> createState() => _SettingsDialogState();

  static void show(BuildContext context, {VoidCallback? onQuit}) {
    Widget buildLoginContent(SizeLayout size, {VoidCallback? onQuit}) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: SettingsDialog(
            size: size,
            onQuit: onQuit,
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => SizeLayoutBuilder(
        small: (_, __) => buildLoginContent(SizeLayout.small, onQuit: onQuit),
        medium: (_, __) => buildLoginContent(SizeLayout.medium, onQuit: onQuit),
        large: (_, __) => buildLoginContent(SizeLayout.large, onQuit: onQuit),
      ),
    );
  }
}

class _SettingsDialogState extends ConsumerState<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.gameForeground,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      constraints: BoxConstraints.tightFor(width: AppSizes.message(widget.size).width),
      padding: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Settings',
                  style: AppFonts.instance.gameMenuText(widget.size).copyWith(color: AppColors.gameBackground)),
              const SizedBox(height: 32),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.gameBackground,
                  foregroundColor: AppColors.gameForeground,
                  textStyle: AppFonts.instance.gameMenuText(widget.size),
                ),
                onPressed: _save,
                child: const Text('Save Game'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.gameBackground,
                  foregroundColor: AppColors.gameForeground,
                  textStyle: AppFonts.instance.gameMenuText(widget.size),
                ),
                onPressed: _load,
                child: const Text('Load Game'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.gameBackground,
                  foregroundColor: AppColors.gameForeground,
                  textStyle: AppFonts.instance.gameMenuText(widget.size),
                ),
                onPressed: _quit,
                child: const Text('Quit'),
              ),
              const SizedBox(height: 24),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: _back,
              icon: const Icon(
                Icons.cancel,
                color: AppColors.gameBackground,
                size: 44,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _load() {
    showDialog(
        context: context,
        builder: (context) {
          Widget buildDialog(SizeLayout size) => SavesDialog(
              size: size,
              showEmpty: false,
              onBack: () => Navigator.pop(context),
              onSelect: (slot) async {
                ref.read(gameStateProvider.notifier).loadGame(context, slot);
                Navigator.pop(context);
                Navigator.pop(context);
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

  void _save() {
    showDialog(
        context: context,
        builder: (context) {
          Widget buildDialog(SizeLayout size) => SavesDialog(
              size: size,
              showEmpty: true,
              onBack: () => Navigator.pop(context),
              onSelect: (slot) async {
                ref.read(gameStateProvider.notifier).saveGame(context, slot, null);
                Navigator.pop(context);
                Navigator.pop(context);
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

  void _quit() {
    Navigator.pop(context);
    widget.onQuit?.call();
  }

  void _back() {
    Navigator.pop(context);
  }
}

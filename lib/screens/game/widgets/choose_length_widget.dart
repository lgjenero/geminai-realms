import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geminai_realms/game/data/game_data.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class ChooseLengthWidget extends StatelessWidget {
  final void Function(GameLength length)? onLengthSelected;

  const ChooseLengthWidget({super.key, this.onLengthSelected});

  @override
  Widget build(BuildContext context) {
    return SizeLayoutBuilder(
      small: (context, size) => _buildContent(context, SizeLayout.small),
      medium: (context, size) => _buildContent(context, SizeLayout.medium),
      large: (context, size) => _buildContent(context, SizeLayout.large),
    );
  }

  Widget _buildContent(BuildContext context, SizeLayout sizeLayout) {
    final lengths = GameLength.values.whereNot((e) => e == GameLength.none);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How long do you want to play?',
            style: AppFonts.instance.realmMenu(sizeLayout).copyWith(color: AppColors.gameForeground),
          ),
          const SizedBox(height: 24),
          ...lengths.map(
            (e) => _LengthButton(
              length: e,
              sizeLayout: sizeLayout,
              onLengthSelected: onLengthSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class _LengthButton extends StatelessWidget {
  final GameLength length;
  final SizeLayout sizeLayout;
  final void Function(GameLength length)? onLengthSelected;

  const _LengthButton({required this.length, required this.sizeLayout, this.onLengthSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.gameForeground,
          foregroundColor: AppColors.gameBackground,
          textStyle: AppFonts.instance.realmMenu(sizeLayout),
        ),
        onPressed: () => onLengthSelected?.call(length),
        child: Text(length.label),
      ),
    );
  }
}

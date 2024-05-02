import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/realms.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class ChooseRealmWidget extends StatelessWidget {
  final void Function(AppRealms realm)? onRealmSelected;

  const ChooseRealmWidget({super.key, this.onRealmSelected});

  @override
  Widget build(BuildContext context) {
    return SizeLayoutBuilder(
      small: (context, size) => _buildContent(context, SizeLayout.small),
      medium: (context, size) => _buildContent(context, SizeLayout.medium),
      large: (context, size) => _buildContent(context, SizeLayout.large),
    );
  }

  Widget _buildContent(BuildContext context, SizeLayout sizeLayout) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = math.min(constraints.maxWidth, constraints.maxHeight);

      final itemSize = (size / 2) - 8;

      return Center(
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: size / 4,
                child: _RealmButton(
                  realm: AppRealms.fantasy,
                  size: itemSize,
                  sizeLayout: sizeLayout,
                  onRealmSelected: onRealmSelected,
                ),
              ),
              Positioned(
                top: size / 2 + 8,
                left: 0,
                child: _RealmButton(
                  realm: AppRealms.greek,
                  size: itemSize,
                  sizeLayout: sizeLayout,
                  onRealmSelected: onRealmSelected,
                ),
              ),
              Positioned(
                top: size / 2 + 8,
                left: size / 2 + 8,
                child: _RealmButton(
                  realm: AppRealms.cyberpunk,
                  size: itemSize,
                  sizeLayout: sizeLayout,
                  onRealmSelected: onRealmSelected,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _RealmButton extends StatelessWidget {
  final AppRealms realm;
  final double size;
  final SizeLayout sizeLayout;
  final void Function(AppRealms realm)? onRealmSelected;

  const _RealmButton({required this.realm, required this.size, required this.sizeLayout, this.onRealmSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: InkWell(
        onTap: () => onRealmSelected?.call(realm),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(child: AspectRatio(aspectRatio: 1, child: Image.asset(realm.image, fit: BoxFit.contain))),
          const SizedBox(height: 8),
          Text(
            realm.name,
            style: AppFonts.instance.gameMenuText(sizeLayout).copyWith(color: AppColors.gameForeground),
          ),
        ]),
      ),
    );
  }
}

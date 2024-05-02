import 'package:flutter/material.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/sizes.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class GameSnackbar {
  final String message;
  final String? action;
  final IconData? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onActionPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  const GameSnackbar({
    required this.message,
    this.action,
    this.icon,
    this.onPressed,
    this.onActionPressed,
    this.backgroundColor = AppColors.snackbarSuccessBackground,
    this.foregroundColor = AppColors.snackbarSuccessForeground,
  });

  SnackBar toSnackBar(BuildContext context) {
    return SnackBar(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: MediaQuery.viewPaddingOf(context).bottom + 8,
      ),
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      content: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          onPressed?.call();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizeLayoutBuilder(
            small: (_, __) => _content(SizeLayout.small),
            medium: (_, __) => _content(SizeLayout.medium),
            large: (_, __) => _content(SizeLayout.large),
          ),
        ),
      ),
      action: action != null && onActionPressed != null
          ? SnackBarAction(
              label: action!,
              onPressed: () {
                onActionPressed?.call();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            )
          : null,
    );
  }

  Widget _content(SizeLayout size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: AppSizes.hudSymbol(size), color: foregroundColor),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            message,
            style: AppFonts.instance.gameHud(size).copyWith(color: foregroundColor),
          ),
        ),
      ],
    );
  }
}

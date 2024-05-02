import 'package:flutter/material.dart';
import 'package:geminai_realms/utils/constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.gameBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(child: CircularProgressIndicator(color: AppColors.gameForeground)),
    );
  }
}

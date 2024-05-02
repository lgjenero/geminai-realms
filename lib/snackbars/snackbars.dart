import 'package:flutter/material.dart';
import 'package:geminai_realms/snackbars/snackbar.dart';
import 'package:geminai_realms/utils/constants/colors.dart';

abstract class GameSnackbars {
  static GameSnackbar gameSaved() {
    return const GameSnackbar(
      message: 'Game saved',
      icon: Icons.check,
    );
  }

  static GameSnackbar errorSavingGame() {
    return const GameSnackbar(
      message: 'Game not saved. Error occured',
      icon: Icons.close,
      backgroundColor: AppColors.snackbarErrorBackground,
      foregroundColor: AppColors.snackbarErrorForeground,
    );
  }

  static GameSnackbar gameLoaded() {
    return const GameSnackbar(
      message: 'Game loaded',
      icon: Icons.check,
    );
  }

  static GameSnackbar errorLoadingGame() {
    return const GameSnackbar(
      message: 'Game not loaded. Error occured',
      icon: Icons.close,
      backgroundColor: AppColors.snackbarErrorBackground,
      foregroundColor: AppColors.snackbarErrorForeground,
    );
  }

  static GameSnackbar gameExported() {
    return const GameSnackbar(
      message: 'Game Exported!',
      icon: Icons.check,
    );
  }

  static GameSnackbar errorExportingGame() {
    return const GameSnackbar(
      message: 'Game not exported. Error occured',
      icon: Icons.close,
      backgroundColor: AppColors.snackbarErrorBackground,
      foregroundColor: AppColors.snackbarErrorForeground,
    );
  }
}

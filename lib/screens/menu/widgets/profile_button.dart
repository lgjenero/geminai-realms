import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/loading_widget.dart';
import 'package:geminai_realms/screens/menu/widgets/profile_dialog.dart';
import 'package:geminai_realms/services/user/user_service.dart';
import 'package:geminai_realms/utils/constants/colors.dart';

class ProfileButton extends ConsumerWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaded = ref.watch(userServiceProvider.select((e) => e.loaded));
    if (!loaded) return Transform.scale(scale: 0.5, child: const LoadingWidget());

    return FilledButton(
      onPressed: () => _profile(context),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.gameForeground,
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.person, color: AppColors.gameBackground),
    );
  }

  void _profile(BuildContext context) {
    ProfileDialog.show(context);
  }
}

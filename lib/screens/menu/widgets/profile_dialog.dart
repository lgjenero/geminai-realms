import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/loading_widget.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/login_dialog.dart';
import 'package:geminai_realms/services/auth/auth_service.dart';
import 'package:geminai_realms/services/user/user_service.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/sizes.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class ProfileDialog extends StatelessWidget {
  final SizeLayout size;
  final VoidCallback? onBack;

  const ProfileDialog({required this.size, this.onBack, super.key});

  static void show(BuildContext context) {
    Widget buildProfileContent(SizeLayout size) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: ProfileDialog(
            size: size,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => SizeLayoutBuilder(
        small: (_, __) => buildProfileContent(SizeLayout.small),
        medium: (_, __) => buildProfileContent(SizeLayout.medium),
        large: (_, __) => buildProfileContent(SizeLayout.large),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.gameForeground,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      constraints: BoxConstraints.tightFor(width: AppSizes.message(size).width),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Profile',
                style: AppFonts.instance.gameMenuTitle(size).copyWith(color: AppColors.gameBackground),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _ProfileLogin(size: size),
            ],
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: onBack,
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
}

class _ProfileLogin extends ConsumerWidget {
  final SizeLayout size;

  const _ProfileLogin({required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loggedInUserProvider);

    return isLoggedIn.when(
      data: (user) {
        if (user == null) {
          return FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.gameBackground,
              foregroundColor: AppColors.gameForeground,
              textStyle: AppFonts.instance.gameButton(size),
            ),
            onPressed: () => _tryLogin(context),
            child: const Text('Login'),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Logged in as ${user.email}',
              style: AppFonts.instance.gameMenuText(size).copyWith(color: AppColors.gameBackground),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _tryLogout(ref),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gameBackground,
                foregroundColor: AppColors.gameForeground,
                textStyle: AppFonts.instance.gameButton(size),
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
      error: (error, stack) {
        return Text(
          'Error: $error',
          style: AppFonts.instance.gameMenuText(size).copyWith(color: AppColors.gameBackground),
          textAlign: TextAlign.center,
        );
      },
      loading: () => const LoadingWidget(),
    );
  }

  void _tryLogin(BuildContext context) {
    LoginDialog.show(
      context,
      onBack: () => Navigator.pop(context),
      onLogin: () => Navigator.pop(context),
    );
  }

  void _tryLogout(WidgetRef ref) {
    ref.read(userServiceProvider.notifier).logout();
  }
}

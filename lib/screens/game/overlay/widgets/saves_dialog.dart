import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/game/data/game_save_data.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/loading_widget.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/login_dialog.dart';
import 'package:geminai_realms/services/auth/auth_service.dart';
import 'package:geminai_realms/services/firebase/firestore_service.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/sizes.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';
import 'package:intl/intl.dart';

class SavesDialog extends ConsumerStatefulWidget {
  final SizeLayout size;
  final bool showEmpty;
  final VoidCallback? onBack;
  final void Function(String slot)? onSelect;

  const SavesDialog({
    required this.size,
    this.onBack,
    this.onSelect,
    this.showEmpty = false,
    super.key,
  });

  @override
  ConsumerState<SavesDialog> createState() => _SavesDialogState();
}

class _SavesDialogState extends ConsumerState<SavesDialog> {
  final List<GameSaveData> _saves = [];
  bool _loading = false;
  final _dateFormat = DateFormat('d MMMM yyyy hh:mm a');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryLoadSaves());
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.read(authServiceProvider).isLoggedIn();
    if (!isLoggedIn) {
      return LoginDialog(size: widget.size, onBack: _back, onLogin: _tryLoadSaves);
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.gameForeground,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      constraints: BoxConstraints.tight(AppSizes.message(widget.size)),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Saves',
                    style: AppFonts.instance.gameMenuTitle(widget.size).copyWith(color: AppColors.gameBackground)),
                const SizedBox(height: 8),
                Expanded(
                  child: _loading ? const Center(child: LoadingWidget()) : _buildContent(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => _back(),
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

  Widget _buildContent() {
    List<GameSaveDataSlots> slots = GameSaveDataSlots.values;
    if (!widget.showEmpty) {
      slots = slots.where((slot) => _saves.any((save) => save.slot == slot.name)).toList();
    }

    if (slots.isEmpty) {
      return Center(
        child: Text(
          'No saves found',
          style: AppFonts.instance.gameMenuText(widget.size).copyWith(color: AppColors.gameBackground),
        ),
      );
    }

    return ListView.separated(
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final save = _saves.firstWhereOrNull((save) => save.slot == slot.name);
        final date = save?.createdAt;
        final dateText = date != null ? _dateFormat.format(date) : '';

        return ListTile(
          title: Text(
            save != null ? (save.name ?? save.slot) : slot.name,
            style: AppFonts.instance.gameMenuText(widget.size).copyWith(color: AppColors.gameBackground),
          ),
          subtitle: Text(
            save == null ? 'Empty' : 'Realm: ${save.gameData.realm.label}, Date: $dateText',
            style:
                AppFonts.instance.gameMenuText(widget.size).copyWith(color: AppColors.gameBackground.withOpacity(0.5)),
          ),
          onTap: () => _select(slot.name),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }

  void _back() {
    widget.onBack?.call();
  }

  void _select(String slot) {
    widget.onSelect?.call(slot);
  }

  void _tryLoadSaves() async {
    setState(() => _loading = true);

    final saves = await ref.read(firestoreServiceProvider).loadAllGames();

    setState(() {
      _saves.clear();
      _saves.addAll(saves);
      _loading = false;
    });
  }
}

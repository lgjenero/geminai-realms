import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geminai_realms/game/data/game_chapter_event.dart';
import 'package:geminai_realms/game/data/game_state_data.dart';
import 'package:geminai_realms/game/state/game_state.dart';
import 'package:geminai_realms/snackbars/snackbars.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';

class GamePlayInputWidget extends ConsumerStatefulWidget {
  const GamePlayInputWidget({super.key});

  @override
  ConsumerState<GamePlayInputWidget> createState() => _GamePlayInputWidgetState();
}

class _GamePlayInputWidgetState extends ConsumerState<GamePlayInputWidget> {
  String? _selectedAction;

  @override
  Widget build(BuildContext context) {
    return SizeLayoutBuilder(
      small: (_, __) => _buildContent(context, SizeLayout.small),
      medium: (_, __) => _buildContent(context, SizeLayout.medium),
      large: (_, __) => _buildContent(context, SizeLayout.large),
    );
  }

  Widget _buildContent(BuildContext context, SizeLayout size) {
    final status = ref.watch(gameStateProvider.select((e) => e.status));

    if (status == GameStatus.died || status == GameStatus.gameOver) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _back,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gameForeground,
                foregroundColor: AppColors.gameBackground,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: Text(
                'Back to Menu',
                style: AppFonts.instance.realmText(size),
              ),
            ),
            const SizedBox(width: 12.0),
            ElevatedButton(
              onPressed: _export,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gameForeground,
                foregroundColor: AppColors.gameBackground,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              child: Text(
                'Export Story',
                style: AppFonts.instance.realmText(size),
              ),
            ),
          ],
        ),
      );
    }

    final event = ref.watch(gameStateProvider.select((e) => e.gameData.chapters.lastOrNull?.events.lastOrNull));
    final loading = event == null || event.selectedAction != null;
    if (loading) _selectedAction = null;

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.gameForeground, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (loading)
              SizedBox(
                height: _inputHeight(size),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.gameForeground),
                ),
              ),
            if (!loading)
              _buildActionOption(
                _selectedAction ?? "Select action",
                size,
                AppColors.gameForeground,
                () => _showOptions(event, size),
              ),
            const SizedBox(height: 12.0),
            Opacity(
              opacity: _selectedAction == null ? 0.3 : 1.0,
              child: IgnorePointer(
                ignoring: _selectedAction == null,
                child: ElevatedButton(
                  onPressed: _onChoose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gameForeground,
                    foregroundColor: AppColors.gameBackground,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  child: Text('Choose', style: AppFonts.instance.realmText(size)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptions(GameChapterEvent event, SizeLayout size) {
    showBottomSheet(
      context: context,
      backgroundColor: AppColors.gameForeground,
      elevation: 4,
      constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width),
      enableDrag: true,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ...event.actionOptions.map((action) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: action != event.actionOptions.last ? 12.0 : 0),
                    child: _buildActionOption(
                      action,
                      size,
                      AppColors.gameBackground,
                      () {
                        Navigator.of(context).pop();
                        _onChanged(action);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionOption(String action, SizeLayout size, Color color, void Function() onTap) {
    return SizedBox(
      height: _inputHeight(size),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: color,
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        child: Text(
          action,
          style: AppFonts.instance.realmText(size),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _onChanged(String? value) {
    setState(() {
      _selectedAction = value;
    });
  }

  void _onChoose() {
    ref.read(gameStateProvider.notifier).chooseAction(_selectedAction!);
    _selectedAction = null;
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _export() async {
    final success = await exportGame(context, ref.read(gameStateProvider));
    if (success) {
      ref.read(gameStateProvider.notifier).showSnackbar(GameSnackbars.gameExported());
    } else {
      ref.read(gameStateProvider.notifier).showSnackbar(GameSnackbars.errorExportingGame());
    }
  }

  double _inputHeight(SizeLayout size) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: "XXX\nXXX\nXXX", style: AppFonts.instance.realmText(size)),
      maxLines: 4,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.height;
  }
}

/// Exports the game state as a story to a PDF file.
Future<bool> exportGame(BuildContext context, GameStateData game) async {
  try {
    final pdf = await game.createPdf();
    final bytes = await pdf.save();

    await FileSaver.instance.saveFile(
      name: 'GeminAI_Realms',
      bytes: bytes,
      ext: 'pdf',
      mimeType: MimeType.pdf,
    );
  } catch (_, __) {
    print('Error exporting game: $_\n$__');
    return false;
  }
  return true;
}

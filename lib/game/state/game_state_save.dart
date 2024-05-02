// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

extension GameStateSave on GameState {
  void saveGame(
    BuildContext context,
    String slot,
    String? name,
  ) async {
    bool saved = false;

    final overlay = OverlayEntry(builder: (context) {
      return ColoredBox(color: Colors.black.withOpacity(0.4), child: const Center(child: LoadingWidget()));
    });
    Overlay.of(context).insert(overlay);

    try {
      final saveData = GameSaveData(gameData: state.gameData, status: state.status, slot: slot);
      await ref.read(firestoreServiceProvider).saveGame(saveData, slot);
      saved = true;
    } catch (e, s) {
      print('Error saving game: $e\n$s');
    }

    overlay.remove();
    showSnackbar(saved ? GameSnackbars.gameSaved() : GameSnackbars.errorSavingGame());
  }

  void loadGame(BuildContext context, String slot) async {
    state = state.copyWith(status: GameStatus.loading);

    final overlay = OverlayEntry(builder: (context) {
      return ColoredBox(color: Colors.black.withOpacity(0.4), child: const Center(child: LoadingWidget()));
    });
    Overlay.of(context).insert(overlay);

    GameSaveData? saveData;

    try {
      saveData = await ref.read(firestoreServiceProvider).loadGame(slot);
    } catch (e, s) {
      print('Error loading game: $e\n$s');
    }

    if (saveData == null) {
      overlay.remove();
      state = state.copyWith(status: GameStatus.none);
      showSnackbar(GameSnackbars.errorLoadingGame());
      return;
    }

    overlay.remove();
    AppFonts.instance.setRealm(saveData.gameData.realm);
    state = state.copyWith(gameData: saveData.gameData, status: saveData.status);
    FlameAudio.bgm.play('${saveData.gameData.realm.name}.mp3', volume: 0.1);
    showSnackbar(GameSnackbars.gameLoaded());

    if (state.gameData.intro == null) {
      print('No intro, getting intro');
      getIntro();
      return;
    }

    if (state.status == GameStatus.died || state.status == GameStatus.gameOver) {
      return;
    }

    final currentEvent = state.gameData.chapters.lastOrNull?.events.lastOrNull;
    if (currentEvent == null) {
      if (state.gameData.chapters.isEmpty) {
        print('No chapters, getting next chapter');
        getNextChapter();
      } else {
        print('No event, getting next event');
        getNextChapterEvent();
      }
      return;
    }

    if (currentEvent.selectedAction == null) {
      print('No selected action, waiting for selected action');
      return;
    }

    if (currentEvent.result == null) {
      print('No result, getting step result');
      getEventResult();
      return;
    }

    final lastChapter = state.gameData.chapters.last;
    if (lastChapter.finished == true) {
      if (lastChapter.finishText == null) {
        print('No finish text, getting finish text');
        _finishChapter();
        return;
      }
      print('Getting next chapter');
      getNextChapter();
      return;
    }

    print('Getting next step');
    getNextChapterEvent();
  }
}

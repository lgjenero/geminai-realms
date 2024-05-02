// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of 'game_state.dart';

const int _retries = 10;

extension GameStatePlay on GameState {
  void getIntro({int retry = 0}) async {
    final realm = state.gameData.realm;

    state = state.copyWith(status: GameStatus.ready);

    try {
      final result = await FirebaseFunctions.instance.httpsCallable('createIntro').call(
        {
          "realm": realm.name,
        },
      );

      final json = result.data is Map ? result.data : jsonDecode(result.data);
      if (json is! Map) throw Exception("Invalid result data: $json");

      final code = json['code'] as int?;
      if (code != 200) throw Exception("Invalid code: $json");

      final story = json['data'];
      if (story is! Map) throw Exception("Invalid story data $story");

      final world = story['world'] as String?;
      final character = story['character'] as String?;
      final intro = story['intro'] as String?;

      if (world == null || character == null || intro == null) {
        throw Exception("Invalid world and/or character and/or intro data: $world | $character | $intro");
      }

      state = state.copyWith(
        status: GameStatus.playing,
        gameData: state.gameData.copyWith(
          world: _sanitise(world),
          character: _sanitise(character),
          intro: _sanitise(intro),
        ),
      );

      getNextChapter();
    } catch (e, s) {
      print("getIntro Error: $e\n$s");

      if (retry < _retries) {
        await Future.delayed(Duration(milliseconds: (retry + 1) * 200));
        getIntro(retry: retry + 1);
      } else {
        state = state.copyWith(status: GameStatus.chooseRealm);
      }
    }
  }

  void getNextChapter({int retry = 0}) async {
    try {
      final result = await FirebaseFunctions.instance.httpsCallable('createChapter').call(
        {
          "story": _getStory(),
          "length": state.gameData.length.name,
          "chapter": state.gameData.chapters.length + 1,
        },
      );

      final json = result.data is Map ? result.data : jsonDecode(result.data);
      if (json is! Map) throw Exception("Invalid result data: $json");

      final code = json['code'] as int?;
      if (code != 200) throw Exception("Invalid code: $json");

      final chapter = json['data'];
      if (chapter is! Map) throw Exception("Invalid chapter data: $chapter");

      final location = chapter['location'] as String? ?? "";
      final situation = chapter['situation'] as String? ?? "";
      final summary = chapter['summary'] as String?;
      final intro = chapter['intro'] as String?;
      if (summary == null || intro == null) {
        throw Exception(
            "Invalid location and/or situation and/or summary and/or intro data: $location | $situation | $summary | $intro");
      }

      final GameChapter event = GameChapter(
        location: _sanitise(location),
        situation: _sanitise(situation),
        summary: _sanitise(summary),
        intro: _sanitise(intro),
        events: [],
        finished: false,
        compression: "",
      );

      state = state.copyWith(
        status: GameStatus.playing,
        gameData: state.gameData.copyWith(chapters: [...state.gameData.chapters, event]),
      );

      getNextChapterEvent();
    } catch (e, s) {
      print("getNextChapter Error: $e\n$s");
      if (retry < _retries) {
        await Future.delayed(Duration(milliseconds: (retry + 1) * 100));
        getNextChapter(retry: retry + 1);
      }
    }
  }

  void getNextChapterEvent({int retry = 0}) async {
    final chapter = state.gameData.chapters.lastOrNull;
    if (chapter == null) return;

    try {
      final result = await FirebaseFunctions.instance.httpsCallable('createChapterEvent').call(
        {
          "story": _getStory(),
          // "story": _getChapter(),
          "length": state.gameData.length.name,
          "chapter": state.gameData.chapters.length + 1,
          "event": chapter.events.length + 1,
        },
      );

      final lastChapter = state.gameData.chapters.lastOrNull;
      if (lastChapter != chapter) return;

      final json = result.data is Map ? result.data : jsonDecode(result.data);
      if (json is! Map) throw Exception("Invalid result data: $json");

      final code = json['code'] as int?;
      if (code != 200) throw Exception("Invalid code: $json");

      final chapterEventData = json['data'];
      if (chapterEventData is! Map) throw Exception("Invalid chapterEventData data: $chapterEventData");

      final callForAction = chapterEventData['call_for_action'] as String?;
      final actionOptionsData = chapterEventData['action_options'] as List?;
      final actionOptions = actionOptionsData?.whereType<String>().toList();
      final actionOptionsProbabilityData = chapterEventData['action_options_probability'] as List?;
      final actionOptionsProbability = actionOptionsProbabilityData
          ?.map((e) {
            if (e is num) return e.toDouble();
            if (e is String) return double.tryParse(e);
            return null;
          })
          .whereType<double>()
          .toList();

      if (callForAction == null || actionOptions == null || actionOptionsProbability == null) {
        throw Exception(
            "Invalid callForAction and/or actionOptions and/or actionOptionsProbability data: $callForAction | $actionOptions | $actionOptionsProbability");
      }

      final chapterEvent = GameChapterEvent(
        callForAction: _sanitise(callForAction),
        actionOptions: actionOptions.map((e) => _sanitise(e)).toList(),
        actionOptionsProbability: actionOptionsProbability,
        selectedAction: null,
        success: null,
        result: null,
      );

      final updatedLastChapter = chapter.copyWith(events: [...chapter.events, chapterEvent]);
      final chapters = [...state.gameData.chapters];
      chapters.replaceRange(chapters.length - 1, chapters.length, [updatedLastChapter]);

      state = state.copyWith(
        gameData: state.gameData.copyWith(chapters: chapters),
      );
    } catch (e, s) {
      print("getNextChapterEvent Error: $e\n$s");
      if (retry < _retries) {
        await Future.delayed(Duration(milliseconds: (retry + 1) * 100));
        getNextChapterEvent(retry: retry + 1);
      }
    }
  }

  void chooseAction(String action) async {
    final chapters = [...state.gameData.chapters];
    if (chapters.isEmpty) return;

    final chapter = chapters.last;
    final events = [...chapter.events];
    if (events.isEmpty) return;

    final event = events.last;
    final actionOption = event.actionOptions.firstWhereOrNull((e) => e == action);
    if (actionOption == null) return;

    final index = event.actionOptions.indexOf(actionOption);
    final probability = event.actionOptionsProbability.length > index ? event.actionOptionsProbability[index] : 1;

    final draw = Random().nextDouble();
    final success = draw <= probability;

    final updatedEvent = event.copyWith(
      selectedAction: actionOption,
      success: success,
    );
    events.replaceRange(events.length - 1, events.length, [updatedEvent]);
    final updatedChapter = chapter.copyWith(events: events);
    chapters.replaceRange(chapters.length - 1, chapters.length, [updatedChapter]);

    state = state.copyWith(
      gameData: state.gameData.copyWith(
        chapters: chapters,
      ),
    );

    getEventResult();
  }

  void getEventResult({int retry = 0}) async {
    final chapters = [...state.gameData.chapters];
    if (chapters.isEmpty) return;

    final chapter = chapters.last;
    final events = [...chapter.events];
    if (events.isEmpty) return;

    final event = events.last;

    try {
      final result = await FirebaseFunctions.instance.httpsCallable('createChapterEventResult').call(
        {
          "story": _getStory(),
          // "story": _getChapter(),
          "length": state.gameData.length.name,
          "chapter": state.gameData.chapters.length + 1,
          "event": chapter.events.length + 1,
        },
      );

      final lastEvent = state.gameData.chapters.lastOrNull?.events.lastOrNull;
      if (lastEvent != event) return;

      final json = result.data is Map ? result.data : jsonDecode(result.data);
      if (json is! Map) throw Exception("Invalid result data: $json");

      final code = json['code'] as int?;
      if (code != 200) throw Exception("Invalid code: $json");

      final chapterEventResult = json['data'];
      if (chapterEventResult is! Map) throw Exception("Invalid chapterEventResult data: $chapterEventResult");

      final description = chapterEventResult['description'] as String?;
      final chapterEnded = chapterEventResult['chapter_ended'] as bool?;
      final characterDied = chapterEventResult['character_died'] as bool?;

      if (description == null) {
        throw Exception("Invalid description data: $description");
      }

      final updatedEvent = event.copyWith(
        result: _sanitise(description),
      );
      events.replaceRange(events.length - 1, events.length, [updatedEvent]);
      final updatedChapter = chapter.copyWith(
        events: events,
        finished: chapterEnded == true,
      );
      chapters.replaceRange(chapters.length - 1, chapters.length, [updatedChapter]);
      state = state.copyWith(
        gameData: state.gameData.copyWith(
          chapters: chapters,
        ),
      );

      if (characterDied == true) {
        state = state.copyWith(
          status: GameStatus.died,
        );
        return;
      }

      if (chapterEnded == true) {
        _finishChapter();
      } else {
        getNextChapterEvent();
      }
    } catch (e, s) {
      print("getEventResult Error: $e\n$s");
      if (retry < _retries) {
        await Future.delayed(Duration(milliseconds: (retry + 1) * 100));
        getEventResult(retry: retry + 1);
      }
    }
  }

  void rewindToEvent(BuildContext context, SizeLayout size, int chapterIdx, int eventIdx) async {
    print("rewindToEvent: $chapterIdx | $eventIdx");

    Future<bool?> askPlayer<bool>(BuildContext context) async {
      final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: AppColors.gameForeground,
                elevation: 4,
                title: const Text("Rewind to this event?"),
                titleTextStyle: AppFonts.instance.realmText(size).copyWith(color: AppColors.gameBackground),
                content: const Text("This will rewind the game to this event, are you sure?"),
                contentTextStyle: AppFonts.instance.realmText(size).copyWith(color: AppColors.gameBackground),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.gameBackground,
                      textStyle: AppFonts.instance.realmText(size),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.gameBackground,
                      textStyle: AppFonts.instance.realmText(size),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Rewind"),
                  ),
                ],
              ));
      return result;
    }

    final chapters = [...state.gameData.chapters];
    print("chapters.length: ${chapters.length} | $chapterIdx | $eventIdx");
    if (chapterIdx >= chapters.length) return;

    final chapter = chapters[chapterIdx];
    final events = [...chapter.events];
    print("events.length: ${events.length} | $chapterIdx | $eventIdx");
    if (eventIdx >= events.length) return;

    GameChapterEvent dataEvent = events[eventIdx];
    print("dataEvent: $dataEvent");
    if (dataEvent.result == null) return;

    final okToRewind = await askPlayer(context);
    if (okToRewind != true) return;

    events.removeRange(eventIdx, events.length);
    dataEvent = dataEvent.copyWith(selectedAction: null, success: null, result: null);
    events.add(dataEvent);

    final updatedChapter = chapter.copyWith(events: events, finished: false, compression: null, finishText: null);
    chapters.removeRange(chapterIdx, chapters.length);
    chapters.add(updatedChapter);

    state = state.copyWith(
      gameData: state.gameData.copyWith(
        chapters: chapters,
      ),
      status: GameStatus.playing,
    );

    return;
  }

  void _finishChapter({int retry = 0}) async {
    final chapters = [...state.gameData.chapters];
    if (chapters.isEmpty) return;

    final chapter = chapters.last;

    try {
      final result = await FirebaseFunctions.instance.httpsCallable('createChapterFinish').call(
        {
          "story": _getStory(),
          // "story": _getChapter(),
          "length": state.gameData.length.name,
          "chapter": state.gameData.chapters.length + 1,
        },
      );

      final json = result.data is Map ? result.data : jsonDecode(result.data);
      if (json is! Map) throw Exception("Invalid result data: $json");

      final code = json['code'] as int?;
      if (code != 200) throw Exception("Invalid code: $json");

      final chapterFinish = json['data'];
      if (chapterFinish is! Map) throw Exception("Invalid chapterFinish data: $chapterFinish");

      final finishText = chapterFinish['chapter_end'] as String?;
      final compressed = chapterFinish['compressed_chapter'] as String?;
      final gameOver = chapterFinish['game_over'] as bool?;

      if (finishText == null || compressed == null) {
        throw Exception("Invalid finishText and/or compressed data: $finishText | $compressed");
      }

      final updatedChapter = chapter.copyWith(
        finishText: finishText,
        compression: compressed,
      );
      chapters.replaceRange(chapters.length - 1, chapters.length, [updatedChapter]);
      state = state.copyWith(
        gameData: state.gameData.copyWith(
          chapters: chapters,
        ),
      );

      if (gameOver == true) {
        state = state.copyWith(
          status: GameStatus.gameOver,
        );
        return;
      }

      getNextChapter();
    } catch (e, s) {
      print("_finishChapter Error: $e\n$s");
      if (retry < _retries) {
        await Future.delayed(Duration(milliseconds: (retry + 1) * 100));
        _finishChapter(retry: retry + 1);
      }
    }
  }

  String _getStory() {
    // String story = "";

    final story = StringBuffer();

    story.writeln("World: ${state.gameData.world}");
    story.writeln("Character: ${state.gameData.character}");
    story.writeln("Intro: ${state.gameData.intro}");

    for (int i = 0; i < state.gameData.chapters.length; i++) {
      final chapter = state.gameData.chapters[i];
      story.writeln("chapter ${i + 1}");

      if (chapter.compression?.isNotEmpty == true) {
        story.writeln("${chapter.compression}");
        continue;
      }

      // story.writeln("Location: ${chapter.location}");
      // story.writeln("Situation: ${chapter.situation}");
      story.writeln(
          "This is supposed to happen, although this depends on player actions, in this Chapter: ${chapter.summary}");
      // story.writeln("Intro: ${chapter.intro}");

      story.writeln("This is what happened in this Chapter so far:");
      story.writeln("Intro: ${chapter.intro}");
      for (int j = 0; j < chapter.events.length; j++) {
        final event = chapter.events[j];

        if (event.selectedAction == null) break;

        story.writeln("Event ${j + 1}: ${event.callForAction}");
        story.writeln("Situation: ${event.callForAction}");
        story.writeln("Action: ${event.selectedAction} -> ${event.success == true ? "Success" : "Failure"}");

        if (event.result == null) break;
        story.writeln("Result: ${event.result}");
      }
    }

    return story.toString();
  }

  String _getChapter() {
    final chapter = state.gameData.chapters.lastOrNull;
    if (chapter == null) return "";

    final story = StringBuffer();

    story.writeln("This is expected to happen in this Chapter: ${chapter.summary}");
    story.writeln("Intro: ${chapter.intro}");

    story.writeln("This is what happened in this Chapter so far:\n");
    for (int j = 0; j < chapter.events.length; j++) {
      final event = chapter.events[j];

      if (event.selectedAction == null) break;

      story.writeln("Event ${j + 1}");
      story.writeln("Action: ${event.selectedAction} -> ${event.success == true ? "Success" : "Failure"}");

      if (event.result == null) break;
      story.writeln("Result: ${event.result}");
    }

    return story.toString();
  }

  String _sanitise(String text) {
    return text.trim().replaceAll("\\'", "'");
  }
}

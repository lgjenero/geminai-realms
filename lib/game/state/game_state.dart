import 'dart:convert';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:geminai_realms/game/data/game_chapter.dart';
import 'package:geminai_realms/game/data/game_chapter_event.dart';
import 'package:geminai_realms/game/data/game_data.dart';
import 'package:geminai_realms/game/data/game_save_data.dart';
import 'package:geminai_realms/game/data/game_state_data.dart';
import 'package:geminai_realms/screens/game/overlay/widgets/loading_widget.dart';
import 'package:geminai_realms/services/firebase/firestore_service.dart';
import 'package:geminai_realms/snackbars/snackbar.dart';
import 'package:geminai_realms/snackbars/snackbar_state.dart';
import 'package:geminai_realms/snackbars/snackbars.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/realms.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/constants/colors.dart';

part 'game_state.g.dart';
part 'game_state_play.dart';
part 'game_state_save.dart';
part 'game_state_snackbar.dart';

@riverpod
class GameState extends _$GameState {
  @override
  GameStateData build() {
    ref.onDispose(() {
      FlameAudio.bgm.stop();
    });

    return GameStateData.initial();
  }

  void chooseRealm() {
    state = state.copyWith(status: GameStatus.chooseRealm);
  }

  void initializeRealm(AppRealms realm) {
    state = state.copyWith(gameData: state.gameData.copyWith(realm: realm), status: GameStatus.chooseLength);
    FlameAudio.bgm.play('${realm.name}.mp3', volume: 0.1);
  }

  void initializeLength(GameLength length) {
    state = state.copyWith(gameData: state.gameData.copyWith(length: length), status: GameStatus.ready);
  }
}

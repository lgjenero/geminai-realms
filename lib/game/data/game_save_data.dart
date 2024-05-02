import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geminai_realms/game/data/game_data.dart';
import 'package:geminai_realms/game/data/game_state_data.dart';

part 'game_save_data.freezed.dart';
part 'game_save_data.g.dart';

enum GameSaveDataSlots {
  slot1,
  slot2,
  slot3,
  slot4;
}

@freezed
class GameSaveData with _$GameSaveData {
  const factory GameSaveData({
    required GameData gameData,
    required GameStatus status,
    required String slot,
    String? name,
    @DateTimeConverter() DateTime? createdAt,
  }) = _GameSaveData;

  factory GameSaveData.fromJson(Map<String, dynamic> json) => _$GameSaveDataFromJson(json);
}

class DateTimeConverter implements JsonConverter<DateTime?, Object?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(Object? data) {
    try {
      if (data is String) {
        return DateTime.tryParse(data);
      } else if (data is num) {
        if (data > 100000000000000) {
          return DateTime.fromMicrosecondsSinceEpoch(data.toInt());
        }
        return DateTime.fromMillisecondsSinceEpoch(data.toInt());
      } else if (data is Timestamp) {
        return data.toDate();
      } else if (data is DateTime) {
        return data;
      }
    } catch (e) {
      log('DateTimeConverter fromJson: $e');
    }
    return null;
  }

  @override
  Timestamp? toJson(DateTime? data) => data != null ? Timestamp.fromDate(data) : null;
}

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geminai_realms/game/data/game_data.dart';
import 'package:geminai_realms/utils/constants/colors.dart';
import 'package:geminai_realms/utils/constants/fonts.dart';
import 'package:geminai_realms/utils/constants/realms.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

part 'game_state_data.freezed.dart';
part 'game_state_data.g.dart';

enum GameStatus {
  none,
  loading,
  chooseRealm,
  chooseLength,
  ready,
  playing,
  died,
  gameOver,
}

@freezed
class GameStateData with _$GameStateData {
  const factory GameStateData({
    required GameData gameData,
    required GameStatus status,
  }) = _GameStateData;

  factory GameStateData.fromJson(Map<String, dynamic> json) => _$GameStateDataFromJson(json);

  factory GameStateData.initial() {
    return const GameStateData(
      gameData: GameData(realm: AppRealms.none, length: GameLength.none, chapters: []),
      status: GameStatus.none,
    );
  }
}

extension GameStateDataX on GameStateData {
  Future<pw.Document> createPdf() async {
    final realmTextFont = await AppFonts.instance.realmText(SizeLayout.small).toPdfTextStyle();
    final realmMenuFont = await AppFonts.instance.realmMenu(SizeLayout.small).toPdfTextStyle();
    final realmTitleFont = await AppFonts.instance.realmTitle(SizeLayout.small).toPdfTextStyle();

    final items = <pw.Widget>[];

    final imageBytes = (await rootBundle.load('images/realms/${gameData.realm.name}.png')).buffer.asUint8List();

    items.add(pw.SizedBox(height: 64));
    items.add(pw.Center(
      child: pw.Container(
        decoration: pw.BoxDecoration(
          borderRadius: pw.BorderRadius.circular(8),
          color: PdfColor.fromInt(AppColors.gameBackground.value),
        ),
        padding: const pw.EdgeInsets.all(16),
        child: pw.Image(pw.MemoryImage(imageBytes), width: 200, height: 200, fit: pw.BoxFit.contain),
      ),
    ));
    items.add(pw.SizedBox(height: 32));

    if (gameData.world != null) {
      items.add(pw.Text(gameData.world!, style: realmTextFont));
      items.add(pw.SizedBox(height: 16));
    }
    if (gameData.character != null) {
      items.add(pw.Text(gameData.character!, style: realmTextFont));
      items.add(pw.SizedBox(height: 16));
    }
    if (gameData.intro != null) {
      items.add(pw.Text(gameData.intro!, style: realmTextFont));
      items.add(pw.SizedBox(height: 16));
    }

    for (int i = 0; i < gameData.chapters.length; i++) {
      final chapter = gameData.chapters[i];

      items.add(pw.SizedBox(height: 16));
      items.add(pw.Text('Chapter ${i + 1}', style: realmMenuFont));
      items.add(pw.SizedBox(height: 24));
      items.add(pw.Text(chapter.intro, style: realmTextFont));
      items.add(pw.SizedBox(height: 16));

      for (int j = 0; j < chapter.events.length; j++) {
        final event = chapter.events[j];

        items.add(pw.Text(event.callForAction, style: realmTextFont));
        items.add(pw.SizedBox(height: 16));

        if (event.selectedAction != null) {
          items.add(pw.Text('You: ${event.selectedAction}', style: realmTextFont));
          items.add(pw.SizedBox(height: 16));
          if (event.result != null) {
            items.add(pw.Text(event.result!, style: realmTextFont));
            items.add(pw.SizedBox(height: 16));
          }
        }
      }

      if (chapter.finishText != null) {
        items.add(pw.Text(chapter.finishText!, style: realmTextFont));
        items.add(pw.SizedBox(height: 16));
      }
    }

    if (status == GameStatus.died) {
      items.add(pw.SizedBox(height: 16));
      items.add(pw.Center(child: pw.Text('~~ You died! ~~', style: realmTitleFont)));
      items.add(pw.SizedBox(height: 32));
    } else if (status == GameStatus.gameOver) {
      items.add(pw.SizedBox(height: 16));
      items.add(pw.Center(child: pw.Text('~~ The End! ~~', style: realmTitleFont)));
      items.add(pw.SizedBox(height: 32));
    }

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return items;
        },
      ),
    );
    return pdf;
  }
}

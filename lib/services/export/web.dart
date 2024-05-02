import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:geminai_realms/game/data/game_state_data.dart';

Future<bool> exportGame(BuildContext context, GameStateData game) async {
  try {
    final pdf = await game.createPdf();
    final bytes = await pdf.save();
    final base64 = base64Encode(bytes);

    final anchor = AnchorElement(href: 'data:application/octet-stream;base64,$base64')..target = 'blank';
    anchor.download = 'GeminAI_Realms.pdf';

    // trigger download
    document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  } catch (_, __) {
    print('Error exporting game: $_\n$__');
  }

  return true;
}

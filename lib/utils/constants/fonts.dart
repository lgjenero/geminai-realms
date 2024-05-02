import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geminai_realms/utils/constants/realms.dart';
import 'package:geminai_realms/utils/widgets/size_layout.dart';
import 'package:pdf/widgets.dart' as pw;

class AppFonts {
  AppFonts._();

  static final instance = AppFonts._();

  AppRealms _realm = AppRealms.fantasy;

  void setRealm(AppRealms realm) {
    _realm = realm;
  }

  String get realmFont {
    switch (_realm) {
      case AppRealms.fantasy:
        return 'Almendra';
      case AppRealms.greek:
        return 'Hellenic';
      case AppRealms.cyberpunk:
        return 'Share';
      default:
        return 'Exo';
    }
  }

  ///
  /// Game fonts
  ///

  TextStyle gameTitle(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Exo',
      fontSize: size == SizeLayout.small
          ? 48
          : size == SizeLayout.medium
              ? 56
              : 64,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle gameMenuTitle(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Exo',
      fontSize: size == SizeLayout.small
          ? 22
          : size == SizeLayout.medium
              ? 24
              : 28,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle gameMenuText(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Exo',
      fontSize: size == SizeLayout.small
          ? 20
          : size == SizeLayout.medium
              ? 22
              : 26,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle gameMenuLink(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Exo',
      fontSize: size == SizeLayout.small
          ? 20
          : size == SizeLayout.medium
              ? 22
              : 26,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle gameButton(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Exo',
      fontSize: size == SizeLayout.small
          ? 24
          : size == SizeLayout.medium
              ? 32
              : 48,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle gameHud(SizeLayout size) {
    return TextStyle(
      fontFamily: 'Exo',
      fontSize: size == SizeLayout.small
          ? 16
          : size == SizeLayout.medium
              ? 18
              : 20,
      fontWeight: FontWeight.w600,
    );
  }

  ///
  /// Realm fonts
  ///

  TextStyle realmTitle(SizeLayout size) {
    return TextStyle(
      fontFamily: realmFont,
      fontSize: size == SizeLayout.small
          ? 48
          : size == SizeLayout.medium
              ? 56
              : 64,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle realmMenu(SizeLayout size) {
    return TextStyle(
      fontFamily: realmFont,
      fontSize: size == SizeLayout.small
          ? 24
          : size == SizeLayout.medium
              ? 26
              : 28,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle realmText(SizeLayout size) {
    return TextStyle(
      fontFamily: realmFont,
      fontSize: size == SizeLayout.small
          ? 18
          : size == SizeLayout.medium
              ? 20
              : 24,
      height: 1.3,
      fontWeight: FontWeight.w400,
    );
  }
}

extension TextStyleUtils on TextStyle {
  Future<pw.TextStyle> toPdfTextStyle() async {
    pw.Font? font;

    // try to load variable font first
    try {
      final bytes = await rootBundle.load('fonts/$fontFamily/$fontFamily-VariableFont_wght.ttf');
      if (bytes.buffer.asUint8List().isNotEmpty) {
        font = pw.Font.ttf(bytes.buffer.asByteData());
      }
    } catch (_) {}

    if (font == null) {
      try {
        String style;
        switch (fontWeight) {
          case FontWeight.w700:
            style = 'Bold';
            break;
          default:
            style = 'Regular';
            break;
        }

        switch (fontStyle) {
          case FontStyle.italic:
            if (style == 'Regular') {
              style = 'Italic';
            } else {
              style += 'Italic';
            }
            break;
          default:
            break;
        }

        final bytes = await rootBundle.load('fonts/$fontFamily/$fontFamily-$style.ttf');
        if (bytes.buffer.asUint8List().isNotEmpty) {
          font = pw.Font.ttf(bytes.buffer.asByteData());
        }
      } catch (_) {}
    }

    return pw.TextStyle(
      font: font,
      fontSize: fontSize,
      fontWeight: fontWeight?.toPdfFontWeight(),
      fontStyle: fontStyle?.toPdfFontStyle(),
    );
  }
}

extension FontWeightUtils on FontWeight {
  pw.FontWeight toPdfFontWeight() {
    switch (this) {
      case FontWeight.w700:
        return pw.FontWeight.bold;
      default:
        return pw.FontWeight.normal;
    }
  }
}

extension FontStyleUtils on FontStyle {
  pw.FontStyle toPdfFontStyle() {
    switch (this) {
      case FontStyle.italic:
        return pw.FontStyle.italic;
      default:
        return pw.FontStyle.normal;
    }
  }
}

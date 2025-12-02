import 'package:flutter/cupertino.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class TextContainsFilter implements PlutoFilterType {
  @override
  String get title => "İçerir";

  @override
  get compare =>
      ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        //var keys = search!.split(',').map((e) => convertUpperCase(e)).toList();

        if (base != null && search != null) {
          if (base.contains(convertUpperCase(search))) {
            return true;
          } else if (base.contains(convertLowerCase(search))) {
            return true;
          } else if (base.toLowerCase().contains(search.toLowerCase())) {
            return true;
          } else if (base.toUpperCase().contains(search.toUpperCase())) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      };

  convertUpperCase(String text) {
    int i = 0;
    for (var c in text.characters) {
      switch (c) {
        case "i":
          text = replaceCharAt(text, i, "İ");
          break;
        case "ü":
          text = replaceCharAt(text, i, "Ü");
          break;
        case "ö":
          text = replaceCharAt(text, i, "Ö");
          break;
        default:
          text = replaceCharAt(text, i, c.toUpperCase());
          break;
      }
      i++;
    }
    return text;
  }

  convertLowerCase(String text) {
    int i = 0;
    for (var c in text.characters) {
      switch (c) {
        case "İ":
          text = replaceCharAt(text, i, "i");
          break;
        case "Ü":
          text = replaceCharAt(text, i, "ü");
          break;
        case "Ö":
          text = replaceCharAt(text, i, "ö");
          break;
        default:
          text = replaceCharAt(text, i, c.toLowerCase());
      }
      i++;
    }
    return text;
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  TextContainsFilter();
}

class GreaterThanFilter implements PlutoFilterType {
  @override
  String get title => "Büyüktür";

  @override
  get compare =>
      ({
        required String? base,
        required String? search,
        required PlutoColumn? column,
      }) {
        //var keys = search!.split(',').map((e) => convertUpperCase(e)).toList();

        if (base != null && search != null) {
          if (double.parse(base.replaceAll(",", ".")) >
              double.parse(search.replaceAll(",", "."))) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      };

  GreaterThanFilter();
}

class LessThanFilter implements PlutoFilterType {
  @override
  String get title => "Küçüktür";

  @override
  PlutoCompareFunction get compare => FilterHelper.compareLessThan;

  LessThanFilter();
}

class DateGreaterThanFilter implements PlutoFilterType {
  @override
  String get title => "Büyüktür";

  @override
  PlutoCompareFunction get compare => FilterHelper.compareLessThan;

  DateGreaterThanFilter();
}

class DateLessThanFilter implements PlutoFilterType {
  @override
  String get title => "Küçüktür";

  @override
  PlutoCompareFunction get compare => FilterHelper.compareLessThan;

  DateLessThanFilter();
}

class EqualsFilter implements PlutoFilterType {
  @override
  String get title => "Eşittir";

  @override
  PlutoCompareFunction get compare => FilterHelper.compareEquals;
  EqualsFilter();
}

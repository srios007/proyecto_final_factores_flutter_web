import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
final requestFormat =
    NumberFormat.currency(symbol: '', decimalDigits: 0, locale: 'es_ES');

class Styles {
  TextStyle tittleRegister = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );
  TextStyle errorStyle = const TextStyle(
    fontSize: 14,
    color: Colors.red,
    fontWeight: FontWeight.w400,
  );
  TextStyle requiredRegister = const TextStyle(
    // color: Palette.darkBlue,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );
  TextStyle hintTextStyleRegister = const TextStyle(
    // color: Palette.darkBlue.withOpacity(0.5),
    fontSize: 13,
    fontWeight: FontWeight.w300,
    // fontFamily: 'Interstate',
  );
  UnderlineInputBorder borderTextField = const UnderlineInputBorder(
    borderSide: BorderSide(
      // color: Palette.darkBlue,
      width: 2.0,
    ),
  );
}

Styles styles = Styles();

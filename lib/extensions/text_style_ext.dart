import 'package:btl_kiemtra_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

extension EITextStyleExtension on TextStyle {
  TextStyle get title => copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: colorRed,
  );
  TextStyle get titleWhite => copyWith(
    fontSize: 18,
    color: const Color(0xffA4A4A4),
  );
  TextStyle get itemTitle => copyWith(
    fontSize: 14,
    color: Colors.white,
  );
  TextStyle get itemSubTitle => copyWith(
    fontSize: 12,
    color: colorPrimaryLight,
  );
  TextStyle get itemChannelCounter => copyWith(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
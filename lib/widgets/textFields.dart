

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_dispomoviles/widgets/themes.dart';

double xSize = 180;

ConstrainedBox txtfieldCarVINAdd(TextEditingController tfc, String text) {
  return ConstrainedBox(
    constraints: BoxConstraints.tight(Size(double.maxFinite, 75.0)),
    child: Card(
      child: TextField(
        decoration: addPageInputDecoration(text),
        inputFormatters: [LengthLimitingTextInputFormatter(17)],
        textAlign: TextAlign.center,
        controller: tfc
      )
    )
  );
}

ConstrainedBox txtfieldCarTextSmallAdd(TextEditingController tfc, String text) {
  return ConstrainedBox(
    constraints: BoxConstraints.tight(Size(xSize, 75.0)),
    child: Card(
      child: TextField(
        decoration: addPageInputDecoration(text),
        controller: tfc
      )
    )
  );
}

ConstrainedBox txtfieldCarNumberAdd(TextEditingController tfc, String text) {
  return ConstrainedBox(
    constraints: BoxConstraints.tight(Size(xSize, 75.0)),
    child: Card(
      child: TextField(
        decoration: addPageInputDecoration(text),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: tfc
      )
    )
  );
}

ConstrainedBox txtfieldCarPatenteAdd(TextEditingController tfc, String text) {
  return ConstrainedBox(
    constraints: BoxConstraints.tight(Size(xSize, 75.0)),
    child: Card(
      child: TextField(
        decoration: addPageInputDecoration(text),
        inputFormatters: [
          // FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
          // LengthLimitingTextInputFormatter(8),
          CardFormatter(
            sample: 'xx-xx-xx',
            separator: '-'
          )
        ],
        controller: tfc
      )
    )
  );
}

class CardFormatter extends TextInputFormatter {
  final String sample;
  final String separator;

  CardFormatter({
    required this.sample,
    required this.separator,
  }) {
    assert(sample != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) return oldValue;
        if (newValue.text.length < sample.length && sample[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}'.toUpperCase(),
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            )
          );
        }
      }
    }
    return newValue;
  }
}
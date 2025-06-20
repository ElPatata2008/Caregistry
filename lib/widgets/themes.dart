import 'package:flutter/material.dart';

BoxDecoration cardImageBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.all(
      width: 2.5,
      color: Colors.lightBlueAccent
    )
  );
}

BoxDecoration cardButtonBoxDecoration() {
  return BoxDecoration(
    color: Colors.blueGrey[700],
    borderRadius: BorderRadius.all(Radius.circular(8)),
    border: Border.all(
      width: 1.5,
      color: Colors.black,
    )
  );
}

InputDecoration addPageInputDecoration(String text) {
  return InputDecoration(
    border: OutlineInputBorder(),
    floatingLabelAlignment: FloatingLabelAlignment.center,
    labelText: text,
  );
}
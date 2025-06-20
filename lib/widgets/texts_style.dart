import 'package:flutter/material.dart';

Text textCard(String info, TextAlign alignment) {
  return Text(info,
    textAlign: alignment,
    style: TextStyle(
      color: Colors.white
    ),
  );
}

Text textCarInfo(String info) {
  return Text(info, 
    textScaler: TextScaler.linear(1.5),
    style: TextStyle(
      color: Colors.white
    ),

  );
}

Text textTrackingMain(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 40
    ),
  );
}
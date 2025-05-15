import 'package:flutter/material.dart';

ListTile drawerTile(BuildContext context, Widget page, String text) {
  return ListTile(
    leading: Icon(Icons.person),
    title: Text(text),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
  );
}
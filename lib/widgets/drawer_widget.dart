import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/list_tiles.dart';

Drawer menu(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.blueGrey[500],
    shape: ContinuousRectangleBorder(),
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.multiply),
              image: AssetImage("assets/placeholders/profile_bg_ph.png")
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/placeholders/profile_ph.png"),
                  height: 100,
                ),
                Text("Usuario"),
              ],
            ),
          )
        ),
        drawerTile(context, ProfilePage(), "Profile"),
        drawerTile(context, SettingsPage(), "Settings"),
      ],
    ),
  );
}
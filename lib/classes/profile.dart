
library;

import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/classes/vehicle.dart';
import 'package:proyecto_dispomoviles/classes/vehicle.dart' as vehicleList;
import 'package:proyecto_dispomoviles/widgets/themes.dart';

Profile myProfile = Profile("profile_default.png", "Usuario", "ejemplo", 0, 0, vehicles);

class Profile {
  String pfp;
  String usuario;
  String mail;
  int tema;
  int listMode;
  List<Vehicle> myVehicles;

  Profile(this.pfp, this.usuario, this.mail, this.tema, this.listMode, this.myVehicles);

  String get getPfp { return pfp; }
  String get getUsuario { return usuario; }
  String get getMail { return mail; }
  int get getTema { return tema; }
  int get getListMode { return listMode; }
  List<Vehicle> get getMyVehicles { return myVehicles; }

  void changeTheme(int newTheme) {
    tema = newTheme;
  }

  ThemeData getThemeData(int theme) {
    vehicleList.generateVehicleList();

    switch(theme) {
      case 1: return blueAppTheme(); 
      case 2: return redAppTheme();
    }

    return defaultAppTheme(); 
  }

  void removeVehicle(int i) { myVehicles.removeAt(i); }

  void addVehicle(String vin, String marca, String modelo, String patente, String color, int km, int anio) {
    myVehicles.add(Vehicle("vehicle_default", vin, marca, modelo, patente, color, km, anio));
  }

}

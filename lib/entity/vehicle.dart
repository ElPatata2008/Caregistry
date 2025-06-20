
library;

import 'package:proyecto_dispomoviles/entity/profile.dart' as p;

List<Vehicle> vehicles = [];

class Vehicle {
  String imgPath = '';
  String vin = '';
  String marca = '';
  String modelo = '';
  String patente = '';
  String color = '';
  double km = 0;
  int anio = 0;
  
  Vehicle({ 
    required this.imgPath, 
    required this.vin, 
    required this.marca, 
    required this.modelo, 
    required this.patente, 
    required this.color, 
    required this.km, 
    required this.anio
  });

  String get getImgPath { return imgPath; }
  String get getVIN { return vin; }
  String get getMarca { return marca; }
  String get getModelo { return modelo; }
  String get getPatente { return patente; }
  String get getColor { return color; }
  double get getKm { return km;}
  int get getAnio { return anio;}

}

Future<void> generateVehicleList() async {

  Map<String, dynamic> data = await p.myProfile.readJson();


  if (vehicles.isEmpty) {
    for (int i = 0; i < data['vehiculos'].length; i++) {
      vehicles.add(Vehicle(
        imgPath: data['vehiculos'][i]['img'], 
        vin: data['vehiculos'][i]['vin'], 
        marca: data['vehiculos'][i]['marca'], 
        modelo: data['vehiculos'][i]['modelo'], 
        patente: data['vehiculos'][i]['patente'], 
        color: data['vehiculos'][i]['color'], 
        km: data['vehiculos'][i]['km'], 
        anio: data['vehiculos'][i]['anio'],
      ));
    }
  }
}
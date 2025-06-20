
library;

import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:proyecto_dispomoviles/entity/vehicle.dart';

Profile myProfile = Profile("profile_default.png", "Usuario", "ejemplo", 0, vehicles);

class Profile {
  String pfp;
  String usuario;
  String mail;
  int listMode;
  List<Vehicle> myVehicles;

  Profile(this.pfp, this.usuario, this.mail, this.listMode, this.myVehicles);

  String get getPfp { return pfp; }
  String get getUsuario { return usuario; }
  String get getMail { return mail; }
  int get getListMode { return listMode; }
  List<Vehicle> get getMyVehicles { return myVehicles; }

  Future<void> removeVehicle(int i) async { 
    Map<String, dynamic> data = await readJson();
    data['vehiculos'].removeAt(i);
    myVehicles.removeAt(i); 

    saveJson(data);
  }

  void addVehicle(String img, String vin, String marca, String modelo, String patente, String color, double km, int anio) {
    myVehicles.add(Vehicle(
      imgPath: img, 
      vin: vin, 
      marca: marca, 
      modelo: modelo, 
      patente: patente, 
      color: color, 
      km: km, 
      anio: anio
    ));
  }

  void editVehicle(int i, String img, String vin, String marca, String modelo, String patente, String color, double km, int anio) {
    myVehicles[i].imgPath = img;
    myVehicles[i].vin = vin;
    myVehicles[i].marca = marca;
    myVehicles[i].modelo = modelo;
    myVehicles[i].patente = patente;
    myVehicles[i].color = color;
    myVehicles[i].km = km;
    myVehicles[i].anio = anio;
  }

  double totalKm() {
    double total = 0;
    for (int i = 0; i < myVehicles.length; i++) {
      total += myVehicles[i].getKm;
    }
    return total;
  }

  Future<void> addKM(int i, double km) async {
    Map<String, dynamic> data = await readJson();

    data['vehiculos'][i]['km'] += km;
    myVehicles[i].km += km;

    saveJson(data);
  }

  

  Future<File> get _loadFile async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/vehiculos.json');

    if (!await file.exists()) {
      await file.writeAsString(jsonEncode({"vehiculos": []}));
      print("archivo creado");
    }

    print("archivo encontrado");

    return file;
  }

  Future<void> saveJson(Map<String, dynamic> jsonData) async {
    final file = await _loadFile;
    await file.writeAsString(jsonEncode(jsonData));
    print("archivo guardado");
  }

  Future<Map<String, dynamic>> readJson() async {
    final file = await _loadFile;
    String contenido = await file.readAsStringSync();
    print("archivo cargado");
    return jsonDecode(contenido);
  }

}

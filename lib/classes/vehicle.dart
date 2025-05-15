
library;

List<Vehicle> vehicles = [];

class Vehicle {
  String imgPath = '';
  String vin = '';
  String marca = '';
  String modelo = '';
  String patente = '';
  String color = '';
  int km = 0;
  int anio = 0;
  
  Vehicle(this.imgPath, this.vin, this.marca, this.modelo, this.patente, this.color, this.km, this.anio);

  String get getImgPath { return imgPath; }
  String get getVIN { return vin; }
  String get getMarca { return marca; }
  String get getModelo { return modelo; }
  String get getPatente { return patente; }
  String get getColor { return color; }
  int get getKm { return km;}
  int get getAnio { return anio;}

}

void generateVehicleList() {
  if (vehicles.isEmpty) {
    vehicles.add(Vehicle("hysonata.png", "5NPEC4AC5BH041176", "Hyundai", "Sonata", "GG-EZ-69", "Mate", 856, 2011));
    vehicles.add(Vehicle("alegend.png", "JH4KA7670MC006807", "Acura", "Legend", "GJ-WP-42", "Blanco", 4060, 1991));
    vehicles.add(Vehicle("mbcclass.png", "WDBHA33G2XF844170", "Mercedes Benz", "C Class", "PP-DM-24", "Gris", 300, 1999));
    vehicles.add(Vehicle("honsx.png", "JH4NA1150RT000268", "Acura", "NSX", "AM-GS-12", "Negro", 0, 1994));
    vehicles.add(Vehicle("ffreestyle.png", "1FMZK04185GA30815", "Ford", "Freestyle", "FE-QL-52", "Rojo", 2310, 2005));
  }
}
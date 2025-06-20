import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_dispomoviles/entity/profile.dart' as p;
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/textFields.dart';

class CarAddPage extends StatefulWidget {
  const CarAddPage({super.key});

  @override
  State<CarAddPage> createState() => _CarAddPageState();
}

class _CarAddPageState extends State<CarAddPage> {

  var jsonVehiculo;
  var jsonPerfil;
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;

  final listViewController = ScrollController();
  String img = '';
  final tfcVIN = TextEditingController();
  final tfcMarca = TextEditingController();
  final tfcModelo = TextEditingController();
  final tfcPatente = TextEditingController();
  final tfcColor = TextEditingController();
  final tfcKM = TextEditingController();
  final tfcAnio = TextEditingController();

  Future<void> _loadCameras() async {
    cameras = await availableCameras();
    setState(() => firstCamera = cameras.first);
  }

  Image showImage() {
    if (img.isNotEmpty) {
      return Image.file(
        File(img),
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      "assets/noImage.png",
      fit: BoxFit.contain,
    );
  }

  bool checkIftfcNotEmpty() {
    return img.isNotEmpty ||
           tfcVIN.text.isNotEmpty || 
           tfcMarca.text.isNotEmpty || 
           tfcModelo.text.isNotEmpty || 
           tfcPatente.text.isNotEmpty || 
           tfcColor.text.isNotEmpty || 
           tfcKM.text.isNotEmpty || 
           tfcAnio.text.isNotEmpty;
  }

  bool addCheck() {
    return img.isNotEmpty&&
           tfcVIN.text.isNotEmpty &&
           tfcMarca.text.isNotEmpty &&
           tfcModelo.text.isNotEmpty &&
           tfcPatente.text.isNotEmpty &&
           tfcColor.text.isNotEmpty &&
           tfcKM.text.isNotEmpty &&
           tfcAnio.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tfcVIN.dispose();
    tfcMarca.dispose();
    tfcModelo.dispose();
    tfcPatente.dispose();
    tfcColor.dispose();
    tfcKM.dispose();
    tfcAnio.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          controller: listViewController,
          scrollDirection: Axis.vertical,
          // shrinkWrap: true,
          children: [    
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Text("Añadir Vehículo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: showImage()
                  )
                ),
              ),
            ),
        
            TextButton(
              child: Text("Sacar foto"),
              onPressed: () async {
                await _loadCameras();
                final result = await _getCameraImage(context, firstCamera);
                setState(() => img = result);
              }, 
            ),
        
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: txtfieldCarVINAdd(tfcVIN, "VIN"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  txtfieldCarTextSmallAdd(tfcMarca, "Marca"),
                  txtfieldCarTextSmallAdd(tfcModelo, "Modelo"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                txtfieldCarPatenteAdd(tfcPatente, "Patente"),
                txtfieldCarTextSmallAdd(tfcColor, "Color"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                txtfieldCarNumberAdd(tfcKM, "Kilómetros"),
                txtfieldCarNumberAdd(tfcAnio, "Año"),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text("Salir"),
                  onPressed: () {
                    if (checkIftfcNotEmpty()) {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Hay datos ingresados."),
                          content: const Text("Salir hará que se pierdan los datos ingresados."),
                          actions: [
                            TextButton(
                              child: const Text("Cancelar"),
                              onPressed: () => Navigator.pop(context, 'Cancelar'),
                            ),
                            TextButton(
                              child: const Text("Continuar"),
                              onPressed: () {
                                int count = 0;
                                Navigator.of(context).popUntil((_) => count++ >= 2);
                              },
                            )
                          ],
                        )
                      );
                    }
                    else {
                      Navigator.pop(context);
                    }
                  }
                ),
                
                TextButton(
                  child: Text("Guardar"),
                  onPressed: () async {
                    if (addCheck()) {
                      p.myProfile.addVehicle(
                        img, 
                        tfcVIN.text, 
                        tfcMarca.text, 
                        tfcModelo.text, 
                        tfcPatente.text, 
                        tfcColor.text, 
                        double.parse(tfcKM.text), 
                        int.parse(tfcAnio.text)
                      );
                      Map<String, dynamic> toJson() => {
                        'img': img, 
                        'vin': tfcVIN.text, 
                        'marca': tfcMarca.text, 
                        'modelo': tfcModelo.text, 
                        'patente': tfcPatente.text, 
                        'color': tfcColor.text, 
                        'km': double.parse(tfcKM.text), 
                        'anio': int.parse(tfcAnio.text)
                      };

                      var newVehicle = toJson();

                      Map<String, dynamic> jsonData = await p.myProfile.readJson();

                      jsonData['vehiculos'].add(newVehicle);

                      await p.myProfile.saveJson(jsonData); 

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => DefaultTabController(length: 2, child: HomePage())),
                        (Route route) => false,
                      );
                    }
                    else {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Faltan datos por ingresar"),
                          content: const Text("Verifique que todos los datos estén ingresados"),
                          actions: [
                            TextButton(
                              child: const Text("Aceptar"),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        )
                      );
                    }
                  }, 
                ), 
              ],
            )
        
           
          ],
        ),
      ),
    );
  }
  
}

Future<String> _getCameraImage(BuildContext context, CameraDescription firstCamera) async {

  final result = await Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (context) => TakePicture(camera: firstCamera)
    )
  );

  if (!context.mounted) return '';

  return result;
}
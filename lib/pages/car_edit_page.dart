import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/entity/vehicle.dart' as v;
import 'package:proyecto_dispomoviles/entity/profile.dart' as p;
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/cards.dart';
import 'package:proyecto_dispomoviles/widgets/textFields.dart';

class CarEditPage extends StatefulWidget {
  const CarEditPage({super.key, required this.index});

  final int index;

  @override
  State<CarEditPage> createState() => _CarEditPageState();
}

class _CarEditPageState extends State<CarEditPage> {

  String img = '';
  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;


  final listViewController = ScrollController();
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
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    img = p.myProfile.getMyVehicles[widget.index].getImgPath;
    tfcVIN.text = p.myProfile.getMyVehicles[widget.index].getVIN;
    tfcMarca.text = p.myProfile.getMyVehicles[widget.index].getMarca;
    tfcModelo.text = p.myProfile.getMyVehicles[widget.index].getModelo;
    tfcPatente.text = p.myProfile.getMyVehicles[widget.index].getPatente;
    tfcColor.text = p.myProfile.getMyVehicles[widget.index].getColor;
    tfcKM.text = p.myProfile.getMyVehicles[widget.index].getKm.toStringAsFixed(2);
    tfcAnio.text = p.myProfile.getMyVehicles[widget.index].getAnio.toString();
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
              child: Text("Editar Vehículo",
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
                  child: const Text("Cancelar"),
                  onPressed: () => Navigator.pop(context)
                ),
                
                TextButton(
                  child: Text("Guardar"),
                  onPressed: () async {
                    p.myProfile.editVehicle(
                      widget.index,
                      img,
                      tfcVIN.text, 
                      tfcMarca.text, 
                      tfcModelo.text, 
                      tfcPatente.text, 
                      tfcColor.text, 
                      double.parse(tfcKM.text), 
                      int.parse(tfcAnio.text)
                    );

                    Map<String, dynamic> data = await p.myProfile.readJson();

                    data['vehiculos'][widget.index]['img'] = img;
                    data['vehiculos'][widget.index]['vin'] = tfcVIN.text;
                    data['vehiculos'][widget.index]['marca'] = tfcMarca.text;
                    data['vehiculos'][widget.index]['modelo'] = tfcModelo.text;
                    data['vehiculos'][widget.index]['patente'] = tfcPatente.text;
                    data['vehiculos'][widget.index]['color'] = tfcColor.text;
                    data['vehiculos'][widget.index]['km'] = double.parse(tfcKM.text);
                    data['vehiculos'][widget.index]['anio'] = int.parse(tfcAnio.text);

                    await p.myProfile.saveJson(data);
            
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => DefaultTabController(length: 2, child: HomePage())),
                      (Route route) => false,
                    );
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/entity/profile.dart' as p;
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/texts_style.dart';
import 'package:proyecto_dispomoviles/widgets/themes.dart';

Card vehicleListViewCardInfo(BuildContext context, int i, List<String> info) {

  dynamic image = info[0];
  String vin = info[1];
  String marca = info[2];
  String modelo = info[3];
  String patente = info[4];
  String color = info[5];
  String km = info[6];
  String anio = info[7];

  // String imagePath = "assets/vehicles/$image";

  Row popUpMenuItemRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(width: 10,),
        Expanded(child: Text(text)),
      ],
    );
  }

  return Card(
    elevation: 2.0,
    child: SizedBox(
      height: 187,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(5),
                width: 120.0, height: 120.0,
                decoration: cardImageBoxDecoration(),
                child: Image.file(
                  File(image),
                  fit: BoxFit.cover,
                  // image: AssetImage(imagePath)
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(child: textCard(vin, TextAlign.center)),
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(90 / 360),
                          child: PopupMenuButton(
                            itemBuilder: (BuildContext context) => <PopupMenuEntry> [
                              PopupMenuItem(
                                child: popUpMenuItemRow(Icons.edit, "Editar"),
                                onTap: () => Navigator.push(context,  
                                  MaterialPageRoute(
                                    builder: (context) => CarEditPage(index: i)
                                  )
                                ),
                              ),
                              PopupMenuItem(
                                child: popUpMenuItemRow(Icons.remove_red_eye, "Ver"),
                                onTap: () => Navigator.push(context,  
                                  MaterialPageRoute(
                                    builder: (context) => CarInfoPage(index: i)
                                  )
                                ),
                              ),
                              PopupMenuItem(
                                child: popUpMenuItemRow(Icons.delete, "Borrar"),
                                onTap: () => showDialog(
                                  context: context, 
                                  builder: (BuildContext context) => AlertDialog(
                                    title: Text("ADVERTENCIA", 
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    content: Text("Esta acción no se podrá deshacer y perderá el vehículo registrado. \n\n ¿Continuar de todas formas?"),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context, 'Cancelar'), child: const Text("Cancelar")),
                                      TextButton(onPressed: () {
                                        p.myProfile.removeVehicle(i);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (BuildContext context) => DefaultTabController(length: 2, child: HomePage())),
                                          (Route route) => false,
                                        );
                                      }, 
                                      child: const Text("Aceptar")),
                                    ],
                                  )
                                ),
                              ),
                            ]
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textCard(marca, TextAlign.left),
                            textCard(modelo, TextAlign.left),
                            textCard(patente, TextAlign.left),
                            textCard("", TextAlign.left)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            textCard("$km Km", TextAlign.right),
                            textCard(anio, TextAlign.right),
                            textCard(color, TextAlign.right),
                            textCard("", TextAlign.right),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            height: 50,
            child: Card(
              elevation: 8,
              child: TextButton(
                onPressed: () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => TrackingPage(i: i)
                  )
                ),
                child: const Text("Iniciar Seguimiento"),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Card vehicleGridCardInfo(BuildContext context, int i, List<String> info) {

  dynamic image = info[0];
  String vin = info[1];
  String marca = info[2];
  String modelo = info[3];
  String patente = info[4];
  String color = info[5];
  String km = info[6];
  String anio = info[7];

  // String imagePath = "assets/vehicles/$image";

  return Card(
    child: SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(5),
            decoration: cardImageBoxDecoration(),
            child: Image.file(
              File(image),
              height: 100,
              fit: BoxFit.cover,
              // image: AssetImage(imagePath)
            ),
          ),
          textCard(vin, TextAlign.center),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textCard(marca, TextAlign.left),
                          textCard(modelo, TextAlign.left),
                          textCard(patente, TextAlign.left),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          textCard("$km Km", TextAlign.right),
                          textCard(anio, TextAlign.right),
                          textCard(color, TextAlign.right),
                        ],
                      ),
                    ],
                  ),
            ),
          ),
          Container(
            height: 40,
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 10),
            // decoration: cardButtonBoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context,  
                      MaterialPageRoute(
                        builder: (context) => CarEditPage(index: i)
                      )
                    );
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.push(context,  
                      MaterialPageRoute(
                        builder: (context) => CarInfoPage(index: i)
                      )
                    );
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.delete),
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("ADVERTENCIA", 
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                      content: Text("Esta acción no se podrá deshacer y perderá el vehículo registrado. \n\n ¿Continuar de todas formas?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, 'Cancelar'), child: const Text("Cancelar")),
                        TextButton(onPressed: () {
                          p.myProfile.removeVehicle(i);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => DefaultTabController(length: 2, child: HomePage())),
                            (Route route) => false,
                          );
                        }, 
                        child: const Text("Aceptar")),
                      ],
                    )
                  )
                ), 
              ],
            ),
          ),
          Expanded(
            child: Card(
              child: TextButton(
                child: Text("Iniciar Seguimiento"),
                onPressed: () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => TrackingPage(i: i)
                  )
                ),
              ),
            )
          )
        ],
      ),
    ),
  );
}

Card carInfoCard(String info) {
  return Card(
    elevation: 8.0,
    child: Container(
      margin: EdgeInsets.all(8),
      child: Text(info, 
        textAlign: TextAlign.center,
        textScaler: TextScaler.linear(1.5),
        style: TextStyle(
          color: Colors.white
        ),
      ),
    ),
  );
}

Card settingCard(String text) {
  return Card(
    child: SizedBox(
      height: 50,
      width: 200,
      child: Center(
        child: Text(text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      )
    ),
  );
}

Card profileCard(String text, double textSize) {
  return Card(
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, 
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: textSize,
          color: Colors.white
        ),
      ),
    ),
  );
}

Row infoItem(String info) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: carInfoCard(info)),
    ],
  );
}

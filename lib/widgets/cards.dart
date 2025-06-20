import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/classes/profile.dart' as vManager;
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/texts_style.dart';
import 'package:proyecto_dispomoviles/widgets/themes.dart';

Card vehicleListViewCardInfo(BuildContext context, int i,List<String> info) {

  String image = info[0];
  String vin = info[1];
  String marca = info[2];
  String modelo = info[3];
  String patente = info[4];
  String color = info[5];
  String km = info[6];
  String anio = info[7];

  String imagePath = "assets/vehicles/$image";

  return Card(
    elevation: 2.0,
    child: SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(5),
            decoration: cardImageBoxDecoration(),
            child: Image(
              height: 120.0,
              width: 120.0,
              fit: BoxFit.cover,
              image: AssetImage(imagePath)
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textCard(vin, TextAlign.center),
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
          Container(
            decoration: cardButtonBoxDecoration(),
            margin: EdgeInsets.only(left: 10),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 25,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(context,  
                          MaterialPageRoute(
                            builder: (context) => CarInfoPage(
                              index: i,
                              editMode: true,
                            )
                          )
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        Navigator.push(context,  
                          MaterialPageRoute(
                            builder: (context) => CarInfoPage(
                              index: i,
                              editMode: false,
                            )
                          )
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    height: 25,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.delete),
                      onPressed: () => showDialog(
                        context: context, 
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("¿Eliminar vehículo?"),
                          content: Text("(Por ahora no elimina)"),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, 'Cancelar'), child: const Text("Cancelar")),
                            TextButton(onPressed: () {
                              vManager.myProfile.removeVehicle(i);
                              Navigator.pop(context, 'Aceptar');
                            }, 
                            child: const Text("Aceptar")),
                          ],
                        )
                      ), 
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Card vehicleGridCardInfo(BuildContext context, int i, List<String> info) {

  String image = info[0];
  String vin = info[1];
  String marca = info[2];
  String modelo = info[3];
  String patente = info[4];
  String color = info[5];
  String km = info[6];
  String anio = info[7];

  String imagePath = "assets/vehicles/$image";

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
            child: Image(
              height: 100,
              fit: BoxFit.contain,
              image: AssetImage(imagePath)
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
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 10),
            decoration: cardButtonBoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context,  
                      MaterialPageRoute(
                        builder: (context) => CarInfoPage(
                          index: i,
                          editMode: true,
                        )
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
                        builder: (context) => CarInfoPage(
                          index: i,
                          editMode: false,
                        )
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
                      title: Text("¿Eliminar vehículo?"),
                      content: Text("(Por ahora no elimina)"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, 'Cancelar'), child: const Text("Cancelar")),
                        TextButton(onPressed: () {
                          vManager.myProfile.removeVehicle(i);
                          Navigator.pop(context, 'Aceptar');
                        }, 
                        child: const Text("Aceptar")),
                      ],
                    )
                  ), 
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Card carInfoCard(String info) {
  return Card(
    elevation: 2.0,
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

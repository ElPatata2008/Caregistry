import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/entity/vehicle.dart' as v;
import 'package:proyecto_dispomoviles/entity/profile.dart' as p;
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/cards.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  int listMode = 0;

  void ddCBListMode(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        listMode = selectedValue;
        _saveListModePref();
      });
    }
  }

  Future<void> _loadListModePref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => listMode = prefs.getInt("list") ?? 0);
  }

  Future<void> _saveListModePref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("list", listMode);
  }

  @override
  void initState() {
    super.initState();
    _loadListModePref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: menu(context),
      appBar: AppBar(
        title: Center(child: Text("Bienvenido/a")),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.garage)),
            Tab(icon: Icon(Icons.person))
          ]
        ),
      ),
      body: TabBarView(
        children: [
          checkIfNoEntries(context, listMode), // ===[ Vehicle List ]===
          Column( // ===[ PROFILE / SETTINGS ]===
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                child: Container(
                  width: 150, height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(75),
                    border: Border.all(color: Colors.black, width: 2)
                  ),
                  child: Image(image: AssetImage("assets/profile_default.png"))
                ),
              ),
              profileInfo("Usuario", 18),
              profileInfo("ejemplo.correo@ejemplo.com", 14),
              SizedBox(height: 10,),
              profileInfo("Vehículos Registrados: ${p.myProfile.getMyVehicles.length}", 16),
              profileInfo("${p.myProfile.totalKm().toStringAsFixed(2)} kilómetros totales", 16),
              OutlinedButton(
                style: ButtonStyle(
                  // elevation: 8,
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                    )
                  )
                ),
                child: Text("Añadir vehículo",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => CarAddPage(),
                  )
                ), 
              ),
              SizedBox(height: 40,),
              Text("Configuración"),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  settingCard("Modo de la lista"),
                  Card(
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: DropdownButton(
                          style: TextStyle( color: Colors.white ),
                          dropdownColor: Colors.blueGrey[900],
                          items: const [
                            DropdownMenuItem(value: 1, child: Text("Grid")),
                            DropdownMenuItem(value: 0, child: Text("Lista"))
                          ], 
                          value: listMode,
                          onChanged: ddCBListMode
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              TextButton(
                child: Text("Acerca de la aplicación",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () => Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => About(),
                  )
                ), 
              ),
            ],
          )
        ]
      ),
    );
  }
}

Row profileInfo(String text, double textSize) {
  return Row(
    children: [
      SizedBox(width: 20),
      Expanded(child: profileCard(text, textSize)),
      SizedBox(width: 20),
    ],
  );
}

Widget checkIfNoEntries(BuildContext context, int mode) {
  if (p.myProfile.getMyVehicles.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Icon(
              Icons.minor_crash_sharp,
              size: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            child: Text("Parece que no hay vehículos registrados aún.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
            child: Text("¡Deslice a la derecha para añadir uno!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  return Center( // ===[ Vehicle List ]===
    child: Container(
      height: double.maxFinite,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        // image: DecorationImage(image: AssetImage("assets/placeholders/profile_bg_ph.png"))
      ),
      child: viewMode(context, mode),
    ),
  );
}

Widget viewMode(BuildContext context, int mode) {
  if (mode == 1) return gridList(context); 
  return viewList(context);
}

ListView viewList(BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: p.myProfile.getMyVehicles.length,
    itemBuilder: (context, i) {
      return vehicleListViewCardInfo(context, i,[
          p.myProfile.myVehicles[i].getImgPath, 
          p.myProfile.myVehicles[i].getVIN, 
          p.myProfile.myVehicles[i].getMarca, 
          p.myProfile.myVehicles[i].getModelo, 
          p.myProfile.myVehicles[i].getPatente, 
          p.myProfile.myVehicles[i].getColor, 
          p.myProfile.myVehicles[i].getKm.toStringAsFixed(1), 
          p.myProfile.myVehicles[i].getAnio.toString()
        ]
      );
    }
  );
}

GridView gridList(BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 0.61,
      crossAxisCount: 2
    ),
    scrollDirection: Axis.vertical,
    itemCount: p.myProfile.getMyVehicles.length,
    itemBuilder: (BuildContext context, int i) {
      return vehicleGridCardInfo(context, i, [
          p.myProfile.myVehicles[i].getImgPath,
          p.myProfile.myVehicles[i].getVIN,
          p.myProfile.myVehicles[i].getMarca,
          p.myProfile.myVehicles[i].getModelo,
          p.myProfile.myVehicles[i].getPatente,
          p.myProfile.myVehicles[i].getColor,
          p.myProfile.myVehicles[i].getKm.toStringAsFixed(1),
          p.myProfile.myVehicles[i].getAnio.toString()
        ]
      );
    },
  );
}
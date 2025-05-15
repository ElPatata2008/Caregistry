import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/classes/vehicle.dart' as v;
import 'package:proyecto_dispomoviles/classes/profile.dart' as p;
import 'package:proyecto_dispomoviles/sharedPreferences.dart';
import 'package:proyecto_dispomoviles/widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int themeValue = 0;
  int listMode = 0;

  void ddCbTheme(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        themeValue = selectedValue;
        p.myProfile.changeTheme(themeValue);
      });
    }
  }

  void ddCBListMode(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        listMode = selectedValue;
        setListMode(selectedValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: menu(context),
      appBar: AppBar(
        title: Text("Bienvenido/a"),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.house),),
            Tab(icon: Icon(Icons.settings),)
          ]
        ),
      ),
      body: TabBarView(
        children: [
          Center(
            child: Container(
              height: double.maxFinite,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                // image: DecorationImage(image: AssetImage("assets/placeholders/profile_bg_ph.png"))
              ),
              child: viewMode(context, listMode),
            ),
          ),
          profile(themeValue, ddCbTheme, listMode, ddCBListMode)
        ]
      ),
    );
  }
}

Widget profile(int themeValue, var ddCbTheme, int listMode, var ddCBListMode) {
  return Column(
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
      SizedBox(height: 50,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          settingCard("Tema"),
          Card(
            child: SizedBox(
              height: 50,
              width: 100,
              child: Center(
                child: DropdownButton(
                  style: TextStyle( color: Colors.white ),
                  dropdownColor: Colors.blueGrey[900],
                  items: const [
                    DropdownMenuItem(value: 0, child: Text("Default")),
                    DropdownMenuItem(value: 1, child: Text("Blue")),
                    DropdownMenuItem(value: 2, child: Text("Red"))
                  ], 
                  value: themeValue,
                  onChanged: ddCbTheme
                ),
              ),
            ),
          )
        ],
      ),
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
    ],
  );
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

Widget viewMode(BuildContext context, mode) {
  // Future<int?> mode = getListMode();

  if (mode == 1) { return gridList(context); }

  return viewList(context);
}

ListView viewList(BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: p.myProfile.getMyVehicles.length,
    itemBuilder: (context, i) {
      return vehicleListViewCardInfo(context, i, [
          v.vehicles[i].getImgPath, 
          v.vehicles[i].getVIN, 
          v.vehicles[i].getMarca, 
          v.vehicles[i].getModelo, 
          v.vehicles[i].getPatente, 
          v.vehicles[i].getColor, 
          v.vehicles[i].getKm.toString(), 
          v.vehicles[i].getAnio.toString()
        ]
      );
    }
  );
}

GridView gridList(BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 0.72,
      crossAxisCount: 2
    ),
    scrollDirection: Axis.vertical,
    itemCount: p.myProfile.getMyVehicles.length,
    itemBuilder: (BuildContext context, int i) {
      return vehicleGridCardInfo(context, i, [
          v.vehicles[i].getImgPath,
          v.vehicles[i].getVIN,
          v.vehicles[i].getMarca,
          v.vehicles[i].getModelo,
          v.vehicles[i].getPatente,
          v.vehicles[i].getColor,
          v.vehicles[i].getKm.toString(),
          v.vehicles[i].getAnio.toString()
        ]
      );
    },
  );
}
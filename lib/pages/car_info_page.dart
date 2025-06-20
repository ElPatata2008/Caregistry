import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/entity/vehicle.dart' as v;
import 'package:proyecto_dispomoviles/entity/profile.dart' as p;
import 'package:proyecto_dispomoviles/widgets/cards.dart';

class CarInfoPage extends StatefulWidget {
  const CarInfoPage({super.key, required this.index});

  final int index;

  @override
  State<CarInfoPage> createState() => _CarInfoPageState();
}

class _CarInfoPageState extends State<CarInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 250, height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(v.vehicles[widget.index].getImgPath),
                      fit: BoxFit.cover
                      // image: AssetImage("assets/vehicles/${v.vehicles[widget.index].getImgPath}")
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  children: [
                    infoItem(p.myProfile.myVehicles[widget.index].getVIN),
                    Row(
                      children: [
                        Expanded(child: carInfoCard(p.myProfile.myVehicles[widget.index].getMarca)),
                        Expanded(child: carInfoCard(p.myProfile.myVehicles[widget.index].getModelo)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: carInfoCard(p.myProfile.myVehicles[widget.index].getPatente)),
                        Expanded(child: carInfoCard(p.myProfile.myVehicles[widget.index].getColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: carInfoCard("${p.myProfile.myVehicles[widget.index].getKm.toStringAsFixed(2)} km")),
                        Expanded(child: carInfoCard("Año ${p.myProfile.myVehicles[widget.index].getAnio}")),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextButton(
                  child: Text("Volver",
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () => Navigator.pop(context), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
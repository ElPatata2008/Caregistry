import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/classes/vehicle.dart' as v;
import 'package:proyecto_dispomoviles/widgets/cards.dart';

class CarInfoPage extends StatefulWidget {
  const CarInfoPage({
    super.key, 
    required this.index, 
    required this.editMode, 
  });

  final int index;
  final bool editMode;

  @override
  State<CarInfoPage> createState() => _CarInfoPageState();
}

class _CarInfoPageState extends State<CarInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 3,
                )
              ),
              child: Image(image: AssetImage("assets/vehicles/${v.vehicles[widget.index].getImgPath}")),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  infoItem(v.vehicles[widget.index].getVIN, widget.editMode, widget.index),
                  infoItem(v.vehicles[widget.index].getMarca, widget.editMode, widget.index),
                  infoItem(v.vehicles[widget.index].getModelo, widget.editMode, widget.index),
                  infoItem(v.vehicles[widget.index].getPatente, widget.editMode, widget.index),
                  infoItem(v.vehicles[widget.index].getColor, widget.editMode, widget.index),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Row infoItem(String info, bool editMode, int index) {
  if (editMode) { return infoItemEdit(info, editMode, index); }
  return infoItemNoEdit(info, editMode);
}

Row infoItemEdit(String info, bool editMode, int index) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: carInfoCard(info)
      ),
      Card(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        elevation: 2.0,
        child: IconButton(
          color: Colors.white,
          icon: Icon(Icons.edit),
          onPressed: () {
            
          }, 
        ),
      )
    ],
  );
}

Row infoItemNoEdit(String info, bool editMode) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: carInfoCard(info)
      ),
    ],
  );
}
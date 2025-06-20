import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/pages/preguntas.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text("Caregistry",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Text(
                  "Caregistry está enfocado en el registro de los vehículos propios, permitiendo mantener el kilometraje de los mismos, facilitando al usuario planear bien sus citas a mantención.",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Text(
                  "Mantener el seguimiento del kilometraje de sus vehículos no es la única ídea, más adelante se planea añadir más formas de administrar sus vehículos, como recordatorios de llenar combustible.",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Card(
                  elevation: 8,
                  child: TextButton(
                    child: Text("Su opinión también nos interesa"),
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => Preguntas()
                      )
                    ), 
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mail),
                        SizedBox(width: 10,),
                        Text('pedrojavier.morales13@gmail.com',)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 10,),
                        Text('+56 9 5905 3889',)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 8,
        onPressed: () => Navigator.pop(context),
        label: Text("Volver")
      ),
    );
  }
}
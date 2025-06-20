import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:proyecto_dispomoviles/pages/pages_manager.dart';
import 'package:proyecto_dispomoviles/widgets/themes.dart';
import 'package:share_plus/share_plus.dart';

enum Grupo { proyecto, area, externo }
enum Afiliacion { colega, familia, otro}

class Preguntas extends StatefulWidget {
  const Preguntas({super.key});

  @override
  State<Preguntas> createState() => _PreguntasState();
}

class _PreguntasState extends State<Preguntas> {

  int page = 0;

  late MailOptions mail;
  late double finalRating;
  late double usabilidad;
  late double contenido;
  late double compartir;

  int usabilidadRating1 = 0;
  int usabilidadRating2 = 0;
  int usabilidadRating3 = 0;

  int contenidoRating1 = 0;
  int contenidoRating2 = 0;
  int contenidoRating3 = 0;

  int compartirRating1 = 0;
  int compartirRating2 = 0;
  int compartirRating3 = 0;

  final tfcNombre = TextEditingController();
  Grupo grupoPersona = Grupo.proyecto;
  Afiliacion afiliacionPersona = Afiliacion.colega;

  var jsonData;

  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString('assets/preguntas.json');
    final data = jsonDecode(jsonString);
    setState(() => jsonData = data);
  }

  List<Widget> listPregs() {
    switch (page) {
      case 0: return [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Text("Datos Personales", style: TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: TextField(
            autofocus: tfcNombre.text.isEmpty ? true : false,
            decoration: addPageInputDecoration("Nombre"),
            controller: tfcNombre,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: SegmentedButton(
            direction: Axis.vertical,
            selectedIcon: Icon(Icons.arrow_forward_ios),
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                )
              )
            ),
            segments: [
              ButtonSegment(
                value: Grupo.proyecto,
                label: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 60,
                  child: Text("Trabajando en Proyecto",
                    textAlign: TextAlign.left,
                  )
                ),
              ),
              ButtonSegment(
                value: Grupo.area,
                label: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 60,
                  child: Text("Trabajando en la misma área",
                    textAlign: TextAlign.left,
                  )
                ),
              ),
              ButtonSegment(
                value: Grupo.externo,
                label: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 60,
                  child: Text("Persona Externa",
                    textAlign: TextAlign.left,
                  )
                ),
              ),
            ], 
            selected: <Grupo>{grupoPersona},
            onSelectionChanged: (newSelection) => setState(() => grupoPersona = newSelection.first)
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: SegmentedButton(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: Afiliacion.colega,
                label: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 60,
                  child: Text("Colega",
                    textAlign: TextAlign.center,
                  )
                ),
              ),
              ButtonSegment(
                value: Afiliacion.familia,
                label: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 60,
                  child: Text("Familia",
                    textAlign: TextAlign.center,
                  )
                ),
              ),
              ButtonSegment(
                value: Afiliacion.otro,
                label: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 60,
                  child: Text("Otro",
                    textAlign: TextAlign.center,
                  )
                ),
              ),
            ], 
            selected: <Afiliacion>{afiliacionPersona},
            onSelectionChanged: (newSelection) => setState(() => afiliacionPersona = newSelection.first),
          ),
        )
      ];
      case 1: return [
        Text("Usabilidad", style: TextStyle(fontSize: 20)),
        pregunta([
          Text(jsonData["usabilidad"][0]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{usabilidadRating1},
            onSelectionChanged: (newSelection) => setState(() => usabilidadRating1 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
        pregunta([
          Text(jsonData["usabilidad"][1]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{usabilidadRating2},
            onSelectionChanged: (newSelection) => setState(() => usabilidadRating2 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
        pregunta([
                Text(jsonData["usabilidad"][2]["titulo"]),
                SegmentedButton(
                  segments: [
                    ButtonSegment(value: 0, label: Text("0")),
                    ButtonSegment(value: 1, label: Text("1")),
                    ButtonSegment(value: 2, label: Text("2")),
                    ButtonSegment(value: 3, label: Text("3")),
                    ButtonSegment(value: 4, label: Text("4")),
                    ButtonSegment(value: 5, label: Text("5")),
                  ], 
                  selected: <int>{usabilidadRating3},
                  onSelectionChanged: (newSelection) => setState(() => usabilidadRating3 = newSelection.first),
                  selectedIcon: Icon(Icons.star),
                ),
              ]),
      ];
      case 2: return [
        Text("Contenido", style: TextStyle(fontSize: 20)),
        pregunta([
          Text(jsonData["contenido"][0]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{contenidoRating1},
            onSelectionChanged: (newSelection) => setState(() => contenidoRating1 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
        pregunta([
          Text(jsonData["contenido"][1]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{contenidoRating2},
            onSelectionChanged: (newSelection) => setState(() => contenidoRating2 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
        pregunta([
          Text(jsonData["contenido"][2]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{contenidoRating3},
            onSelectionChanged: (newSelection) => setState(() => contenidoRating3 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
        
      ];
      case 3: return [
        Text("Compartir", style: TextStyle(fontSize: 20)),
        pregunta([
          Text(jsonData["compartir"][0]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{compartirRating1},
            onSelectionChanged: (newSelection) => setState(() => compartirRating1 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
        pregunta([
          Text(jsonData["compartir"][1]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{compartirRating2},
            onSelectionChanged: (newSelection) => setState(() => compartirRating2 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
        pregunta([
          Text(jsonData["compartir"][2]["titulo"]),
          SegmentedButton(
            segments: [
              ButtonSegment(value: 0, label: Text("0")),
              ButtonSegment(value: 1, label: Text("1")),
              ButtonSegment(value: 2, label: Text("2")),
              ButtonSegment(value: 3, label: Text("3")),
              ButtonSegment(value: 4, label: Text("4")),
              ButtonSegment(value: 5, label: Text("5")),
            ], 
            selected: <int>{compartirRating3},
            onSelectionChanged: (newSelection) => setState(() => compartirRating3 = newSelection.first),
            selectedIcon: Icon(Icons.star),
          ),
        ]),
      ];
      case 4: return [
        Text(
          "Gracias por su tiempo.\n Envie su respuesta si siente que está todo correcto.", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20)
        ),
        TextButton(
          child: Text("Enviar", style: TextStyle(fontSize: 18),),
          onPressed: () async {
            getFinalRating();
            const String gmail_schema = 'com.google.android.gm';
            final bool gmailInstalled = await FlutterMailer.isAppInstalled(gmail_schema); 

            if (gmailInstalled) {
              final String grupo = translateGrupo();
              final String afiliacion = translateAfiliacion();

              final MailOptions mail = MailOptions(
                recipients: ['pedrojavier.morales13@gmail.com'],
                subject: 'Validación de Usuario',
                body: 'Nombre: ${tfcNombre.text} <br> Grupo: $grupo <br> Afiliación: $afiliacion <br><br> Rating en Usabilidad: ${usabilidad.toStringAsFixed(2)} <br> Rating en Contenido: ${contenido.toStringAsFixed(2)} <br> Rating en Compartir: ${compartir.toStringAsFixed(2)} <br><br> Rating Final: ${finalRating.toStringAsFixed(2)}',
                isHTML: true,
                appSchema: gmail_schema
              );

              final MailerResponse response = await FlutterMailer.send(mail);

              late String status; 
              late bool sent;
              switch (response) {
                case MailerResponse.sent: 
                  status = "Correo enviado con éxito"; 
                  sent = true;
                break;
                case MailerResponse.saved: 
                  status = "Correo guardado"; 
                  sent = true;
                break;
                case MailerResponse.cancelled:  
                  status = "Envio cancelado"; 
                  sent = false;
                break;
                case MailerResponse.android:  
                  status = "Correo enviado con éxito"; 
                  sent = true;
                break;
                case MailerResponse.unknown: 
                  status = "Desconocido"; 
                  sent = false;
                break;
              }

              showDialog(
                context: context, 
                builder: (BuildContext context) => AlertDialog(
                  title: Text("Información"),
                  content: Text(status),
                  actions: [TextButton(
                    child: Text("Aceptar"),
                    onPressed: () {
                      if (sent) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => DefaultTabController(length: 2, child: HomePage())),
                          (Route route) => false,
                        );
                      }
                      else {
                        Navigator.pop(context);
                      }
                    }, 
                  )],
                )
              );
            }
          }, 
        )
      ];
    }
    return [Text("ඞ")];
  }

  List<Widget> navButtons() {
    return [
      TextButton(
        child: Text("Volver"),
        onPressed: () => showDialog(
          context: context, 
          builder: (BuildContext context) => AlertDialog(
            title: Text("Advertencia"),
            content: Text("¿Seguro que desea volver? Los datos ingresados no se guardaran."),
            actions: [
              TextButton(
                child: Text("Permanecer"),
                onPressed: () => Navigator.pop(context), 
              ),
              TextButton(
                child: Text("Volver"),
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                }, 
              )
            ],
          )
        ), 
      ),
      TextButton(
        child: Text("Atrás"),
        onPressed: () => pageBackward(), 
      ),
      TextButton(
        child: Text("Continuar"),
        onPressed: () { 
          if (tfcNombre.text.isEmpty)  {
            showDialog(
              context: context, 
              builder: (BuildContext context) => AlertDialog(
                title: Text("Advertencia"),
                content: Text("Por favor ingrese su nombre"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: Text("Aceptar")
                  )
                ],
              )
            );
          } else {
            pageFordward();
          }
        }, 
      ),
    ];
  }

  void pageFordward() => setState(() { if (page < 4) page++; });
  void pageBackward() => setState(() { if (page > 0) page--; });

  void getFinalRating() { 
    int usabilidad = usabilidadRating1 + usabilidadRating2 + usabilidadRating3;
    int contenido = contenidoRating1 + contenidoRating2 + contenidoRating3;
    int compartir = compartirRating1 + compartirRating2 + compartirRating3;
    setState(() {
      this.usabilidad = usabilidad / 3;
      this.contenido = contenido / 3;
      this.compartir = compartir / 3;
      finalRating = (usabilidad + contenido + compartir) / 9;
    });
  }

  String translateGrupo() {
    switch (grupoPersona) {
      case Grupo.proyecto: return "Trabajando en Proyecto";
      case Grupo.area: return "Trabajando en la misma área";
      case Grupo.externo:return "Persona Externa";
    }
  }

  String translateAfiliacion() {
    switch (afiliacionPersona) {
      case Afiliacion.colega: return "Colega";
      case Afiliacion.familia: return "Familia";
      case Afiliacion.otro: return "Otro";
    }
  }

  @override
  void initState() {
    super.initState();
    loadJsonAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: navButtons(),
      body: Center(
        child: jsonData != null 
          ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 70, 30, 0),
                child: Text("Valoración",
                  style: TextStyle(
                    fontSize: 30
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listPregs()
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ],
          )   
          : CircularProgressIndicator()
      ),
    );
  }
}

Widget pregunta(List<Widget> widgets) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
    child: Column(
      children: widgets,
    ),
  );
}

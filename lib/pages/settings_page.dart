import 'package:flutter/material.dart';
import 'package:proyecto_dispomoviles/sharedPreferences.dart';
import 'package:proyecto_dispomoviles/widgets/cards.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  int themeValue = 0;
  int listMode = 0;

  void ddCbTheme(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        themeValue = selectedValue;
        setTheme(themeValue);
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
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text("Por ahora la configuración no funciona",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:shared_preferences/shared_preferences.dart';


// Set Data
Future<void> setListMode(int mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('viewMode', mode);
}

Future<void> setTheme(int theme) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('theme', theme);
}


// Get Data
Future<int?> getListMode() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('viewMode') ?? 0;
}

Future<int?> getTheme() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('theme') ?? 0;
}
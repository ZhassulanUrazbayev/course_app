import 'package:shared_preferences/shared_preferences.dart';

getStringValueSP(String valueName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString(valueName);
  return stringValue;
}
getBoolValueSP(String valueName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool boolValue = prefs.getBool(valueName);
  return boolValue;
}
getIntValueSP(String valueName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int intValue = prefs.getInt(valueName);
  return intValue;
}
getDoubleValueSP(String valueName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return double
  double doubleValue = prefs.getDouble(valueName);
  return doubleValue;
}

addStringValueSP(String valueName, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //add String value
  var stringValue = prefs.setString(valueName, value);
}
addBoolValueSP(String valueName, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //add bool value
  var boolValue = prefs.setBool(valueName, value);
}
addIntValueSP(String valueName, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //add int value
  var intValue = prefs.setInt(valueName, value);
}
addDoubleValueSP(String valueName, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //add double value
  var doubleValue = prefs.setDouble(valueName, value);
}

removeValue(String valueName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove(valueName);
}
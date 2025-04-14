import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _loginAmt = prefs.getInt('ff_loginAmt') ?? _loginAmt;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<double> _CalorieReturn = [];
  List<double> get CalorieReturn => _CalorieReturn;
  set CalorieReturn(List<double> value) {
    _CalorieReturn = value;
  }

  void addToCalorieReturn(double value) {
    CalorieReturn.add(value);
  }

  void removeFromCalorieReturn(double value) {
    CalorieReturn.remove(value);
  }

  void removeAtIndexFromCalorieReturn(int index) {
    CalorieReturn.removeAt(index);
  }

  void updateCalorieReturnAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    CalorieReturn[index] = updateFn(_CalorieReturn[index]);
  }

  void insertAtIndexInCalorieReturn(int index, double value) {
    CalorieReturn.insert(index, value);
  }

  dynamic _calorieNinjaAPIJSON;
  dynamic get calorieNinjaAPIJSON => _calorieNinjaAPIJSON;
  set calorieNinjaAPIJSON(dynamic value) {
    _calorieNinjaAPIJSON = value;
  }

  int _loginAmt = 0;
  int get loginAmt => _loginAmt;
  set loginAmt(int value) {
    _loginAmt = value;
    prefs.setInt('ff_loginAmt', value);
  }

  String _zenQuote = '';
  String get zenQuote => _zenQuote;
  set zenQuote(String value) {
    _zenQuote = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

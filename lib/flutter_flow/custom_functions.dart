import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

double addCalories(
  List<double> foodFacts,
  bool allowCalorieIntake,
  String userId,
) {
  // write the updateCaloreIntake function
  if (!allowCalorieIntake) {
    return 0.0; // Return 0 if calorie intake is not allowed
  }

  double totalCalories = 0.0;
  for (double calories in foodFacts) {
    totalCalories += calories; // Sum up the calories from food facts
  }

  return totalCalories; // Return the total calorie intake
}

List<String> breakJSONToList(dynamic calorieNinjaAPIResponse) {
  if (calorieNinjaAPIResponse == null) {
    return [];
  }

  List<dynamic> foodItems = calorieNinjaAPIResponse['items'];
  List<Map<String, dynamic>> result = [];
  List<String> strResult = [];

  for (var item in foodItems) {
    String name = item['name'];
    double calories = item['calories'];
    strResult.add("$name: $calories calories");
    result.add({'name': name, 'calories': calories});
  }

  return strResult;
}

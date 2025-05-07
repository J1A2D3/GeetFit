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

double calculateProgress(
  int completed,
  int total,
) {
  if (total == 0) return 0.0;
  return completed / total;
}

int? calcAge(DateTime? birthday) {
  if (birthday == null) return null; // Return null if birthday is null
  DateTime today = DateTime.now(); // Get the current date
  int age =
      today.year - birthday.year; // Calculate age based on year difference
  if (today.month < birthday.month ||
      (today.month == birthday.month && today.day < birthday.day)) {
    age--; // Adjust age if birthday hasn't occurred yet this year
  }
  return age; // Return the calculated age
}

double? calorieLossCalculator(
  double userWeight,
  double met,
  double timeSpent,
) {
// use this formula Calories Burned=MET×Weight (kg)×Time (hours). make sure to covert weight from lbs to kg and time from minutes to hours
  if (timeSpent == null) {
    return null; // Return null if timeSpent is not provided
  }

  double weightInKg = userWeight * 0.453592; // Convert weight from lbs to kg
  double timeInHours = timeSpent / 60; // Convert time from minutes to hours

  return met * weightInKg * timeInHours; // Calculate and return calories burned
}

int weeklyReset() {
  int now = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
  return (now / 604800).floor() * 604800 + (86400 * 3);
}

bool newWeek(int pastTime) {
  int now = (DateTime.now().millisecondsSinceEpoch / 1000).floor();

  if (pastTime + 604800 < now) {
    return true;
  }

  return false;
}

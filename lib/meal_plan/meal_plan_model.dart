import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'meal_plan_widget.dart' show MealPlanWidget;
import 'package:flutter/material.dart';

class MealPlanModel extends FlutterFlowModel<MealPlanWidget> {
  ///  Local state fields for this page.

  bool editMeal1 = false;

  bool editMeal2 = false;

  bool editMeal3 = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Set_Meal_1 widget.
  FocusNode? setMeal1FocusNode;
  TextEditingController? setMeal1TextController;
  String? Function(BuildContext, String?)? setMeal1TextControllerValidator;
  // State field(s) for Set_Meal_2 widget.
  FocusNode? setMeal2FocusNode;
  TextEditingController? setMeal2TextController;
  String? Function(BuildContext, String?)? setMeal2TextControllerValidator;
  // State field(s) for Set_Meal_3 widget.
  FocusNode? setMeal3FocusNode;
  TextEditingController? setMeal3TextController;
  String? Function(BuildContext, String?)? setMeal3TextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    setMeal1FocusNode?.dispose();
    setMeal1TextController?.dispose();

    setMeal2FocusNode?.dispose();
    setMeal2TextController?.dispose();

    setMeal3FocusNode?.dispose();
    setMeal3TextController?.dispose();
  }
}

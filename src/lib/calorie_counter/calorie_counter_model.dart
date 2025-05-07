import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'calorie_counter_widget.dart' show CalorieCounterWidget;
import 'package:flutter/material.dart';

class CalorieCounterModel extends FlutterFlowModel<CalorieCounterWidget> {
  ///  Local state fields for this page.

  bool allowCalorieIncrease = false;

  bool allowFoodInput = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Food_Name widget.
  FocusNode? foodNameFocusNode;
  TextEditingController? foodNameTextController;
  String? Function(BuildContext, String?)? foodNameTextControllerValidator;
  // Stores action output result for [Backend Call - API (CalorieNinja)] action in Button widget.
  ApiCallResponse? apiResulttfv;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    foodNameFocusNode?.dispose();
    foodNameTextController?.dispose();
  }
}

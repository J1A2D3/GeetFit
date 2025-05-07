import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'calorie_loss_widget.dart' show CalorieLossWidget;
import 'package:flutter/material.dart';

class CalorieLossModel extends FlutterFlowModel<CalorieLossWidget> {
  ///  Local state fields for this page.

  double? met = 1.0;

  double? customCal;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for SetTimeWorkout widget.
  FocusNode? setTimeWorkoutFocusNode1;
  TextEditingController? setTimeWorkoutTextController1;
  String? Function(BuildContext, String?)?
      setTimeWorkoutTextController1Validator;
  // State field(s) for SetTimeWorkout widget.
  FocusNode? setTimeWorkoutFocusNode2;
  TextEditingController? setTimeWorkoutTextController2;
  String? Function(BuildContext, String?)?
      setTimeWorkoutTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    setTimeWorkoutFocusNode1?.dispose();
    setTimeWorkoutTextController1?.dispose();

    setTimeWorkoutFocusNode2?.dispose();
    setTimeWorkoutTextController2?.dispose();
  }
}

import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_a_i_widget.dart' show MyAIWidget;
import 'package:flutter/material.dart';

class MyAIModel extends FlutterFlowModel<MyAIWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [AI Agent - Send Message to Fitness] action in Button widget.
  String? fitnessResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}

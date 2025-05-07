import '/flutter_flow/flutter_flow_util.dart';
import 'new_task_widget.dart' show NewTaskWidget;
import 'package:flutter/material.dart';

class NewTaskModel extends FlutterFlowModel<NewTaskWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleTextController;
  String? Function(BuildContext, String?)? titleTextControllerValidator;
  // State field(s) for Descript widget.
  FocusNode? descriptFocusNode;
  TextEditingController? descriptTextController;
  String? Function(BuildContext, String?)? descriptTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleFocusNode?.dispose();
    titleTextController?.dispose();

    descriptFocusNode?.dispose();
    descriptTextController?.dispose();
  }
}

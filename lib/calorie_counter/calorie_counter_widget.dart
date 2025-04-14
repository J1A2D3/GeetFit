import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calorie_counter_model.dart';
export 'calorie_counter_model.dart';

class CalorieCounterWidget extends StatefulWidget {
  const CalorieCounterWidget({super.key});

  static String routeName = 'calorie_counter';
  static String routePath = '/calorieCounter';

  @override
  State<CalorieCounterWidget> createState() => _CalorieCounterWidgetState();
}

class _CalorieCounterWidgetState extends State<CalorieCounterWidget> {
  late CalorieCounterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalorieCounterModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'calorie_counter'});
    _model.foodNameTextController ??= TextEditingController();
    _model.foodNameFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AuthUserStreamWidget(
                  builder: (context) => Text(
                    'Total Calories:  ${formatNumber(
                      valueOrDefault(currentUserDocument?.calorieIntake, 0.0),
                      formatType: FormatType.custom,
                      format: '#####0.00',
                      locale: '',
                    )}',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('CALORIE_COUNTER_Image_kpu87f6c_ON_TAP');
                    logFirebaseEvent('Image_navigate_to');

                    context.pushNamed(HomePageWidget.routeName);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/GeetFitLogo.png',
                      width: 160.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _model.foodNameTextController,
                    focusNode: _model.foodNameFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.foodNameTextController',
                      Duration(milliseconds: 2000),
                      () => safeSetState(() {}),
                    ),
                    autofocus: false,
                    readOnly: _model.allowFoodInput == false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                      hintText: 'Enter Food',
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondary,
                      suffixIcon: _model.foodNameTextController!.text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.foodNameTextController?.clear();
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                size: 24.0,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: null,
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    validator: _model.foodNameTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('CALORIE_COUNTER_GET_CALORIES_BTN_ON_TAP');
                    logFirebaseEvent('Button_backend_call');
                    _model.apiResulttfv = await CalorieNinjaCall.call(
                      userInput: _model.foodNameTextController.text,
                    );

                    if ((_model.apiResulttfv?.succeeded ?? true)) {
                      logFirebaseEvent('Button_update_app_state');
                      FFAppState().CalorieReturn =
                          CalorieNinjaCall.calorieAPIReturn(
                        (_model.apiResulttfv?.jsonBody ?? ''),
                      )!
                              .toList()
                              .cast<double>();
                      safeSetState(() {});
                      logFirebaseEvent('Button_update_app_state');
                      FFAppState().calorieNinjaAPIJSON =
                          (_model.apiResulttfv?.jsonBody ?? '');
                      safeSetState(() {});
                    }

                    safeSetState(() {});
                  },
                  text: 'Get Calories',
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 70.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconAlignment: IconAlignment.end,
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).tertiary,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    height: 300.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).accent4,
                          FlutterFlowTheme.of(context).tertiary
                        ],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(0.0, -1.0),
                        end: AlignmentDirectional(0, 1.0),
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300.0,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final foodFacts = functions
                                    .breakJSONToList(
                                        FFAppState().calorieNinjaAPIJSON)
                                    .toList();

                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: foodFacts.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 10.0),
                                  itemBuilder: (context, foodFactsIndex) {
                                    final foodFactsItem =
                                        foodFacts[foodFactsIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 20.0, 0.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          foodFactsItem,
                                          'Calories',
                                        ),
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 4.0)),
                    ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    logFirebaseEvent('CALORIE_COUNTER_Button_meu8p3t9_ON_TAP');
                    logFirebaseEvent('Button_update_page_state');
                    _model.allowCalorieIncrease = !_model.allowCalorieIncrease;
                    _model.allowFoodInput = !_model.allowFoodInput;
                    safeSetState(() {});
                    if (_model.allowCalorieIncrease == true) {
                      logFirebaseEvent('Button_backend_call');

                      await currentUserReference!.update({
                        ...mapToFirestore(
                          {
                            'Calorie_Intake': FieldValue.increment(
                                functions.addCalories(
                                    FFAppState().CalorieReturn.toList(),
                                    true,
                                    currentUserUid)),
                          },
                        ),
                      });
                    }
                  },
                  text: _model.allowCalorieIncrease == false
                      ? 'Add Calories'
                      : 'Change Food',
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 70.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconAlignment: IconAlignment.end,
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).tertiary,
                    textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 1.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'CALORIE_COUNTER_CalorieCount_To_Home_ON_');
                      logFirebaseEvent(
                          'CalorieCount_To_Home_google_analytics_ev');
                      logFirebaseEvent(
                        'leaveMealPlan',
                        parameters: {
                          'Param24': 'exitMealPlanButton',
                        },
                      );
                      logFirebaseEvent('CalorieCount_To_Home_navigate_to');

                      context.goNamed(HomePageWidget.routeName);
                    },
                    text: 'Back To Home',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).tertiary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

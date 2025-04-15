import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'onboarding_model.dart';
export 'onboarding_model.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  static String routeName = 'Onboarding';
  static String routePath = '/onboarding';

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late OnboardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Onboarding'});
    _model.fullNameTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      valueOrDefault(currentUserDocument?.fullName, ''),
      'Full Name',
    ));
    _model.fullNameFocusNode ??= FocusNode();

    _model.usernameTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      valueOrDefault(currentUserDocument?.username, ''),
      'Username',
    ));
    _model.usernameFocusNode ??= FocusNode();

    _model.weightTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      valueOrDefault(currentUserDocument?.weight, 0.0).toString(),
      'Weight',
    ));
    _model.weightFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      currentPhoneNumber,
      'Phone Number',
    ));
    _model.phoneNumberFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (getRemoteConfigBool('NewLogo'))
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/GeetFitLogo.png',
                          width: 160.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        logFirebaseEvent(
                            'ONBOARDING_PAGE_Stack_pfrz6jcg_ON_TAP');
                        logFirebaseEvent('Stack_upload_media_to_firebase');
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          maxWidth: 68.00,
                          allowPhoto: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          safeSetState(() => _model.isDataUploading = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          var downloadUrls = <String>[];
                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                (m) async =>
                                    await uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((u) => u != null)
                                .map((u) => u!)
                                .toList();
                          } finally {
                            _model.isDataUploading = false;
                          }
                          if (selectedUploadedFiles.length ==
                                  selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            safeSetState(() {
                              _model.uploadedLocalFile =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl = downloadUrls.first;
                            });
                          } else {
                            safeSetState(() {});
                            return;
                          }
                        }

                        logFirebaseEvent('Stack_backend_call');

                        await currentUserReference!
                            .update(createUsersRecordData(
                          photoUrl: _model.uploadedFileUrl,
                        ));
                      },
                      child: Stack(
                        alignment: AlignmentDirectional(-1.0, 1.0),
                        children: [
                          AuthUserStreamWidget(
                            builder: (context) => Container(
                              width: 68.0,
                              height: 68.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    valueOrDefault<String>(
                                      currentUserPhoto,
                                      'https://images.unsplash.com/photo-1557188969-16b469a5b6c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxiZWF1dGlmdWwlMjBvY2VhbnxlbnwwfHx8fDE3NDM0NTQ1Mzh8MA&ixlib=rb-4.0.3&q=80&w=400',
                                    ),
                                  ).image,
                                ),
                                borderRadius: BorderRadius.circular(68.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor:
                                FlutterFlowTheme.of(context).primaryText,
                            borderRadius: 20.0,
                            buttonSize: 37.0,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            icon: Icon(
                              Icons.add,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 21.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                    AuthUserStreamWidget(
                      builder: (context) => Container(
                        width: double.infinity,
                        child: TextFormField(
                          key: ValueKey('FullName_nkc6'),
                          controller: _model.fullNameTextController,
                          focusNode: _model.fullNameFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.fullNameTextController',
                            Duration(milliseconds: 2000),
                            () async {
                              logFirebaseEvent(
                                  'ONBOARDING_FullName_ON_TEXTFIELD_CHANGE');
                              logFirebaseEvent('FullName_backend_call');

                              await currentUserReference!
                                  .update(createUsersRecordData(
                                fullName: _model.fullNameTextController.text,
                              ));
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Full Name',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
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
                            suffixIcon: _model
                                    .fullNameTextController!.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      _model.fullNameTextController?.clear();
                                      logFirebaseEvent(
                                          'ONBOARDING_FullName_ON_TEXTFIELD_CHANGE');
                                      logFirebaseEvent('FullName_backend_call');

                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        fullName:
                                            _model.fullNameTextController.text,
                                      ));
                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 24.0,
                                    ),
                                  )
                                : null,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          maxLines: 2,
                          keyboardType: TextInputType.name,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.fullNameTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    AuthUserStreamWidget(
                      builder: (context) => Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.usernameTextController,
                          focusNode: _model.usernameFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.usernameTextController',
                            Duration(milliseconds: 2000),
                            () async {
                              logFirebaseEvent(
                                  'ONBOARDING_Username_ON_TEXTFIELD_CHANGE');
                              logFirebaseEvent('Username_backend_call');

                              await currentUserReference!
                                  .update(createUsersRecordData(
                                username: _model.usernameTextController.text,
                              ));
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Username',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
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
                            suffixIcon: _model
                                    .usernameTextController!.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      _model.usernameTextController?.clear();
                                      logFirebaseEvent(
                                          'ONBOARDING_Username_ON_TEXTFIELD_CHANGE');
                                      logFirebaseEvent('Username_backend_call');

                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        username:
                                            _model.usernameTextController.text,
                                      ));
                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 24.0,
                                    ),
                                  )
                                : null,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          maxLines: 2,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.usernameTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'ONBOARDING_Set_Birthday_Button_ON_TAP');
                        logFirebaseEvent(
                            'Set_Birthday_Button_date_time_picker');
                        final _datePickedDate = await showDatePicker(
                          context: context,
                          initialDate: getCurrentTimestamp,
                          firstDate: DateTime(1900),
                          lastDate: getCurrentTimestamp,
                          builder: (context, child) {
                            return wrapInMaterialDatePickerTheme(
                              context,
                              child!,
                              headerBackgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              headerForegroundColor:
                                  FlutterFlowTheme.of(context).info,
                              headerTextStyle: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    fontSize: 32.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              pickerBackgroundColor:
                                  FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              pickerForegroundColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              selectedDateTimeBackgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              selectedDateTimeForegroundColor:
                                  FlutterFlowTheme.of(context).info,
                              actionButtonForegroundColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              iconSize: 24.0,
                            );
                          },
                        );

                        if (_datePickedDate != null) {
                          safeSetState(() {
                            _model.datePicked = DateTime(
                              _datePickedDate.year,
                              _datePickedDate.month,
                              _datePickedDate.day,
                            );
                          });
                        } else if (_model.datePicked != null) {
                          safeSetState(() {
                            _model.datePicked = getCurrentTimestamp;
                          });
                        }
                        logFirebaseEvent('Set_Birthday_Button_backend_call');

                        await currentUserReference!
                            .update(createUsersRecordData(
                          birthday: _model.datePicked,
                        ));
                      },
                      text: 'Set Birthday',
                      icon: Icon(
                        Icons.calendar_today,
                        size: 25.0,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 60.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondary,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Inter Tight',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 20.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    AuthUserStreamWidget(
                      builder: (context) => Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.weightTextController,
                          focusNode: _model.weightFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.weightTextController',
                            Duration(milliseconds: 2000),
                            () async {
                              logFirebaseEvent(
                                  'ONBOARDING_Weight_ON_TEXTFIELD_CHANGE');
                              logFirebaseEvent('Weight_backend_call');

                              await currentUserReference!
                                  .update(createUsersRecordData(
                                weight: double.tryParse(
                                    _model.weightTextController.text),
                              ));
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                            hintText: 'Weight(Ibs)',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFC9C9C9),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 26.0, 24.0, 26.0),
                            suffixIcon: _model
                                    .weightTextController!.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      _model.weightTextController?.clear();
                                      logFirebaseEvent(
                                          'ONBOARDING_Weight_ON_TEXTFIELD_CHANGE');
                                      logFirebaseEvent('Weight_backend_call');

                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        weight: double.tryParse(
                                            _model.weightTextController.text),
                                      ));
                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 24.0,
                                    ),
                                  )
                                : null,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.weightTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    AuthUserStreamWidget(
                      builder: (context) => Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.phoneNumberTextController,
                          focusNode: _model.phoneNumberFocusNode,
                          onChanged: (_) => EasyDebounce.debounce(
                            '_model.phoneNumberTextController',
                            Duration(milliseconds: 2000),
                            () async {
                              logFirebaseEvent(
                                  'ONBOARDING_PhoneNumber_ON_TEXTFIELD_CHAN');
                              logFirebaseEvent('PhoneNumber_backend_call');

                              await currentUserReference!
                                  .update(createUsersRecordData(
                                phoneNumber:
                                    _model.phoneNumberTextController.text,
                              ));
                            },
                          ),
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                            hintText: 'Phone Number',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFC9C9C9),
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 26.0, 24.0, 26.0),
                            suffixIcon: _model
                                    .phoneNumberTextController!.text.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      _model.phoneNumberTextController?.clear();
                                      logFirebaseEvent(
                                          'ONBOARDING_PhoneNumber_ON_TEXTFIELD_CHAN');
                                      logFirebaseEvent(
                                          'PhoneNumber_backend_call');

                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        phoneNumber: _model
                                            .phoneNumberTextController.text,
                                      ));
                                      safeSetState(() {});
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 24.0,
                                    ),
                                  )
                                : null,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                          keyboardType: TextInputType.number,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.phoneNumberTextControllerValidator
                              .asValidator(context),
                          inputFormatters: [_model.phoneNumberMask],
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 12.0)),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      logFirebaseEvent(
                          'ONBOARDING_CompleteProfile_button_ON_TAP');
                      logFirebaseEvent('CompleteProfile_button_navigate_to');

                      context.pushNamed(HomePageWidget.routeName);
                    },
                    text: 'Complete Profile',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 69.9,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).tertiary,
                      textStyle:
                          FlutterFlowTheme.of(context).labelLarge.override(
                                fontFamily: 'Inter',
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

// Import statements remain the same
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';
class BookPageWidget extends StatefulWidget {
  final Book book; // Add a property for the Book

  const BookPageWidget({Key? key, required this.book}) : super(key: key);

  @override
  _BookPageWidgetState createState() => _BookPageWidgetState();
}

class _BookPageWidgetState extends State<BookPageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0x26503EF0),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
          automaticallyImplyLeading: false,
          title: GradientText(
            'BetterReads',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            colors: [Color(0xFF0421F5), Color(0xFFF90206)],
            gradientDirection: GradientDirection.ltr,
            gradientType: GradientType.linear,
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.00, -0.83),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.book.imageLink,
                    width: 150,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.01, -0.97),
                child: GradientText(
                  widget.book.title,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Color(0xFF041587),
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                  colors: [
                    FlutterFlowTheme.of(context).primary,
                    FlutterFlowTheme.of(context).secondary
                  ],
                  gradientDirection: GradientDirection.ltr,
                  gradientType: GradientType.linear,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.68, 0.00),
                child: FlutterFlowRadioButton(
                  options: [widget.book.author],
                  onChanged: (val) => setState(() {}),
                  controller: _model.radioButtonValueController1 ??=
                      FormFieldController<String>(null),
                  optionHeight: 32,
                  textStyle: FlutterFlowTheme.of(context).labelMedium,
                  selectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).warning,
                  ),
                  buttonPosition: RadioButtonPosition.left,
                  direction: Axis.vertical,
                  radioButtonColor: FlutterFlowTheme.of(context).primary,
                  inactiveRadioButtonColor: FlutterFlowTheme.of(context).secondaryText,
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.start,
                  verticalAlignment: WrapCrossAlignment.start,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-2.35, 1.49),
                child: Text(
                  widget.book.description, // Use book properties here
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.66, 0.09),
                child: FlutterFlowRadioButton(
                  options: [widget.book.publisher], // Use book properties here
                  onChanged: (val) => setState(() {}),
                  controller: _model.radioButtonValueController2 ??=
                      FormFieldController<String>(null),
                  optionHeight: 32,
                  textStyle: FlutterFlowTheme.of(context).labelMedium,
                  selectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).warning,
                  ),
                  buttonPosition: RadioButtonPosition.left,
                  direction: Axis.vertical,
                  radioButtonColor: FlutterFlowTheme.of(context).primary,
                  inactiveRadioButtonColor: FlutterFlowTheme.of(context).secondaryText,
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.start,
                  verticalAlignment: WrapCrossAlignment.start,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.60, 0.20),
                child: FlutterFlowRadioButton(
                  options: [widget.book.publishedDate], // Use book properties here
                  onChanged: (val) => setState(() {}),
                  controller: _model.radioButtonValueController3 ??=
                      FormFieldController<String>(null),
                  optionHeight: 32,
                  textStyle: FlutterFlowTheme.of(context).labelMedium,
                  selectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).warning,
                  ),
                  buttonPosition: RadioButtonPosition.left,
                  direction: Axis.vertical,
                  radioButtonColor: FlutterFlowTheme.of(context).primary,
                  inactiveRadioButtonColor: FlutterFlowTheme.of(context).secondaryText,
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.start,
                  verticalAlignment: WrapCrossAlignment.start,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.67, 0.32),
                child: FlutterFlowRadioButton(
                  options: [widget.book.genre], // Use book properties here
                  onChanged: (val) => setState(() {}),
                  controller: _model.radioButtonValueController4 ??=
                      FormFieldController<String>(null),
                  optionHeight: 32,
                  textStyle: FlutterFlowTheme.of(context).labelMedium,
                  selectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).warning,
                  ),
                  buttonPosition: RadioButtonPosition.left,
                  direction: Axis.vertical,
                  radioButtonColor: FlutterFlowTheme.of(context).primary,
                  inactiveRadioButtonColor: FlutterFlowTheme.of(context).secondaryText,
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.start,
                  verticalAlignment: WrapCrossAlignment.start,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.55, 0.42),
                child: FlutterFlowRadioButton(
                  options: [widget.book.description],
                  onChanged: (val) => setState(() {}),
                  controller: _model.radioButtonValueController5 ??=
                      FormFieldController<String>(null),
                  optionHeight: 32,
                  textStyle: FlutterFlowTheme.of(context).labelMedium,
                  selectedTextStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).warning,
                  ),
                  buttonPosition: RadioButtonPosition.left,
                  direction: Axis.vertical,
                  radioButtonColor: FlutterFlowTheme.of(context).primary,
                  inactiveRadioButtonColor: FlutterFlowTheme.of(context).secondaryText,
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.start,
                  verticalAlignment: WrapCrossAlignment.start,
                ),
              ),
              // ... (rest of the code)
            ],
          ),
        ),
      ),
    );
  }
}

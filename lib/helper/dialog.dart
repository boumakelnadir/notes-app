import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<AwesomeDialog?> dialogAwesome({
  required BuildContext context,
  required String description,
  required DialogType dialogType,
  required String title,
  Function()? btnOkOnPress,
  Function()? btnCancelOnPress,
  String? btnCancelText,
  String? btnOkText,
  Color? btnCancelColor,
  Color? btnOkColor,
}) async {
  return await AwesomeDialog(
          context: context,
          dialogType: dialogType,
          animType: AnimType.topSlide,
          title: title.toUpperCase(),
          desc: description,
          descTextStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          btnCancelText: btnCancelText,
          btnCancelOnPress: btnCancelOnPress,
          btnCancelColor: btnCancelColor,
          btnOkOnPress: btnOkOnPress,
          btnOkText: btnOkText,
          btnOkColor: btnOkColor
          // btnOkColor: Colors.green,
          )
      .show();
}

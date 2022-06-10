// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

showAlertDialogNotMatchPassword(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: const Text("Düzelt"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Şifreniz uyuşmadı "),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

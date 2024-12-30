import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar() //hide current snackbar to show new snackbar
    ..showSnackBar(SnackBar(content: Text(content)));
}

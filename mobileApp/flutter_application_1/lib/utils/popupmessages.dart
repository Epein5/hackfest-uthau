import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar_route.dart';

class PopUpMessages {
  static toastMeaasge(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG,);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          duration: const Duration(seconds: 5),
          reverseAnimationCurve: Curves.decelerate,
          borderRadius: BorderRadius.circular(10),
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          message: message,
          backgroundColor: Colors.red,
        )..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static changeFocusNode(
      BuildContext context, FocusNode current, FocusNode whereToGo) {
    current.unfocus();
    FocusScope.of(context).requestFocus(whereToGo);
  }
}
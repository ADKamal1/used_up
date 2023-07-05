import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mangers/colors.dart';
import 'mangers/constants.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showSnackBar(BuildContext context, String errorMsg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(errorMsg),
    backgroundColor: Colors.black,
    duration: Duration(seconds: 5),
  ));
}

void showCustomProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorsManger.darkPrimary),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

String formatDate({DateTime? date}) {
  if (date == null) {
    return DateFormat.yMMMEd().format(DateTime.now());
  } else {
    return DateFormat.yMMMEd().format(date);
  }
}

String formatTime({DateTime? time}) {
  if (time == null) {
    return DateFormat.Hms().format(DateTime.now());
  } else {
    return DateFormat.Hms().format(time);
  }
}
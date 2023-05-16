import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../consts/color_consts.dart';

Widget sizeVer(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: blueColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

String? validateName(String? formData) {
  if (formData == null || formData.isEmpty) {
    return 'This field cannot be empty!';
  }
  if (formData.length > 12) {
    return 'Maximum length is 12 characters';
  }
  return null;
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'Email address cannot be empty!';
  }

  String pattern = r'\w+@\w+\.';
  RegExp regEx = RegExp(pattern);
  if (!regEx.hasMatch(formEmail)) return 'Invalid Email Address Format.';
  return null;
}

String? validatePass(String? formPass) {
  if (formPass == null || formPass.isEmpty) {
    return 'Password cannot be empty!';
  }

  if (formPass.length < 6) {
    return 'Password must be atleast 6 characters!';
  }

  return null;
}

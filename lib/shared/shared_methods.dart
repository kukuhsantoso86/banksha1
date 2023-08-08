import 'package:another_flushbar/flushbar.dart';
import 'package:bank_sha1/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String formatCurrency(
  num number, {
  String symbol = 'Rp ',
}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}

Future<XFile?> selectImage() async {
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  return selectedImage;
}

String dateToMonthDate(DateTime date) {
  return DateFormat('MMMM dd').format(date);
}

String formatTransactionCurrency(num number) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  ).format(number);
}

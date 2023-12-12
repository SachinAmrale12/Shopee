import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final VoidCallback onPostivePressed;
  final VoidCallback onNegativePressed;
  final double circularBorderRadius;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onPostivePressed,
    required this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          : null,
      content: message != null
          ? Text(
              message,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            )
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: [
        TextButton(
          onPressed: onNegativePressed,
          child: Text(
            negativeBtnText,
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: onPostivePressed,
          child: Text(
            positiveBtnText,
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}

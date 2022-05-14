import 'package:flutter/material.dart';
import 'package:senia_app/configs/app_theme.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;

  const CustomButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppTheme.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(primary: color),
      ),
    );
  }
}

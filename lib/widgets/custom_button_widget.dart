import 'package:flutter/material.dart';
import 'package:senia_app/configs/app_theme.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color;
  final IconData? icon;

  const CustomButtonWidget(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color = AppTheme.accentColor,
      this.icon = Icons.touch_app})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(width: 5),
            Text(text),
          ],
        ),
        style: ElevatedButton.styleFrom(primary: color),
      ),
    );
  }
}

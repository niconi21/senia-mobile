import 'package:flutter/material.dart';

class CustomTextFliedWidget extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool enabled;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  const CustomTextFliedWidget({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.onChanged,
    required this.enabled,
    required this.validator,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(icon: Icon(icon), labelText: labelText),
      onChanged: onChanged,
      enabled: enabled,
      validator: validator,
      
    );
  }
}

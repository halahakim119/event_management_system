import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? prefixText;
  final int? max;

  const CustomTextField(
      {super.key,
      required this.labelText,
       this.onChanged,
      required this.validator,
      this.keyboardType,
      this.onSaved,
      this.obscureText = false,
      this.suffixIcon,
      this.controller,
      this.prefixText,
      this.max});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.0),
      borderSide: const BorderSide(
        width: 1.0,
      ),
    );

    return TextFormField(
      maxLength: max,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        prefixText: prefixText,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(
        fontSize: 14,
      ),
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      onSaved: onSaved,
    );
  }
}

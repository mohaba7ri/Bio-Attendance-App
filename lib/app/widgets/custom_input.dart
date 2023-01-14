import 'package:flutter/material.dart';
import 'package:presence/app/style/app_color.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;
  final TextInputType? type;
  String? Function(String? value)? valdate;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;
  CustomInput({
    this.valdate,
    required this.controller,
    this.type,
    required this.label,
    required this.hint,
    this.disabled = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.obsecureText = false,
    this.suffixIcon,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: widget.valdate,
        keyboardType: widget.type,
        readOnly: widget.disabled,
        obscureText: widget.obsecureText,
        style: TextStyle(fontSize: 14, fontFamily: 'poppins'),
        maxLines: 1,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon ?? SizedBox(),
          label: Text(
            widget.label,
            style: TextStyle(
              color: AppColor.secondarySoft,
              fontSize: 14,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            color: AppColor.secondarySoft,
          ),
        ),
      ),
    );
  }
}

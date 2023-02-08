import 'package:flutter/material.dart';
import 'package:presence/app/style/app_color.dart';
import 'package:presence/app/util/styles.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;

  String? Function(String? value)? valdate;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;
  TextInputType? keyboardType;
  CustomInput(
      {this.valdate,
      required this.controller,
      required this.label,
      required this.hint,
      this.disabled = false,
      this.margin = const EdgeInsets.only(bottom: 16),
      this.obsecureText = false,
      this.suffixIcon,
      this.keyboardType});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 55,
        child: TextFormField(
            validator: widget.valdate,
            keyboardType: widget.keyboardType,
            readOnly: widget.disabled,
            obscureText: widget.obsecureText,
            style: robotoMedium,
            maxLines: 1,
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon ?? SizedBox(),
              label: Text(widget.label,
                  style: robotoMedium.copyWith(color: AppColor.blackColor)),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              hintText: widget.hint,
              hintStyle: robotoMedium.copyWith(color: AppColor.secondarySoft),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isHiddenPassword;

  const CommonTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isHiddenPassword,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      autocorrect: false,
      decoration: InputDecoration(
        fillColor: const Color(0xffF2F2F2),
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
    );
  }
}

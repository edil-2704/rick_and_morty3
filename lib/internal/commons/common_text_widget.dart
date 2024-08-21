import 'package:flutter/material.dart';

class CommonTextWidget extends StatelessWidget {
  final String tittle;

  const CommonTextWidget({
    super.key,
    required this.tittle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      tittle,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
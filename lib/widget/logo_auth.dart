import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({super.key, required this.logo, this.onTap});
  final String logo;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          logo,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

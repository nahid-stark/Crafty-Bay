import 'package:flutter/material.dart';

class AppBarActions extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const AppBarActions({super.key, required this.onTap, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        radius: 18,
        child: Image.asset(
          iconPath,
          height: 24,
        ),
      ),
    );
  }
}

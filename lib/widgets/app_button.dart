import 'package:btl_kiemtra_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String text;
  final VoidCallback? onTap;

  const AppButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(appRadius)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              colorRed,
              colorRedLight,
            ],
          )
        ),
      ),
      onTap: onTap,
    );
  }
}
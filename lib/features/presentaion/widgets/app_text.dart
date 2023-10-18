import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    required this.size,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.align,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.exo2(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
      textAlign: align,
    );
  }
}

import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyText(
    this.data, {
    super.key,
    this.color = Colors.black,
    this.size = 16,
    this.spacing = 0,
    this.overflow = TextOverflow.visible,
    this.weight = FontWeight.normal,
    this.wordSpacing = 0,
  });

  final String data;
  final double size, spacing, wordSpacing;
  final FontWeight weight;
  final TextOverflow overflow;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: spacing,
        wordSpacing: wordSpacing,
        overflow: overflow,
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.maxLength,
    this.color = Colors.grey,
  });
  final TextEditingController controller;
  final int maxLines;
  final int? maxLength;
  final String label, hint;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        label: MyText(
          ' $label ',
          color: color,
          weight: FontWeight.w500,
          spacing: 1,
        ),
        hintText: hint,
        hintStyle: TextStyle(letterSpacing: 1, color: color),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.5,
            color: color,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.5,
            color: color,
          ),
        ),
      ),
    );
  }
}

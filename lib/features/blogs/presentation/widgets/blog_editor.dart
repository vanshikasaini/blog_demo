import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;

  const BlogEditor({
    super.key,
    required this.controller,
    required this.hinttext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
      ),
      maxLines:
          null, // whenever line enter at the end cursor will automatically come into next line
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hinttext is missing';
        }
        return null;
      },
    );
  }
}

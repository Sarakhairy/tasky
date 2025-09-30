import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;
   const CustomTextFormField({super.key,required this.title, required this.controller, this.validator,required this.hintText, this.maxLines});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[500]!),
            ),

          ),
          maxLines: widget.maxLines,
        ),
      ],
    );
  }
}

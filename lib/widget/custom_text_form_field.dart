import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.iconData,
    this.onChanged,
    this.keyboardType,
    this.mycontroller,
  });
  final String? hintText;
  final IconData? iconData;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? mycontroller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        enableInteractiveSelection: true,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        controller: widget.mycontroller,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Please ${widget.hintText}, the field required ';
          } else {
            return null;
          }
        },
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
            fillColor: Colors.pink[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 17,
            ),
            hintStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            hintText: widget.hintText,
            suffixIcon: Icon(widget.iconData)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.saveProfile,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  final void Function(String value) saveProfile;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(66, 159, 159, 159).withOpacity(.2),
        hintText: hintText,
        prefixIcon:
            Icon(size: 20, icon, color: const Color.fromARGB(255, 7, 199, 78)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 7, 199, 78),
        ),
      ),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim().length <= 1 ||
            value.trim().length > 50) {
          return 'Must be between 1 and 50 characters.';
        }
        return null;
      },
      onSaved: (value) {
        saveProfile(value!);
      },
    );
  }
}

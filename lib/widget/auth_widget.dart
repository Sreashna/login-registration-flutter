import 'package:flutter/material.dart';

Widget authField({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  bool obscure = false,
  Widget? suffix,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1F2937),
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: (v) {
          if (v == null || v.isEmpty) return "$label is required";
          if (label == "Email" && !v.contains("@")) {
            return "Enter a valid email";
          }
          if (label == "Password" && v.length < 6) {
            return "Minimum 6 characters";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(icon),
          suffixIcon: suffix,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}

Widget socialButton(IconData icon, String text) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: OutlinedButton.icon(
      icon: Icon(icon, color: Colors.black),
      label: Text(text),
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

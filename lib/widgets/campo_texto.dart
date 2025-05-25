import 'package:flutter/material.dart';
//para trabajar con la entrada de datos 

Widget campoTexto(String label, TextEditingController controller, IconData icono) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono, color: Color(0xFF000099)),
        labelStyle: TextStyle(color: Color(0xFF000099)),
        border: OutlineInputBorder(),
      ),
    ),
  );
}
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        prefixIcon: const Icon(
          Icons.calendar_month,
          color: Color.fromRGBO(159, 159, 159, 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0),
        ),
        hintStyle: const TextStyle(
          color: Color.fromRGBO(159, 159, 159, 1.0),
        ),
        hintText: 'Selecione uma data',
      ),
    );
  }
}

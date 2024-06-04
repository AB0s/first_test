import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Size size;

  const NotesField({
    required this.controller,
    required this.onChanged,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Заметки',
            style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.01),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Введите заметку',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.015),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

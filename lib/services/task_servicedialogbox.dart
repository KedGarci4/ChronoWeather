import 'package:chronoweather/services/task_buttons.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback saved;
  VoidCallback cancel;
  DialogBox({super.key, required this.controller, required this.saved, required this.cancel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[850],
      content: Container(
        height: 200,
        child: Column(
          children: [
            SizedBox(height: 30),
            TextField(
              
              controller:controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.yellow,
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow),),
                hintText: "Agrega una nueva tarea",
              ),

            ),
            Row(
              children: [
                cButtons(text: "Guardar", onPressed: saved),
                SizedBox(width: 100, height: 100),
                cButtons(text: "Cancelar", onPressed:cancel),
            ],
            )
          ],
          
        ),
      )
    );
  }
}
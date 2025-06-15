import 'package:demo2/todoApp/buttons.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final addTaskController;
  VoidCallback onSaved;
  VoidCallback onCancel;
  DialogBox({super.key, required this.addTaskController, required this.onSaved, required this.onCancel,});


  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Colors.yellow[300],
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 150,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Padding(padding: EdgeInsetsGeometry.only(top: 12)),
            Text("NEW TASK",style: TextStyle(fontWeight: FontWeight.bold),),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),hintText: "Key in your task here...",filled: true,fillColor: Colors.yellow[100]),
              controller: addTaskController,
            ),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(btName: "SAVE", onPressed: onSaved),

                const SizedBox(width: 10,),   

                //cancel button
                MyButton(btName: "CANCEL", onPressed: onCancel)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
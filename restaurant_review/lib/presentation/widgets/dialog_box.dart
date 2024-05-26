import 'package:flutter/material.dart';
import 'package:restaurant_review/presentation/widgets/my_button.dart';
// import 'package:todo_app/components/my_button.dart';
class DialogBox extends StatelessWidget {
  // final controller;
  // VoidCallback onSave;
  VoidCallback onCancel;


  DialogBox({super.key , required this.onCancel});
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(235, 125, 56,1),
      content: 
          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                 
                  decoration: InputDecoration(
                    hintText: "Write a review",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)
                    ),
                    
                  ),
                ),
              
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyDialogButton(text: "Save", onPressed: () {}),
              SizedBox(width: 8,),
              MyDialogButton(text: "Cancel", onPressed: onCancel),
            ],
          )]
        
    )
    )
    );
  }
}
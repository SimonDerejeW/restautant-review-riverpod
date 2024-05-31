import 'package:flutter/material.dart';
import 'package:restaurant_review/presentation/widgets/my_button.dart';

class DialogBox extends StatefulWidget {
  final VoidCallback onCancel;
  final void Function(String newOpinion) onSubmit;
  final String initialOpinion;

  const DialogBox({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    required this.initialOpinion,
  });

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late TextEditingController _opinionController;

  @override
  void initState() {
    super.initState();
    _opinionController = TextEditingController(text: widget.initialOpinion);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(235, 125, 56, 1),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _opinionController,
              decoration: const InputDecoration(
                hintText: "Write a review",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyDialogButton(
                  text: "Save",
                  onPressed: () {
                    widget.onSubmit(_opinionController.text);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                const SizedBox(width: 8),
                MyDialogButton(
                  text: "Cancel",
                  onPressed: () {
                    widget.onCancel();Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _opinionController.dispose();
    print("disposed");
    super.dispose();
  }
}

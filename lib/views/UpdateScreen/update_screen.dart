import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Object> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    String title = arguments['title'] as String;
    String description = arguments['description'] as String;

    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController descriptionController =
        TextEditingController(text: description);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Título",
              ),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Descrição",
              ),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            Row(
              children: [
                const Spacer(flex: 1),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'title': titleController.text,
                      'description': descriptionController.text
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                  ),
                  child:
                      const Text("Ok", style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

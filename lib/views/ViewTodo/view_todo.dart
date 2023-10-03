import 'package:flutter/material.dart';

class ViewTodo extends StatelessWidget {
  const ViewTodo({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String?>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;

    String title = '';
    String description = '';

    if (arguments != null) {
      title = arguments['title'] ?? '';
      description = arguments['description'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Title:"),
                Text(title, style: const TextStyle(fontSize: 32)),
              ],
            ),
            const Divider(),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Description:"),
                Text(description, style: const TextStyle(fontSize: 32)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

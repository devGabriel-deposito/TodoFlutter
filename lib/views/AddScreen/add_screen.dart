import 'package:flutter/material.dart';
import 'package:todo/widgets/custom_app_bar.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String selectedDate = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _AddPageState() {
    selectedDate = getAndFormatDateTime(DateTime.now());
  }

  void selectData() async {
    DateTime? result = await showDatePicker(
        context: context,
        cancelText: "Fechar",
        confirmText: "Selecionar",
        helpText: "Selecione a data",
        initialDate: DateTime.now(),
        firstDate: DateTime(1964),
        lastDate: DateTime(2100));

    if (result != null) {
      setState(() {
        selectedDate = getAndFormatDateTime(result);
      });
    }
  }

  String getAndFormatDateTime(DateTime date) {
    String data = date.toLocal().toString().split(' ')[0];

    List<String> splittedData = data.split('-');

    String dia = splittedData[2];
    String mes = splittedData[1];
    String ano = splittedData[0];

    data = '${dia}/${mes}/${ano}';

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  selectedDate.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
                const Spacer(flex: 1),
                ElevatedButton(
                  onPressed: () => selectData(),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blue)),
                  child: const Row(
                    children: [
                      Text("Selecionar", style: TextStyle(color: Colors.white)),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Icon(
                        Icons.date_range_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
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
                      'description': descriptionController.text,
                      'date': selectedDate
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => Colors.blue),
                  ),
                  child: const Text(
                    "Criar",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

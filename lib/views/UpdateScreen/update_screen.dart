import 'package:flutter/material.dart';
import 'package:todo/widgets/custom_app_bar.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String selectedDate = "";

  void selectData() async {
    List<String> splittedDate = selectedDate.split('/');

    int ano = int.parse(splittedDate[2]);
    int mes = int.parse(splittedDate[1]);
    int dia = int.parse(splittedDate[0]);

    DateTime? result = await showDatePicker(
      context: context,
      cancelText: "Fechar",
      confirmText: "Selecionar",
      helpText: "Selecione a data",
      initialDate: DateTime(ano, mes, dia),
      firstDate: DateTime(1964),
      lastDate: DateTime(2100),
    );

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
    Map<String, Object> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    if (selectedDate == '') {
      setState(() {
        selectedDate = arguments['date'] as String;
      });
    }

    String title = arguments['title'] as String;
    String description = arguments['description'] as String;

    TextEditingController titleController = TextEditingController(text: title);
    TextEditingController descriptionController =
        TextEditingController(text: description);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Flexible(
          child: Scrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(selectedDate.toString(),
                        style: const TextStyle(fontSize: 24)),
                    const Spacer(flex: 1),
                    ElevatedButton(
                      onPressed: () => selectData(),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue)),
                      child: const Row(
                        children: [
                          Text("Selecionar",
                              style: TextStyle(color: Colors.white)),
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
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.blue),
                      ),
                      child: const Text("Ok",
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

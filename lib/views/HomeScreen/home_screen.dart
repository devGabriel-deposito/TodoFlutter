import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> todoList = [];

  void setTheNewTodo(String title, String description, String date) {
    setState(() {
      todoList.add({
        'title': title,
        'description': description,
        'date': date
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Todo criado!'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        ),
      );
    });
  }

  void redirectToView(int index) {
    Navigator.pushNamed(context, '/view', arguments: {
      'title': todoList[index]['title'] ?? '',
      'description': todoList[index]['description'] ?? '',
      'date': todoList[index]['date'] ?? '',
    });
  }

  void redirectToUpdate(int index) async {
    Map<String, Object?>? result = await Navigator.pushNamed(context, '/update', arguments: {
      'title': todoList[index]['title'] ?? '',
      'description': todoList[index]['description'] ?? '',
      'date': todoList[index]['date'] ?? '',
    }) as Map<String, Object?>?;

    String title = result?['title'].toString() ?? '';
    String description = result?['description'].toString() ?? '';
    String date = result?['date'].toString() ?? '';

    if (title != '' || description != '' || date != '') {
      setState(() {
        todoList[index]['title'] = title;
        todoList[index]['description'] = description;
        todoList[index]['date'] = date;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Todo atualizado!'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {},
            ),
          ),
        );
      });
    }
  }

  void confirmDelete(index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Tem certeza que deseja excluir?'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Não', style: TextStyle(color: Colors.black)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          todoList.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Todo excluído!'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {},
                            ),
                          ),
                        );

                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red,
                        ),
                      ),
                      child: const Text('Sim', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget todoItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        SizedBox(
          width: getWidthPercent(),
          child: Text(
            todoList[index]['title'].toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(flex: 1),
        PopupMenuButton(
          onSelected: (String value) {
            switch (value) {
              case "view":
                redirectToView(index);
              case "edit":
                redirectToUpdate(index);
              case "delete":
                confirmDelete(index);
              default:
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: "view",
              child: Icon(
                Icons.remove_red_eye_rounded,
                color: Colors.blue,
              ),
            ),
            const PopupMenuItem(
              value: "edit",
              child: Icon(
                Icons.edit_document,
                color: Colors.green,
              ),
            ),
            const PopupMenuItem(
              value: "delete",
              child: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ),
          ],
        )
      ],
    );
  }

  double getWidthPercent() {
    return MediaQuery.of(context).size.width * (80 / 100);
  }

  @override
  Widget build(BuildContext context) {
    if (todoList.isEmpty) {
      for (int i = 0; i < 15; i++) {
        todoList.add({
          'title': '$i - Título do todo - $i',
          'description': 'Descrição\n\ndo\n\ntodo - $i',
          'date': '${i < 10 ? '0$i' : i}/10/2023'
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Todo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () async {
              var response = await Navigator.pushNamed(context, '/add');

              Map<String, String>? todo = response as Map<String, String>?;

              String title = todo?['title'] ?? '';
              String description = todo?['description'] ?? '';
              String date = todo?['date'] ?? '';

              if (title != '') setTheNewTodo(title, description, date);
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Flexible(
              child: Scrollbar(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return todoItem(index);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

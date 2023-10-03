import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> todoList = [
    {
      'title': 'titletitletitletitletitletitletitletitle',
      'description':
          'description\n\n\n\ndescription\n\n\n\ndescription\n\n\n\ndescription\n\n\n\ndescription\n\n\n\ndescription\n\n\n\n',
      'date': '03/10/2023'
    }
  ];

  void setTheNewTodo(String title, String description, String date) {
    setState(() => todoList
        .add({'title': title, 'description': description, 'date': date}));
  }

  void redirectToView(int index) {
    Navigator.pushNamed(context, '/view', arguments: {
      'title': todoList[index]['title'] ?? '',
      'description': todoList[index]['description'] ?? '',
      'date': todoList[index]['date'] ?? '',
    });
  }

  void redirectToUpdate(int index) async {
    Map<String, Object?>? result =
        await Navigator.pushNamed(context, '/update', arguments: {
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
                const Text('Do you really want to delete?'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('No',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10)),
                    ElevatedButton(
                      onPressed: () => {
                        setState(() {
                          todoList.removeAt(index);
                        }),
                        Navigator.pop(context)
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red,
                        ),
                      ),
                      child: const Text('Yes',
                          style: TextStyle(color: Colors.white)),
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
        IconButton(
          onPressed: () => redirectToView(index),
          icon: const Icon(
            Icons.remove_red_eye_rounded,
            color: Colors.blue,
          ),
        ),
        IconButton(
          onPressed: () => redirectToUpdate(index),
          icon: const Icon(
            Icons.edit_document,
            color: Colors.green,
          ),
        ),
        IconButton(
          onPressed: () => confirmDelete(index),
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  double getWidthPercent() {
    return MediaQuery.of(context).size.width * (60 / 100);
  }

  @override
  Widget build(BuildContext context) {
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
              String date = todo?['selectedDate'] ?? '';

              if (title != '') setTheNewTodo(title, description, date);
            },
            icon: const Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Scrollbar(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Flexible(
                    fit: FlexFit.loose,
                    child: todoItem(index),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

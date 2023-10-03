import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/views/AddScreen/add_screen.dart';
import 'package:todo/views/HomeScreen/home_screen.dart';
import 'package:todo/views/UpdateScreen/update_screen.dart';
import 'package:todo/views/ViewTodo/view_todo.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => const AddPage(),
        '/view': (context) => const ViewTodo(),
        '/update': (context) => const UpdateScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: "Todo",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('pt')],
    );
  }
}

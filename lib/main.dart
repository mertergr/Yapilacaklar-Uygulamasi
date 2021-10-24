import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/add_todo.dart';
import 'package:todoapp/todo_completed.dart';
import 'package:todoapp/todo_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('tr')
      ],

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var pagesList = [Complated(), ToDoMain(), addToDo()];

  int selectedIndex = 1;


  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagesList[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline),
            label: "Tamamlananlar",
            activeIcon: Icon(Icons.done),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Anasayfa",
              activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "Yapılacak Ekle",
              activeIcon: Icon(Icons.add_circle)
          ),
        ],
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (indeks){
          setState(() {
            selectedIndex = indeks;
          });
        },
      ),

    );
  }
}

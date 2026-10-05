import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/note.dart';
import 'screens/home_screen.dart';


void main() async {


WidgetsFlutterBinding.ensureInitialized();


await Hive.initFlutter();


Hive.registerAdapter(NoteAdapter());


await Hive.openBox<Note>("notes");


runApp(MyApp());

}



class MyApp extends StatelessWidget {


@override
Widget build(BuildContext context){

return MaterialApp(

debugShowCheckedModeBanner:false,

theme:ThemeData(
primarySwatch:Colors.blue,
),

home:HomeScreen(),

);

}

}
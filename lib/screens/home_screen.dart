import 'package:flutter/material.dart';

import '../services/database_service.dart';
import '../widgets/note_card.dart';
import 'add_note_screen.dart';
import 'edit_note_screen.dart';


class HomeScreen extends StatefulWidget{


@override
State<HomeScreen> createState()=>_HomeScreenState();

}



class _HomeScreenState extends State<HomeScreen>{



void refresh(){

setState((){});

}



@override
Widget build(BuildContext context){


final notes = DatabaseService.getNotes();



return Scaffold(

appBar:AppBar(
title:Text("My Notes"),
),


body:notes.isEmpty ?

Center(
child:Text("No Notes Yet"),
)

:

ListView.builder(

itemCount:notes.length,


itemBuilder:(context,index){

return NoteCard(

note:notes[index],


onDelete:(){

DatabaseService.deleteNote(index);

refresh();

},


onEdit:(){

Navigator.push(

context,

MaterialPageRoute(

builder:(context)=>

EditNoteScreen(
index:index,
note:notes[index],
)

)

).then((value)=>refresh());

}

);

}

),



floatingActionButton:FloatingActionButton(

child:Icon(Icons.add),


onPressed:(){

Navigator.push(

context,

MaterialPageRoute(

builder:(context)=>AddNoteScreen()

)

).then((value)=>refresh());


},

),


);


}

}
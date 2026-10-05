import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/database_service.dart';



class EditNoteScreen extends StatelessWidget{


final int index;

final Note note;


EditNoteScreen({

required this.index,

required this.note,

});



final titleController=TextEditingController();

final contentController=TextEditingController();



@override
Widget build(BuildContext context){


titleController.text=note.title;

contentController.text=note.content;



return Scaffold(

appBar:AppBar(
title:Text("Edit Note"),
),


body:Padding(

padding:EdgeInsets.all(20),


child:Column(

children:[


TextField(

controller:titleController,

),


TextField(

controller:contentController,

maxLines:5,

),



ElevatedButton(

child:Text("Update"),


onPressed:(){


DatabaseService.updateNote(

index,

Note(

title:titleController.text,

content:contentController.text,

date:DateTime.now(),

)

);


Navigator.pop(context);


},

)



],

),


),


);


}

}
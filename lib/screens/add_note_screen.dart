import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/database_service.dart';


class AddNoteScreen extends StatelessWidget{


final titleController=TextEditingController();

final contentController=TextEditingController();



@override
Widget build(BuildContext context){


return Scaffold(

appBar:AppBar(
title:Text("Add Note"),
),


body:Padding(

padding:EdgeInsets.all(20),


child:Column(

children:[


TextField(

controller:titleController,

decoration:InputDecoration(
labelText:"Title"
),

),


TextField(

controller:contentController,

decoration:InputDecoration(
labelText:"Content"
),

maxLines:5,

),


SizedBox(height:20),



ElevatedButton(

child:Text("Save"),


onPressed:(){


final note=Note(

title:titleController.text,

content:contentController.text,

date:DateTime.now(),

);



DatabaseService.addNote(note);


Navigator.pop(context);


},

)



],

),


),


);


}

}
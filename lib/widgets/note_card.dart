import 'package:flutter/material.dart';

import '../models/note.dart';



class NoteCard extends StatelessWidget{


final Note note;

final VoidCallback onDelete;

final VoidCallback onEdit;



NoteCard({

required this.note,

required this.onDelete,

required this.onEdit,

});



@override
Widget build(BuildContext context){


return Card(

margin:EdgeInsets.all(10),


child:ListTile(

title:Text(note.title),


subtitle:Text(note.content),


onTap:onEdit,


trailing:IconButton(

icon:Icon(Icons.delete),


onPressed:onDelete,


),

),


);


}

}
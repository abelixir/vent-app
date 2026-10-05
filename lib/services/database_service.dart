import 'package:hive/hive.dart';
import '../models/note.dart';


class DatabaseService {


static const String boxName="notes";


static Future<void> addNote(Note note) async {

final box = Hive.box<Note>(boxName);

await box.add(note);

}



static List<Note> getNotes(){

final box = Hive.box<Note>(boxName);

return box.values.toList();

}



static Future<void> deleteNote(int index) async {

final box = Hive.box<Note>(boxName);

await box.deleteAt(index);

}



static Future<void> updateNote(
int index,
Note note
) async {

final box = Hive.box<Note>(boxName);

await box.putAt(index,note);

}


}
import 'package:todoapp/todo.dart';
import 'package:todoapp/veritabani_yardimcisi.dart';

class ToDoDAO{

  Future<List<ToDo>> continuing() async{

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * from todo WHERE status = 0 ORDER BY todo_end_date ASC, todo_end_time ASC  ");

    return List.generate(maps.length, (i) {

      var satir = maps[i];

      return ToDo(
        satir["todo_id"],
        satir["todo_title"],
        satir["todo_detail"],
        satir["todo_end_date"],
        satir["todo_end_time"],
        satir["status"],
      );

    });
  }


  Future<List<ToDo>> done() async{

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * from todo WHERE status = 1 ORDER BY todo_end_date ASC, todo_end_time ASC ");

    return List.generate(maps.length, (i) {

      var satir = maps[i];

      return ToDo(
        satir["todo_id"],
        satir["todo_title"],
        satir["todo_detail"],
        satir["todo_end_date"],
        satir["todo_end_time"],
        satir["status"],
      );

    });
  }

  Future<void> changeStatus(int todo_id, String status) async{

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var values = Map<String, dynamic>();

    values["status"] = "1" ;

    await db.update("todo", values, where: "todo_id = ?", whereArgs: [todo_id]);

  }


  Future<void> addQuery(String todo_title, String todo_detail, String todo_end_date, String todo_end_time ) async{

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var values = Map<String, dynamic>();

    values["todo_title"] = todo_title;
    values["todo_detail"] = todo_detail;
    values["todo_end_date"] = todo_end_date;
    values["todo_end_time"] = todo_end_time;
    values["status"] = "0";

    await db.insert("todo", values);
  }

  Future<void> updateQuery(int todo_id, String todo_title, String todo_detail, String todo_end_date, String todo_end_time) async{

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var values = Map<String, dynamic>();

    values["todo_title"] = todo_title;
    values["todo_detail"] = todo_detail;
    values["todo_end_date"] = todo_end_date;
    values["todo_end_time"] = todo_end_time;
    values["status"] = "0";

    await db.update("todo", values, where: "todo_id = ?", whereArgs: [todo_id]);
  }

  Future<void> deleteQuery(int todo_id) async{
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("todo", where: "todo_id = ?", whereArgs: [todo_id]);
  }

  Future<void> deleteAllDone() async{

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("todo",where: "status = 1");

  }

  Future<void> deleteAll() async{

    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("todo",where: "status = 0");

  }



}
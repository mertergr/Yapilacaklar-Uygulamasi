import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/todo.dart';
import 'package:todoapp/todo_dao.dart';
import 'package:todoapp/todo_edit_screen.dart';

class ToDoMain extends StatefulWidget {
  const ToDoMain({Key? key}) : super(key: key);

  @override
  _ToDoMainState createState() => _ToDoMainState();
}

class _ToDoMainState extends State<ToDoMain> {

  Future<List<ToDo>> showAllToDo() async {
    var todoList = await ToDoDAO().continuing();
    setState(() {
    });
    return todoList;
  }

  Future<void> todoDelete(int todo_id) async{
    await ToDoDAO().deleteQuery(todo_id);
    setState(() {
    });
  }

  Future<void> todoDone(int todo_id, String status) async{

    await ToDoDAO().changeStatus(todo_id, status);
    setState(() {
    });

  }

  Future<void> deleteAll() async{

    await ToDoDAO().deleteAll();
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Yapılacaklar Listesi",
              style:  TextStyle(fontSize: ekranGenisligi/18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
            FutureBuilder<List<ToDo>>(
              future: showAllToDo(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  var todoList = snapshot.data;
                  return Text("Kalan Plan Sayısı: ${todoList!.length}",style: TextStyle(color: Colors.white, fontSize: ekranGenisligi/25),);
                }else{
                  return Text("Kalan Plan Sayısı : 0", style: TextStyle(color: Colors.white, fontSize: ekranGenisligi/25),);
                }
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          TextButton(onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Dikkat"),
                    content: Text("Bu işlem geri alınamaz. Silmek istediğinden emin misin?"),
                    actions: [
                      TextButton(onPressed: (){
                        deleteAll();
                        Navigator.pop(context);
                      },
                          child: Text("Sil")
                      ),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      },
                          child: Text("İptal")
                      ),
                    ],
                  );
                });
          },
              child: Text("Hepsini Sil", style: TextStyle(color: Colors.white,fontSize: ekranGenisligi/22),)
          ),
        ],
      ),
      body: FutureBuilder<List<ToDo>>(
        future: showAllToDo(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var todoList = snapshot.data;
            return ListView.builder(
              itemCount: todoList!.length,
              itemBuilder: (context, indeks){
                var doing = todoList[indeks];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.5,
                  // left side
                  actions: [
                    SizedBox(height: ekranYuksekligi/7,
                      child: IconSlideAction(
                        caption: "Sil",
                        color: Colors.red,
                        icon: Icons.delete_forever_outlined,
                        onTap: (){
                          todoDelete(doing.todo_id);
                        },
                      ),
                    ),
                    SizedBox(height: ekranYuksekligi/7,
                      child: IconSlideAction(
                        caption: "İptal",
                        color: Colors.blue,
                        icon: Icons.cancel_outlined,
                        onTap: (){},
                      ),
                    )
                  ],
                  secondaryActions: [
                    SizedBox(height: ekranYuksekligi/7,
                      child: IconSlideAction(
                        caption: "Tamamlandı",
                        color: Colors.green,
                        icon: Icons.done,
                        onTap: (){
                          todoDone(doing.todo_id, doing.status);
                        },
                      ),
                    ),
                    SizedBox(height: ekranYuksekligi/7,
                      child: IconSlideAction(
                        caption: "İptal",
                        color: Colors.blue,
                        icon: Icons.cancel_outlined,
                        onTap: (){},
                      ),
                    ),
                  ],
                  child: GestureDetector(
                    onTap: (){
                      if(doing.todo_detail != ""){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text(doing.todo_title),
                              content: Text(doing.todo_detail),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("Tamam")),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Card(
                      child: SizedBox(height: ekranYuksekligi/7,
                        child: Padding(
                          padding:  EdgeInsets.all(ekranGenisligi/30),
                          child: Row(
                            children: [
                              Text(doing.todo_title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: ekranGenisligi/25,color: Colors.teal),),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${doing.todo_end_date} - ${doing.todo_end_time}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: ekranGenisligi/30, color: Colors.teal),),
                                  SizedBox(height: 35,
                                    child: IconButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoEditScreen(doing: doing)));
                                    },
                                        icon: Icon(Icons.edit,color: Colors.teal,size: ekranGenisligi/15,)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },

            );
          }else{
            return Center();
          }
        },
      ),
    );
  }
}

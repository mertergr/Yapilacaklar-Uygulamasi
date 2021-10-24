import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/todo.dart';
import 'package:todoapp/todo_dao.dart';

class Complated extends StatefulWidget {
  const Complated({Key? key}) : super(key: key);

  @override
  _ComplatedState createState() => _ComplatedState();
}

class _ComplatedState extends State<Complated> {

  Future<List<ToDo>> showAllDone() async{
    var doneList = await ToDoDAO().done();
    setState(() {
    });
    return doneList;
  }

  Future<void> deleteAllDone() async{

    await ToDoDAO().deleteAllDone();
    setState(() {
    });
  }

  Future<void> todoDelete(int todo_id) async{
    await ToDoDAO().deleteQuery(todo_id);
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return  Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tamamlananlar", style: TextStyle(fontSize: ekranGenisligi/18,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            ),
            FutureBuilder<List<ToDo>>(
              future: showAllDone(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  var doneList = snapshot.data;
                  return Text("Tamamlanan Plan Sayısı: ${doneList!.length}",
                    style: TextStyle(fontSize: ekranGenisligi/25, color: Colors.white,),
                  );
                }else{
                  return Text("Tamamlanan Plan Sayısı : 0", style: TextStyle(fontSize: ekranGenisligi/25, color:Colors.white),);
                }
              },
            ),
          ],
        ),

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
                        deleteAllDone();
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
              child: Text("Hepsini Sil", style: TextStyle(color: Colors.white, fontSize: ekranGenisligi/22),)
          ),
        ],
      ),
      body: FutureBuilder<List<ToDo>>(
          future: showAllDone(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var doneList = snapshot.data;
              return ListView.builder(
                itemCount: doneList!.length,
                itemBuilder: (context, indeks){
                  var doing = doneList[indeks];
                  return SizedBox(height: ekranYuksekligi/7,
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.5,
                      actions: [
                        SizedBox(height: 100,
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
                            onTap: (){

                            },
                          ),
                        )
                      ],
                      child: GestureDetector(
                        onTap: (){
                          if(doing.todo_detail != ""){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text(doing.todo_title),
                                  content: ((doing.todo_detail).isEmpty ) ? Text("Maalesef içerik boş") :  Text(doing.todo_detail),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text("Tamam")
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Card(
                          child: SizedBox(height: ekranYuksekligi/7,
                            child: Padding(
                              padding: EdgeInsets.all(ekranGenisligi/30),
                              child: Row(
                                children: [
                                  Text(
                                    doing.todo_title,
                                    style: TextStyle(fontSize: ekranGenisligi/25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal
                                    ),
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text("${doing.todo_end_date} - ${doing.todo_end_time}",
                                        style: TextStyle(fontSize: ekranGenisligi/30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal
                                        ),
                                      ),
                                      Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return Center();
            }
          }
      ),
    );
  }
}

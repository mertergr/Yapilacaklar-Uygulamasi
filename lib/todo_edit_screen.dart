import 'package:flutter/material.dart';
import 'package:todoapp/todo.dart';
import 'package:todoapp/todo_dao.dart';

class ToDoEditScreen extends StatefulWidget {

  ToDo doing;
  ToDoEditScreen({required this.doing});


  @override
  _ToDoEditScreenState createState() => _ToDoEditScreenState();
}

class _ToDoEditScreenState extends State<ToDoEditScreen> {

  var formKey = GlobalKey<FormState>();

  var tfTitle = TextEditingController();
  var tfDetail = TextEditingController();
  var tfEndDate = TextEditingController();
  var tfEndTime = TextEditingController();

  Future<void> todoDelete(int todo_id) async{

    await ToDoDAO().deleteQuery(todo_id);
    Navigator.pop(context);
  }


  Future<void> todoUpdate(int todo_id, String todo_title, String todo_detail, String todo_end_date, String todo_end_time) async{

    await ToDoDAO().updateQuery(todo_id, todo_title, todo_detail, todo_end_date, todo_end_time);

    print(todo_title);
    print(todo_detail);
    print(todo_end_date);
    print(todo_end_time);

    print("Güncellendi");
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    var doing = widget.doing;

    tfTitle.text = doing.todo_title;
    tfDetail.text = doing.todo_detail;
    tfEndDate.text = doing.todo_end_date;
    tfEndTime.text = doing.todo_end_time;
  }


  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,size: ekranGenisligi/17,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Düzenleme", style: TextStyle(fontSize: ekranGenisligi/17,),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: (){
              bool kontrolSonucu = formKey.currentState!.validate();
              if(kontrolSonucu){
                print(widget.doing.todo_id);
                todoDelete(widget.doing.todo_id);
              }
            },
            child: Text("Sil", style: TextStyle(color: Colors.white, fontSize: ekranGenisligi/25),),
          ),
          TextButton(
            onPressed: (){
              bool kontrolSonucu = formKey.currentState!.validate();
              if(kontrolSonucu){

                String titleControl = tfTitle.text;
                String detailControl = tfDetail.text;
                String endDateControl = tfEndDate.text;
                String endTimeControl = tfEndTime.text;

                todoUpdate(widget.doing.todo_id, titleControl, detailControl, endDateControl, endTimeControl);

              }
            },
            child: Text("Güncelle", style: TextStyle(color: Colors.white, fontSize: ekranGenisligi/25),),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: ekranGenisligi/15, right: ekranGenisligi/15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: ekranYuksekligi/10,
                  child: TextFormField(
                    maxLength: 20,
                    cursorColor: Colors.black12,
                    controller: tfTitle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      label: Text("Başlık",style: TextStyle(color: Colors.black),),
                    ),
                    validator: (tfInput){
                      if(tfInput!.isEmpty){
                        return "Başlık Giriniz.";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: ekranYuksekligi/6,
                  child: TextField(
                    maxLines: 2,
                    maxLength: 144,
                    cursorColor: Colors.black12,
                    controller: tfDetail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      label: Text("İçerik", style: TextStyle(color: Colors.black),),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: ekranGenisligi/2.5, height: ekranYuksekligi/10,
                      child: TextFormField(
                        readOnly: true,
                        keyboardType: TextInputType.datetime,
                        cursorColor: Colors.black12,
                        controller: tfEndDate,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          label: Text("Bitiş Tarihi",style: TextStyle(color: Colors.black),),
                        ),
                        onTap: (){
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          ).then((alinanBitisTarih){
                            setState(() {
                              tfEndDate.text = "${alinanBitisTarih!.year}.${alinanBitisTarih.month}.${alinanBitisTarih.day} ";
                            });
                          });
                        },
                        validator: (tfInput){
                          if(tfInput!.isEmpty){
                            return "Tarih Giriniz.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Spacer(),
                    SizedBox(width: ekranGenisligi/2.5, height: ekranYuksekligi/10,
                      child: TextFormField(
                        readOnly: true,
                        keyboardType: TextInputType.datetime,
                        cursorColor: Colors.black12,
                        controller: tfEndTime,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          label: Text("Bitiş Saati", style: TextStyle(color: Colors.black),),
                        ),

                        onTap: (){
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                          ).then((alinanSaat){
                            setState(() {
                              tfEndTime.text = "${alinanSaat!.hour}:${alinanSaat.minute}";
                            });
                          });
                        },
                        validator: (tfInput){
                          if(tfInput!.isEmpty){
                            return "Saat Giriniz.";
                          }
                          return null;
                        },
                      ),
                    )
                  ],

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

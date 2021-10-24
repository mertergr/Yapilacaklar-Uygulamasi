import 'package:flutter/material.dart';
import 'package:todoapp/todo_dao.dart';

class addToDo extends StatefulWidget {
  const addToDo({Key? key}) : super(key: key);

  @override
  _addToDoState createState() => _addToDoState();
}

class _addToDoState extends State<addToDo> {

  var formKey = GlobalKey<FormState>();

  var tfTitle = TextEditingController();
  var tfDetail = TextEditingController();
  var tfEndDate = TextEditingController();
  var tfEndTime = TextEditingController();

  Future<void> kayit(String todo_title, String todo_detail, String todo_end_date, String todo_end_time) async{

    await ToDoDAO().addQuery(todo_title, todo_detail, todo_end_date, todo_end_time);

  }



  @override
  Widget build(BuildContext context) {


    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("Yeni Kayıt",style: TextStyle(fontSize: ekranGenisligi/18),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          TextButton.icon(
            onPressed: (){
              bool kontrolSonucu = formKey.currentState!.validate();
              if(kontrolSonucu){
                String titleControl = tfTitle.text;
                String detailControl = tfDetail.text;
                String endDateControl = tfEndDate.text;
                String endTimeControl = tfEndTime.text;
                kayit(titleControl, detailControl, endDateControl,endTimeControl);

                tfTitle.text = "";
                tfDetail.text = "";
                tfEndDate.text = "";
                tfEndTime.text = "";
              }
            },
            icon: Icon(Icons.save, size: ekranGenisligi/20,color: Colors.white,),
            label: Text("Kaydet", style: TextStyle(color: Colors.white, fontSize: ekranGenisligi/25),),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left:ekranGenisligi/15, right:ekranGenisligi/15),
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

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
class ToDoDatabase{
  List todoList = [];

  //reference the hive box
  final _myBox = Hive.box('myBox');

  //only can this method when first time ever open this app
  void createInitialData(){
    todoList =[
      ["finish tutorial",false],
      ["go to gym",false],
      ["preview time slots",false],
    ];
  }

  //load the data from the database into the app
  void loadData(){
    todoList = _myBox.get("TODOLIST");

  }


  //update the database when new task come in
  void updateDatabase(){
    _myBox.put("TODOLIST", todoList);
  }

}
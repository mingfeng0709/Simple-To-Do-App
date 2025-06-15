import 'package:demo2/todoApp/data/database.dart';
import 'package:demo2/todoApp/dialog_box.dart';
import 'package:demo2/todoApp/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  // ignore: unused_element_parameter
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}


class HomePageState extends State<HomePage>{
  //text controller
  final _addTaskController = TextEditingController();

  late final Box _myBox;

  //reference the hive box
  //final _myBox = Hive.openBox('myBox');
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState(){
    super.initState();
    _initHive();
  }
  //for first time ever openning the app then create the default data
  // ignore: annotate_overrides
  Future<void> _initHive() async { //this method is to check user is first time ever or not
    _myBox = await Hive.openBox('myBox');
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      //already have some data inside
      db.loadData();
    }
    setState(() {});
  }

  //method check onChanged
  void checkboxChanged(bool? value, int index){
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  //function to save new task into the task list
  void saveNewTask(){
    setState(() {
      db.todoList.add([_addTaskController.text,false]);
      _addTaskController.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //function to delete task
  void deleteTask(int index){
    setState(() {
      db.todoList.removeAt(index); 
    });
    db.updateDatabase();
  }

  //function to create new task
  void createNewTask(){
   showDialog(
    context: context, 
    builder: (context){
      return DialogBox(
        addTaskController:_addTaskController,
        onSaved: saveNewTask,
        onCancel:() => Navigator.of(context).pop(), //to close the container once after append successful
      );
    },
   );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar:AppBar(
        title: Center(child: Text("TO DO",)),
        backgroundColor: Colors.yellow[400],
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed:createNewTask,
        child: Icon(Icons.add),
        ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todoList[index][0], 
            taskCompleted: db.todoList[index][1], 
            onChanged: (value) =>checkboxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
        ),
    );
  }
}
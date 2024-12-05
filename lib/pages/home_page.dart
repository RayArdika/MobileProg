import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controler
  final _controller = TextEditingController();

  //list toDo task
  List toDoList = [
    ["Make Tutorial", false],
    ["Make exersice", false],
  ];
  
  //checkbox was tapped
  void checkboxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  //save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }, 
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        backgroundColor: Colors.white,
        
        ),
      body: ListView.builder(
       itemCount: toDoList.length,
       itemBuilder: (context, index) {
        return ToDoTile(
          taskName: toDoList[index][0], 
          taskCompleted: toDoList[index][1], 
          onChanged: (value) => checkboxChanged(value, index),
          deleteFunction: (context) => deleteTask(index),
        );
       },
      ),
    );
  }
}
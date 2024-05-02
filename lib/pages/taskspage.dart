import 'package:chronoweather/models/task_model.dart';
import 'package:chronoweather/services/task_database.dart';
import 'package:chronoweather/services/task_servicedialogbox.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
   const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with AutomaticKeepAliveClientMixin{

  final mybox=Hive.box("mybox");
  taskDatabase tdb =taskDatabase();

  @override
  void initState() {
    // TODO: implement initState
    if(mybox.get("taskList")==null){
      tdb.dataInicial();
    }else{
      tdb.cargaData();
    }
    super.initState();
  }

  final textController = TextEditingController();

  void checkboxChanged(bool? value, int index) {
    setState(() {
      tdb.taskList[index][1] = !tdb.taskList[index][1];
    });
    tdb.updateData();

  }

void newTask() {
  setState(() {
    tdb.taskList.add([textController.text, false]);
    textController.clear();
  });
  Navigator.of(context).pop();
  tdb.updateData();
}

  void createTask(){
    showDialog(
      context: context,
      builder:(context) {
        return DialogBox(
          controller: textController,
          saved: newTask,
          cancel:() => Navigator.of(context).pop,
        );
      },
    );
  }

  void deleteTasks(int index){
    setState(() {
      tdb.taskList.removeAt(index);
    });
    tdb.updateData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Text("Todas las tareas",
          style:TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500)),
          centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:createTask,
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.red,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: ListView.builder(
            itemCount: tdb.taskList.length,
            itemBuilder: (context, index){
              return TaskItem(
                taskName: tdb.taskList[index][0],
                taskComplete:tdb.taskList[index][1],
                onChanged:(value)=>checkboxChanged(value, index),
                deleteTask: (context)=> deleteTasks(index));
            }
          ),
      );
  }

  @override
  bool get wantKeepAlive => true;
}
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class TaskItem extends StatelessWidget {
  
  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

   TaskItem({super.key, 
   required this.taskName, 
   required this.taskComplete,
   required this.onChanged,
   required this.deleteTask});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
            onPressed:deleteTask,
            icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            )
          ]
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color:Colors.yellow, 
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              
              Checkbox(
                value: taskComplete, 
                onChanged: onChanged,
                activeColor: Colors.red,
                ),
              Text(taskName,
              style: TextStyle(decoration: taskComplete ? TextDecoration.lineThrough : TextDecoration.none),),
            ],
          ),
        ),
      ),
    );
  }
}
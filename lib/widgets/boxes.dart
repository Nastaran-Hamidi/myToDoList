import 'package:flutter/material.dart';
import 'package:todolist/constants/colors.dart';
import 'package:todolist/models/todo.dart';

class ToDoBoxes extends StatelessWidget{
  final ToDo todo;
  final onDeleteItem;
  final onChanged;

  const ToDoBoxes({super.key, required this.todo,
    required this.onDeleteItem, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: ListTile(
        onTap: ()=>onChanged(todo),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: Icon(todo.checked ? Icons.check_box : Icons.check_box_outline_blank ),
        title: Text(todo.name!,
            style: TextStyle(decoration: todo.checked ? TextDecoration.lineThrough : null)),
        trailing: IconButton(icon:const Icon(Icons.delete),color: indianRed,
          onPressed: ()=> onDeleteItem(todo.id)),
      ),
    );
  }
}
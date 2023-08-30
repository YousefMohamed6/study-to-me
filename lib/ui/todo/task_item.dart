import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/ui/todo/todo_cubit/todo_cubit.dart';
import 'package:noteapp/ui/todo/todo_model/todo_model.dart';
import 'package:noteapp/views/widgets/custom_icon_button.dart';
import 'package:noteapp/views/widgets/custom_text.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 24.0, bottom: 24.0, left: 24.0, right: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
      ),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: CustomIconButton(
          icon: Icon(
            task.isComplete ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onPressed: () {
            BlocProvider.of<ToDoCubit>(context).editTask(task);
          },
        ),
        title: CustomText(
          text: task.taskNames,
          fontWeight: FontWeight.bold,
          decoration: task.isComplete ? TextDecoration.lineThrough : null,
        ),
        trailing: CustomIconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            BlocProvider.of<ToDoCubit>(context).showAlertDialog(context, task);
          },
        ),
      ),
    );
  }
}
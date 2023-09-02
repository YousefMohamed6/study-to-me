import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/helper/show_message.dart';
import 'package:noteapp/screens/todo/todo_cubit/todo_cubit.dart';
import 'package:noteapp/screens/todo/todo_model/todo_model.dart';
import 'package:noteapp/screens/todo/widgets/task_item.dart';

class ListViewTasks extends StatelessWidget {
  const ListViewTasks({
    super.key,
    required this.tasks,
  });
  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoState>(
      listener: (context, state) {
        if (state is AddTaskSuccess) {
          ShowMessage.show(context, msg: 'Success');
          Navigator.pop(context);
        } else if (state is AddTaskFailed) {
          ShowMessage.show(context, msg: state.errMessage);
          Navigator.pop(context);
        } else if (state is EditTaskSuccess) {
          ShowMessage.show(context, msg: 'Edit Success');
          Navigator.pop(context);
        } else if (state is EditTaskFailed) {
          ShowMessage.show(context, msg: state.errMessage);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskItem(
              task: tasks[index],
            ),
          ),
        );
      },
    );
  }
}

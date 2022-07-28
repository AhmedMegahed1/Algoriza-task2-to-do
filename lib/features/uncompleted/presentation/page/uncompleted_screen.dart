import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/cubit/todo_cubit.dart';
import '../../../../core/util/cubit/todo_state.dart';
import '../../../../core/util/widget/show_task.dart';



class UncompletedScreen extends StatelessWidget {
  const UncompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: cubit.uncompletedTasks.length,
                      itemBuilder: (context, index) {
                        return ShowTasks(
                          all: cubit.uncompletedTasks,
                          index: index,
                        );
                      },
                    ))));
      },
    );
  }
}

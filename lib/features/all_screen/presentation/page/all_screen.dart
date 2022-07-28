import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/util/cubit/todo_cubit.dart';
import 'package:todo/core/util/cubit/todo_state.dart';

import 'package:todo/core/util/widget/show_task.dart';

import '../../../../services/notification_services.dart';


class AllScreen extends StatefulWidget {
  final NotifyHelper notifyHelper;
  const AllScreen({Key? key, required this.notifyHelper}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                      itemCount: cubit.allTasks.length,
                      itemBuilder: (context, index) {
                        Map task = cubit.allTasks[index];
                        DateTime  date = DateFormat.jm().parse(task['startTime']);
                        String mytime = DateFormat('HH:mm').format(date);

                        widget.notifyHelper.scheduledNotification(
                            int.parse(mytime.toString().split(':')[0]),
                            int.parse(mytime.toString().split(':')[1]),
                            task);
                        return ShowTasks(
                          all: cubit.allTasks,
                          index: index,
                        );
                      },
                    ))));
      },
    );
  }
}

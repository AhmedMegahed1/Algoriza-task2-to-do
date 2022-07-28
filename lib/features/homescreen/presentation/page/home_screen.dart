import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/core/util/cubit/todo_cubit.dart';
import 'package:todo/core/util/cubit/todo_state.dart';

import 'package:todo/core/util/widget/button.dart';


import '../../../../services/notification_services.dart';
import '../../../add_task/presentation/page/add_task_screen.dart';
import '../../../all_screen/presentation/page/all_screen.dart';
import '../../../completed/presentation/page/completed_screen.dart';
import '../../../favorite/presentation/page/favoritescreen.dart';
import '../../../shedual/presentation/page/schedule_screen.dart';
import '../../../uncompleted/presentation/page/uncompleted_screen.dart';


class HomePage1 extends StatefulWidget {
  const HomePage1({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
                toolbarHeight: 100,
                backgroundColor: Colors.white,
                elevation: 1,
                iconTheme: const IconThemeData(color: Colors.green),
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                toolbarTextStyle: const TextStyle(color: Colors.black),
                title: const Text(
                  'Board',
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ScheduleScreen();
                        }));
                      },
                      icon: const Icon(Icons.calendar_month))
                ],
                bottom: const TabBar(
                    indicatorWeight: 2.5,
                    tabs: [
                      Tab(
                        child: Text('All'),
                      ),
                      Tab(
                        text: 'Completed',
                      ),
                      Tab(
                        text: 'Uncompleted',
                      ),
                      Tab(
                        text: 'Favorite',
                      ),
                    ],
                    labelPadding: EdgeInsets.symmetric(horizontal: 1),
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label)),
            body: SafeArea(
              child: Stack(
                children: [
                  TabBarView(children: [
                    AllScreen(
                      notifyHelper: notifyHelper,
                    ),
                    const CompletedScreen(),
                    const UncompletedScreen(),
                    const FavoriteScreen(),
                  ]),
                  Align(
                    alignment: const Alignment(.5, .95),
                    child: MyButton(
                      label: ' Add a Task',
                      ontap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const AddTaskPage();
                        }));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/features/shedual/presentation/widget/display_day.dart';

import '../../../../core/size_config.dart';
import '../../../../core/theme.dart';
import '../../../../core/util/cubit/todo_cubit.dart';
import '../../../../core/util/cubit/todo_state.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  // var List;

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // late NotifyHelper notifyHelper;
  String? username;
  DateTime selecteddate = DateTime.now();

  @override
  void initState() {
    super.initState();
    //notifyHelper.requestANDPermission();
    //notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = AppCubit.get(context).allTasks;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: appbar(context),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              datepicker(),
              const DisplayDay(),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    //   widget.List = AppCubit.get(context).allTasks[index];
                    if (list[index]['repeat'] == 'daily' ||
                        list[index]['date'] ==
                            DateFormat.yMd().format(selecteddate) ||
                        (list[index]['repeat'] == 'weekly' &&
                            selecteddate
                                        .difference(DateFormat.yMd()
                                            .parse(list[index]['date']))
                                        .inDays %
                                    7 ==
                                0) ||
                        (list[index]['repeat'] == 'monthly' &&
                            DateFormat.yMd().parse(list[index]['date']!).day ==
                                selecteddate.day)) {
                      return Container(
                        width: double.infinity,
                        height: 80,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19),
                            color: AppCubit.get(context).allTasks[index]
                                        ['color'] ==
                                    0
                                ? primaryClr
                                : AppCubit.get(context).allTasks[index]
                                            ['color'] ==
                                        1
                                    ? pinkClr
                                    : orangeClr),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppCubit.get(context).allTasks[index]['title']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '${AppCubit.get(context).allTasks[index]['startTime']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: AppCubit.get(context).allTasks.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container datepicker() {
    return Container(
      padding: const EdgeInsets.only(top: 6, left: 15),
      child: DatePicker(
        DateTime.now(),
        daysCount: 7,
        initialSelectedDate: DateTime.now(),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        selectionColor: Colors.green,
        selectedTextColor: Colors.white,
        onDateChange: (newdate) {
          setState(() {
            selecteddate = newdate;
          });
        },
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      title: const Text('Schedule'),
      elevation: 0,
      backgroundColor: Colors.white,
      leading: FittedBox(
        child: Row(
          children: [
            IconButton(
              iconSize: 18,
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      toolbarHeight: 100,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
          color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      toolbarTextStyle: const TextStyle(color: Colors.black),
    );
  }
}

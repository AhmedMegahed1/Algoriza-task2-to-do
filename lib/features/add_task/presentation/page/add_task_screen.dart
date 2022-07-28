import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme.dart';
import '../../../../core/util/cubit/todo_cubit.dart';
import '../../../../core/util/cubit/todo_state.dart';
import '../../../../core/util/widget/button.dart';
import '../widgets/color_palette.dart';
import '../widgets/input_field.dart';



class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text('Add Task'),
              elevation: 1,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              toolbarHeight: 50,
              iconTheme: const IconThemeData(color: Colors.black),
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              toolbarTextStyle: const TextStyle(color: Colors.black),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  InputField(
                      title: 'Title',
                      hint: 'Please Enter Title ',
                      controller: cubit.titlecontroller),
                  InputField(
                    title: 'Date',
                    hint: DateFormat.yMd().format(cubit.selecteddate),
                    widget: IconButton(
                      onPressed: () => cubit.getDateFromUser(context),
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Color.fromARGB(255, 8, 8, 8),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          hint: cubit.startTime,
                          title: 'Start Time',
                          widget: IconButton(
                            icon: const Icon(Icons.access_time_outlined),
                            onPressed: () => cubit.getTimeFromUserS(context),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          hint: cubit.endTime,
                          title: 'End Time',
                          widget: IconButton(
                              onPressed: () => cubit.getTimeFromUserE(context),
                              icon: const Icon(Icons.access_time_outlined)),
                        ),
                      ),
                    ],
                  ),
                  InputField(
                      title: 'Remind',
                      hint: '${cubit.selectedremind} minutes early',
                      widget: Row(
                        children: [
                          DropdownButton(
                            style: subtitlestyle,
                            onChanged: ((String? value) {
                              cubit.changeSelectedRemind(
                                  value: int.parse(value!));
                            }),
                            items: cubit.remindlist
                                .map<DropdownMenuItem<String>>((val) =>
                                    DropdownMenuItem<String>(
                                      value: val.toString(),
                                      child: Text(
                                        '$val',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ))
                                .toList(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 30,
                            elevation: 4,
                            underline: const SizedBox(
                              height: 0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      )),
                  InputField(
                    title: 'Repeat',
                    hint: cubit.selectRepeat,
                    widget: Row(
                      children: [
                        DropdownButton<String>(
                          borderRadius: BorderRadius.circular(15),
                          style: subtitlestyle,
                          onChanged: ((value) {
                            cubit.changeSelectedRepeat(value: value);
                          }),
                          items: cubit.repeatlist
                              .map((String val) => DropdownMenuItem<String>(
                                    child: Text(
                                      val,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    value: val,
                                  ))
                              .toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 30,
                          elevation: 4,
                          underline: const SizedBox(
                            height: 0,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ColorPalette(
                    selectcolor: cubit.selectcolor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    label: ' Create a Task',
                    ontap: () {
                      cubit.insertToDatabase(
                          title: cubit.titlecontroller!.text,
                          date: DateFormat.yMd().format(cubit.selecteddate),
                          startTime: cubit.startTime,
                          endTime: cubit.endTime,
                          remind: cubit.selectedremind,
                          repeat: cubit.selectRepeat,
                          color: cubit.selectcolor);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            )));
      },
    );
  }



}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/core/util/cubit/todo_cubit.dart';
import 'package:todo/core/util/cubit/todo_state.dart';

import '../../theme.dart';


class ShowTasks extends StatefulWidget {
  final List all;
  final int index;

  const ShowTasks({Key? key, required this.all, required this.index})
      : super(key: key);

  @override
  State<ShowTasks> createState() => _ShowTasksState();
}

class _ShowTasksState extends State<ShowTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (widget.all[widget.index]['status'] == 'new') {
              AppCubit.get(context).updateData(
                  status: 'completed', id: widget.all[widget.index]['id']);
            } else if (widget.all[widget.index]['status'] == 'completed') {
              AppCubit.get(context).updateData(
                  status: 'uncompleted', id: widget.all[widget.index]['id']);
            } else if (widget.all[widget.index]['status'] == 'uncompleted') {
              AppCubit.get(context).updateData(
                  status: 'completed', id: widget.all[widget.index]['id']);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(children: [
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: widget.all[widget.index]['status'] == 'completed'
                      ? widget.all[widget.index]['color'] == 0
                          ? primaryClr
                          : widget.all[widget.index]['color'] == 1
                              ? pinkClr
                              : orangeClr
                      : Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    width: 2,
                    color: widget.all[widget.index]['color'] == 0
                        ? primaryClr
                        : widget.all[widget.index]['color'] == 1
                            ? pinkClr
                            : orangeClr,
                  ),
                ),
                child: widget.all[widget.index]['status'] == 'completed'
                    ? const Center(
                        child: Icon(
                        Icons.check,
                        size: 20,
                        color: Colors.white,
                      ))
                    : null,
              ),

              // Transform.scale(
              //   scale: 1.5,
              //   child: Checkbox(
              //     value: AppCubit.get(context).val,
              //     onChanged: (value) {
              //       AppCubit.get(context).changecheckbox(value: value);

              //       AppCubit.get(context).updateDatafromCeckbox(
              //           status: 'completed',
              //           id: AppCubit.get(context).allTasks[widget.index]['id']);
              //     },
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     activeColor: widget.all[widget.index]['color'] == 0
              //         ? primaryClr
              //         : widget.all[widget.index]['color'] == 1
              //             ? pinkClr
              //             : orangeClr,
              //     side: BorderSide(
              // color: widget.all[widget.index]['color'] == 0
              //     ? primaryClr
              //     : widget.all[widget.index]['color'] == 1
              //         ? pinkClr
              //         : orangeClr,
              //       width: 1.5,
              //     ),
              //   ),
              // ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                height: 20,
                width: 150,
                child: Center(
                  child: Text(
                    '${widget.all[widget.index]['title']}',
                    style: titlestyle,
                  ),
                ),
              ),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem(
                    child: const Text('Completed'),
                    value: 'Completed',
                    onTap: () {
                      // AppCubit.get(context).allTasks[widget.index]['id']
                      AppCubit.get(context).updateData(
                          status: 'completed',
                          id: widget.all[widget.index]['id']);
                    },
                  ),
                  DropdownMenuItem(
                    child: const Text('UnCompleted'),
                    value: 'UnCompleted',
                    onTap: () {
                      AppCubit.get(context).updateData(
                          status: 'uncompleted',
                          id: widget.all[widget.index]['id']);
                    },
                  ),
                  DropdownMenuItem(
                    child: const Text('Favorite'),
                    value: 'Favorite',
                    onTap: () {
                      AppCubit.get(context).updateFavoriteData(
                          favorite: '1',
                          id: AppCubit.get(context).allTasks[widget.index]
                              ['id']);
                    },
                  ),
                  DropdownMenuItem(
                    child: const Text('Delete'),
                    value: 'Delete',
                    onTap: () {
                      AppCubit.get(context)
                          .deleteData(id: widget.all[widget.index]['id']);
                    },
                  ),
                ],
                onChanged: (value) {
                  AppCubit.get(context).changeSelectedstatus(value: value);
                  //   debugPrint(value);
                },
                icon: const Icon(
                  Icons.more_vert,
                  size: 30,
                ),
                underline: const SizedBox(
                  height: 0,
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

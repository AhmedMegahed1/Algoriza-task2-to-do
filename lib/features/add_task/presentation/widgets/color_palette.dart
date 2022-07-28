import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme.dart';
import '../../../../core/util/cubit/todo_cubit.dart';
import '../../../../core/util/cubit/todo_state.dart';


class ColorPalette extends StatelessWidget {
  int? selectcolor;
  ColorPalette({
    Key? key,
    this.selectcolor = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '     Color',
              style: titlestyle,
            ),
            const SizedBox(
              width: 185,
            ),
            Wrap(
              children: List<Widget>.generate(
                  3,
                  (index) => GestureDetector(
                        onTap: () {
                          AppCubit.get(context).changeColorRepeat(index: index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 8,
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            child: selectcolor == index
                                ? const Icon(
                                    Icons.done,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                : null,
                            backgroundColor: index == 0
                                ? primaryClr
                                : index == 1
                                    ? pinkClr
                                    : orangeClr,
                          ),
                        ),
                      )),
            )
          ],
        );
      },
    );
  }
}

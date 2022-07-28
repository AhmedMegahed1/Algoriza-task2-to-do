import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme.dart';

class DisplayDay extends StatefulWidget {
  const DisplayDay({Key? key}) : super(key: key);

  @override
  State<DisplayDay> createState() => _DisplayDayState();
}

class _DisplayDayState extends State<DisplayDay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ' ${DateFormat.EEEE().format(DateTime.now())}',
            style: subtitlestyle,
          ),
          Text(
            DateFormat.yMMMMd().format(
              DateTime.now(),
            ),
            style: subtitlestyle,
          ),
        ],
      ),
    );
  }
}

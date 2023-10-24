import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cted/UI/Widget/addProgramDayButton.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProgramSchedule extends StatefulWidget {
  const ProgramSchedule({super.key});

  @override
  State<ProgramSchedule> createState() => _ProgramScheduleState();
}

class _ProgramScheduleState extends State<ProgramSchedule> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          title: Text(Get.arguments['name']),
          actions: [
            IconButton(
                icon: Icon(Icons.calendar_month),
                onPressed: () async {
                  final selectedDateInDatePicker = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023, 1, 1),
                      lastDate: DateTime.now().add(Duration(days: 1500)),
                      builder: (context, child) {
                        return Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme:
                                    ColorScheme.light(primary: Colors.green)),
                            child: child!);
                      });
                  if (selectedDateInDatePicker != null) {
                    setState(() {
                      _selectedDate = selectedDateInDatePicker;
                    });
                  }
                })
          ]),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat.yMMMM().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                AddProgramDayButton(
                    label: '+ Add Day',
                    onTap: () => Get.toNamed(
                            '/MainPage/ProgramSchdule/addProgramDayPage',
                            arguments: {
                              "name": Get.arguments["name"],
                              "date": _selectedDate
                            }))
              ],
            ),
          ), // "October 2023 add버튼 있는라인"
          Container(
            child: CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime(2023, 1, 1),
              lastDate: DateTime.now().add(Duration(days: 1500)),
              onDateSelected: (date) {
                _selectedDate = date;
                print(_selectedDate);
              },
              leftMargin: 100,
              monthColor: Colors.grey,
              dayColor: Colors.grey,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.green,
              dotsColor: Color(0xFF333A47),
              locale: 'en_ISO',
            ),
          ),
          //DatePicker있는 라인
        ],
      ),
    );
  }
}

TextStyle get subHeadingStyle {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
}

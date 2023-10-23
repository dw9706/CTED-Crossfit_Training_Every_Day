import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddProgramDayPage extends StatefulWidget {
  const AddProgramDayPage({super.key});

  @override
  State<AddProgramDayPage> createState() => _AddProgramDayPageState();
}

class _AddProgramDayPageState extends State<AddProgramDayPage> {

  List<String> listItem = [
    "Day 1","Day 2","Day 3","Day 4","Day 5","Day 6","Day 7","Day 8","Day 9","Day 10","Day 11","Day 12",
    "Day 13","Day 14","Day 15","Day 16","Day 17","Day 18","Day 19","Day 20"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['name']),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () => Get.back()
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text('${DateFormat.yMMMMd().format(Get.arguments['date'])}',
                  style: TextStyle(
                      fontSize: 30,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Text('Add Day',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: DropdownMenu<String>(

                  width: 200,
                  initialSelection: listItem.first,
                  onSelected: (String? value){
                    setState(() {
                      print(value);
                    });
                  },
                  dropdownMenuEntries: listItem.map<DropdownMenuEntry<String>>((String value){
                    return DropdownMenuEntry(value: value, label: value);
                  }).toList(),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

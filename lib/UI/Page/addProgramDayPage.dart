import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddProgramDayPage extends StatefulWidget {
  const AddProgramDayPage({super.key});

  @override
  State<AddProgramDayPage> createState() => _AddProgramDayPageState();
}

class _AddProgramDayPageState extends State<AddProgramDayPage> {
  List<String> listItem = [];
  String? day;

  _validationDay(){
    if(day != null){
      Get.back();
    } else if(day == null){
      Get.snackbar("필수 정보", "Day를 선택해 주세요.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      icon:Icon(Icons.warning_amber_rounded,
      color: Colors.red,
      )
      );
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 1; i <=30; i++){
      listItem.add("Day $i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['name']),
        leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios), onTap: () => Get.back()),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text(
                  '${DateFormat.yMMMMd().format(Get.arguments['date'])}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                'Add Day',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: DropdownMenu<String>(
                    width: 350,
                    hintText: "Day",
                    onSelected: (String? value) {
                      setState(() {
                        day = value;
                        print(value);
                      });
                    },
                    dropdownMenuEntries:
                    listItem.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry(value: value, label: value);
                    }).toList(),
                  )),
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _validationDay(),
                      child: Container(
                        child: Center(
                          child: Text("Add",
                            style: TextStyle(color: Colors.white,
                            ),
                          ),),
                        margin: EdgeInsets.only(right: 20),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        child: Center(child: Text("Cancel", style: TextStyle(color: Colors.white),)),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),

                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


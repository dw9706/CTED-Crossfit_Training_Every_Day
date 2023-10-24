import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SubscribedProgramsPage extends StatelessWidget {
  const SubscribedProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
           Get.toNamed('/MainPage/ProgramSchedule',arguments:{"name":'Crossfit pro $index'}); //객체도 보낼수 있음!
          },
          child: Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green,
                //border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
                'Crossfit pro $index',
              style:TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
        );
      },
    );
  }
}
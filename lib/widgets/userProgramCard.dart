import 'package:flutter/material.dart';

class UserProgramCard extends StatelessWidget {
  UserProgramCard({
    required this.title,
    required this.onTap,
  });
  String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Card(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          elevation: 2,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 5, right: 5),
                child: GestureDetector(
                  onTap: () {
                    //Program 지우는 dialog창 띄우기
                    print("delete program?");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 20, right: 10),
                child: Text(
                  '$title',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

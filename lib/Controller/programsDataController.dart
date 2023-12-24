import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final firestore = FirebaseFirestore.instance;

class ProgramsDataController extends GetxController {
  //싱글톤 패턴
  static final ProgramsDataController _instance =
      ProgramsDataController._internal();

  factory ProgramsDataController() {
    return _instance;
  }

  ProgramsDataController._internal() {
    print('ProgramsDataController 인스턴스 생성!');
  }

  //해당 프로그램의 day가 몇개 있는지 확인 후 day리스트를 만들어 리턴한다.
  Future<List<String>> howManyDays({required String programName}) async {
    var result =
        await firestore.collection('programsData').doc(programName).get();
    List<String> tmp = [];
    int numberOfDays = result.data()!['numberOfDays'];
    //firestore에서 가져온 day의 개수로 day 1~? 리스트를 만든다.
    for (int i = 1; i <= numberOfDays; i++) {
      tmp.add("day $i");
    }
    return tmp;
  }

  //Day Content를 가져온다.
  Future<String> getDayContent(
      {required String programName, required String day}) async {
    var result = await firestore
        .collection('programsData')
        .doc(programName)
        .collection('days')
        .doc(day)
        .get();
    String tmp = result['content'];
    return tmp;
  }
}

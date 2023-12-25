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

  //프로그램의 정보들을 가져온다.
  Future<Map<String, List<String>>> getProgramInformation(
      {required String keyword}) async {
    List<String> programNames = [];
    List<String> programAuthors = [];
    List<String> programDays = [];
    List<String> programFollowers = [];
    var result = await firestore.collection('programsData').get();
    // 프로그램 정보들을 List안에 담는다.
    for (var doc in result.docs) {
      programNames.add(doc.data()['name']);
      programAuthors.add(doc.data()['author']);
      programDays.add(doc.data()['numberOfDays'].toString());
      programFollowers.add(doc.data()['followers'].toString());
    }

    if (keyword == '') {
      //모든 프로그램의 정보를 리턴
      return {
        'programNames': programNames,
        'programAuthors': programAuthors,
        'programDays': programDays,
        'programFollowers': programFollowers
      };
    } else {
      // keyword를 포함하는 프로그램의 정보를 리턴
      List<String> keywordProgramNames = [];
      List<String> keywordProgramAuthors = [];
      List<String> keywordProgramDays = [];
      List<String> keywordProgramFollowers = [];

      //keyword를 소문자로 변환
      keyword = keyword.toLowerCase();

      for (int i = 0; i < programNames.length; i++) {
        //프로그램의 이름을 소문자로 변환
        String tmpProgramName = programNames[i].toLowerCase();
        // 소문자로 변환된 키워드와 프로그램의 이름을 비교
        if (tmpProgramName.contains(keyword)) {
          keywordProgramNames.add(programNames[i]);
          keywordProgramAuthors.add(programAuthors[i]);
          keywordProgramDays.add(programDays[i]);
          keywordProgramFollowers.add(programFollowers[i]);
        }
      }
      return {
        'programNames': keywordProgramNames,
        'programAuthors': keywordProgramAuthors,
        'programDays': keywordProgramDays,
        'programFollowers': keywordProgramFollowers
      };
    }
  }

  //프로그램의 Followers숫자를 하나 내린다.
  Future<void> minusProgramFollowers({required String programName}) async {
    var result =
        await firestore.collection('programsData').doc(programName).get();

    int minusProgramFollowers = result.data()!['followers'] - 1;

    await firestore
        .collection('programsData')
        .doc(programName)
        .update({'followers': minusProgramFollowers});
  }

  //프로그램의 Followers숫자를 하나 올린다.
  Future<void> plusProgramFollowers({required String programName}) async {
    var result =
        await firestore.collection('programsData').doc(programName).get();

    int plusProgramFollowers = result.data()!['followers'] + 1;

    await firestore
        .collection('programsData')
        .doc(programName)
        .update({'followers': minusProgramFollowers});
  }
}

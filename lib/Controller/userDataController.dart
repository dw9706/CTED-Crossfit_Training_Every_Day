import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final firestore = FirebaseFirestore.instance;

class UserDataController extends GetxController {
  late User user;

  static final UserDataController _instance = UserDataController._internal();

  //싱글톤 패턴
  factory UserDataController() {
    return _instance;
  }

  UserDataController._internal() {
    //컨트롤러를 처음 생성할때 유저의 정보를 받는다.
    user = FirebaseAuth.instance.currentUser!;
    print("UserDataController 인스턴스 생성!!");
  }

  late List<String> userProgramsName; //유저가 구독한 운동프로그램 이름들

  //firestore UserData컬렉션에 유저의 문서를 만든다.
  Future<void> makeUserDataDocument() async {
    await firestore.collection('userData').doc(user.uid).set({"programs": []});
  }

  //firestore의 userData컬렉션에서 user의 doc을 가져와 리턴한다.
  Future<int> getUserProgramsName() async {
    //user의 doc을 가져온다.
    DocumentSnapshot<Map<String, dynamic>> result =
        await firestore.collection('userData').doc("${user.uid}").get();
    //있으면 바로 리턴한다.
    if (result.exists) {
      //변수에 대입
      userProgramsName = List<String>.from(result.data()!['programs'] as List);
      update();
      return 0;
    } else {
      //만약 user의 doc이 없으면 doc을 만들고 리턴한다.
      await makeUserDataDocument();
      userProgramsName = [];
      update();
      return 0;
    }
  }

  //유저 운동프로그램의 등록된 날짜를 가져온다
  Future<List<String>> getScheduleDays(
      {required String programName, required DateTime selectedDate}) async {
    String day = selectedDate.toString().substring(0, 10);
    var result = await firestore
        .collection('userData')
        .doc(user.uid)
        .collection('program Schedule')
        .doc(programName)
        .get();
    List<String> dayList = List<String>.from(result[day] as List);
    dayList.sort();
    return dayList;
  }

  //selected 날짜에 운동프로그램 day를 등록한다.
  void updateScheduleDays(
      {required DateTime date,
      required String programName,
      required String day}) async {
    String fomatDate = date.toString().substring(0, 10);
    firestore
        .collection('userData')
        .doc(user!.uid)
        .collection('program Schedule')
        .doc(programName)
        .update({
      fomatDate: FieldValue.arrayUnion([day])
    }).then((_) {
      Get.back();
    });
  }
}

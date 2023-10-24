import 'package:get/get.dart';

class BottomBarIndexController extends GetxController{
  RxInt bottomBarIndex =  0.obs;

  void setBottomBarIndex(int value){
      bottomBarIndex(value);
  }
}


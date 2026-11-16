import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    if (index == 2) return; 
    currentIndex.value = index;
  }
}
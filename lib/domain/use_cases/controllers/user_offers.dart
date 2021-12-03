import 'package:get/get.dart';

class Controller extends GetxController {
  List<RxInt> likes = <RxInt>[0.obs, 0.obs, 0.obs, 0.obs, 0.obs, 0.obs];
  List<RxInt> dislikes = <RxInt>[0.obs, 0.obs, 0.obs, 0.obs, 0.obs, 0.obs];

  void increment(int index, int position) {
    if (position == 1) {
      likes[index] += 1;
    } else {
      dislikes[index] += 1;
    }
  }

  void decrement(int index) {
    if (likes[index].toInt() > 0) {
      likes[index] -= 1;
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLocationWidgetController extends GetxController {
  RxBool _isLocationActivated = true.obs;

  getValue() {
    _isLocationActivated.value;
  }

  toogleValue() {
    _isLocationActivated.value = !_isLocationActivated.value;
  }

  setValue() {
    _isLocationActivated.value = false;
  }
}

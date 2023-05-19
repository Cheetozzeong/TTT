import 'package:get/get.dart';

class LoadingController extends GetxController {
  bool _isLoadingFlag = false;
  bool get isLoadingFlag => _isLoadingFlag;

  void setIsLoadingFlag(bool value) {
    _isLoadingFlag = value;
    update();
  }
}
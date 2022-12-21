import 'package:get/get.dart';

extension boolHelper on RxBool {
  bool setTrue() {
    return this.value = true;
  }

  bool setFalse() {
    return this.value = false;
  }
}

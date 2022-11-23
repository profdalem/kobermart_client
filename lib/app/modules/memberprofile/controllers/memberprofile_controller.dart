import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kobermart_client/app/data/user_provider.dart';

class MemberprofileController extends GetxController {
  late List<DaftarKedalaman> kd;
  var isLoading = false.obs;

  RxList<dynamic> downlines = [].obs;

  var name = "[name]".obs;
  var memberCount = 0.obs;
  var kdstatus = 1.obs;
  var active = true.obs;
  var memberCreatedAt = Timestamp.now().obs;
  var birthday = Timestamp.now().obs;
  var whatsapp = "+62 818 818 818".obs;
  var email = "noname@noname.com".obs;
  var refid = "[refid]".obs;
  var address = "Jalan Raya Sidemen, Kabupaten Bangli, Bali 80552".obs;
  var bank = "BCA".obs;
  var rek = "123 123 132123 123132".obs;

  var uplineName = "[Upline Name]".obs;
  var uplineId = "uplineid".obs;

  var kd1count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete();
    super.onClose();
  }

  Future<void> getMemberProfile(String id) async {
    isLoading.value = true;
    await UserProvider().getMemberProfile(id).then((value) {
      print(value.body);
      memberCount.value = value.body["memberCount"];
      kdstatus.value = value.body["downlines"]["kd"];
      active.value = value.body["user"]["active"];
      refid.value = value.body["user"]["refid"];
      email.value = value.body["user"]["email"];
      whatsapp.value = value.body["user"]["whatsapp"];
      birthday.value = Timestamp(value.body["user"]["birthdate"]["_seconds"],
          value.body["user"]["birthdate"]["_nanoseconds"]);
      address.value =
          "${value.body["user"]["address"]["jalan"]}, ${value.body["user"]["address"]["desa"]}, Kec. ${value.body["user"]["address"]["kec"]}, Kab. ${value.body["user"]["address"]["kab"]}, ${value.body["user"]["address"]["prov"]} ${value.body["user"]["address"]["kodepos"]}";
      rek.value = value.body["user"]["bankAcc"];
      bank.value = value.body["user"]["bank"];
      uplineName.value = value.body["upline"]["name"];
      uplineId.value = value.body["user"]["upline"];
      kd1count.value = int.parse(value.body["kd1count"].toString());

      downlines.value = value.body["downlines"]["data"];
      // ignore: invalid_use_of_protected_member
      kd = generateItems(downlines.value.length, downlines.value);
    });
    isLoading.value = false;
  }

  List<DaftarKedalaman> generateItems(int numberOfItems, List downlines) {
    return List.generate(numberOfItems, (int index) {
      return DaftarKedalaman(
          header: "Kedalaman ${index}",
          isExpanded: index == 0 ? true.obs : false.obs,
          members: downlines[index]);
    });
  }
}

class DaftarKedalaman {
  DaftarKedalaman({
    required this.header,
    required this.isExpanded,
    required this.members,
  });

  String header;
  RxBool isExpanded;
  List<dynamic> members;
}

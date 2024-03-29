import 'package:get/get.dart';
import 'package:kobermart_client/app/data/products_provider.dart';

class MainProductController extends GetxController {
  RxList products = [].obs;
  RxList carts = [].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    getAllProduct();
    getAllCarts();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllProduct() async {
    isLoading.value = true;
    try {
      await ProductsProvider().getProducts().then((value) {
        if (value.body != null) {
          // Get.defaultDialog(
          //     title: "",
          //     content: Container(
          //         height: Get.height * 0.8,
          //         child:
          //             SingleChildScrollView(child: Text(value.bodyString!))));
          if (value.body["success"]) {
            products.value = value.body["data"];
            products.refresh();
            // print("Get all product done, product count: ${products.length}");
          } else {
            Get.snackbar("Error", value.body["message"]);
          }
        } else {
          Get.snackbar("Error", "Gagal mendapatkan data produk");
        }
      });
    } catch (e) {
      print("getAllProduct error: " + e.toString());
    }

    isLoading.value = false;
  }

  void getAllCarts() async {
    isLoading.value = true;
    try {
      await ProductsProvider().getCarts().then((value) {
        if (value.body != null) {
          // print(value.body);
          carts.value = value.body["result"];
        } else {
          Get.snackbar("Error", "Gagal mendapatkan data produk");
        }
      });
    } catch (e) {
      print("getAllCarts error: " + e.toString());
    }

    isLoading.value = false;
  }
}

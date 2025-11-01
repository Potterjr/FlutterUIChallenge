import 'package:get/get.dart';

class Productdetailcontroller extends GetxController {
  final tag = Get.arguments["tag"];
  final id = Get.arguments["id"];
  final porductName = Get.arguments["porductName"];
  final price = Get.arguments["price"];
  final favorite = Get.arguments["favorite"];
  final img = Get.arguments["img"];
}

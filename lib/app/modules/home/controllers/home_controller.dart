import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var notes = [].obs;
  @override
  void onReady() {
    GetStorage box = GetStorage();

    var list = box.read('notes') as List? ?? [];
    var listPriority = box.read('priority') ?? [];
    List? notelist = [];
    for (var i = 0; i < list.length; i++) {
      notelist.add({'note': list[i], 'priority': listPriority[i]});
    }
    print(notelist);

    notes.value = notelist;

    super.onReady();
  }

  void increment() => count.value++;
}

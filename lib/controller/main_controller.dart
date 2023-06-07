import 'package:get/get.dart';

class MainScreenController extends GetxController {
  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  //////////////////
  final _selectedValue = "Option 1".obs;

  String get selectedValue => _selectedValue.value;

  set selectedValue(String value) => _selectedValue.value = value;

  final List<String> items = ["Option 1", "Option 2", "Option 3"];
}

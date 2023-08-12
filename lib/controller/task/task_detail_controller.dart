import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/task_details_model.dart';

class TaskDetailsController extends GetxController {
  TaskDetailsListModel? taskdetailsList;
  RxBool isTaskLoading = false.obs;

  Future<TaskDetailsListModel> fetchTaskDetails({
    required fkcoid,
    required taskid,
  }) async {
    try {
      final response = await http.get(Uri.parse(
          "https://erm.scarletsystems.com:132/Api/Task/GetTaskById?taskid=$taskid&coid=$fkcoid"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        taskdetailsList = TaskDetailsListModel.fromJson(jsonData);

        print("api hit successfully${response.statusCode}");
        return taskdetailsList!;
      } else {
        throw Exception("Failed to load data from api");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  Future<void> updateTask(
      {required taskid,
      required fkcoid,
      required tstatus,
      required compdate}) async {
    try {
      isTaskLoading.value = true;
      final response = await http.post(
        Uri.parse("https://erm.scarletsystems.com:132/Api/Task/TaskUpdate"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "TASKID": taskid,
          "FKCOID": fkcoid,
          "TSTATUS": tstatus,
          "COMPDT": compdate,
        }),
      );

      if (response.statusCode == 200) {
        update();

        isTaskLoading.value = false;

        print("update task successfully");
      } else {
        throw Exception("Failed to update task");
      }
    } catch (e) {
      isTaskLoading.value = false;
      print("Error: $e");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/roundbutton.dart';

import '../../constant/const.dart';
import '../../controller/menu_controller/user_controller.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({super.key});
  final userController = Get.put(UserController());
  void _showAddUserDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: userController.insertUserController,
                  decoration: InputDecoration(labelText: 'User Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (userController.isInsertingUser.value) {
                    return CircularProgressIndicator();
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (userController.insertUserController.text.isNotEmpty) {
                    await userController.insertUser(
                        userController.insertUserController.text,
                        userController.userList[0].uSPW,
                        userController.fkcoid);
                    userController.insertUserController.clear();
                    Navigator.of(context).pop();
                    userController.fetchUserList();
                    userController.isInsertingUser.value = false;
                  }
                },
                child: Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users List",
          style: kTextStyleBoldWhite(18),
        ),
      ),
      body: FutureBuilder(
        future: userController.fetchUserList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Obx(() => userController.userList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            key: UniqueKey(),
                            itemCount: userController.userList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final user = userController.userList[index];
                              return GestureDetector(
                                onTap: () {
                                  print(user.uSPW);
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(user.lOGINID ?? '',
                                        style: kTextStyleBlack(18)),
                                    trailing: Container(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                userController
                                                        .updateUserController
                                                        .text =
                                                    user.lOGINID.toString();
                                                _showUpdateUserDialog(
                                                  context,
                                                  userController
                                                      .updateUserController,
                                                  user.lOGINID,
                                                  user.uSPW,
                                                );
                                              },
                                              icon: Icon(Icons.edit,
                                                  color: Colors.green),
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            child: IconButton(
                                              onPressed: () {
                                                _showDeleteUserDialog(
                                                    context, user.fKCOID);
                                              },
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(child: Center(child: Text("No data found")))),
                  RoundButton(
                      width: 200,
                      backgroundColor: Colors.green.shade500,
                      title: "Add New User",
                      onTap: () {
                        _showAddUserDialog(context);
                      })
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showDeleteUserDialog(BuildContext context, int? cOID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Company'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Call the delete method using cOID and handle deletion logic
                await userController.deleteUser(cOID);
                Navigator.of(context).pop(); // Close the dialog
                userController.fetchUserList(); // Update the company list
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateUserDialog(BuildContext context, controller, loginId, usPW) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Task Prirority'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Priority Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (userController.isInsertingUser.value) {
                    return CircularProgressIndicator();
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  print("Inside onPressed callback");
                  print("Controller Text: ${controller.text}");
                  print("loginId: $loginId");
                  print("usPW: $usPW");

                  if (controller.text.isNotEmpty) {
                    print("Updating priority...");

                    await userController.updateUser(
                        controller.text, userController.fkcoid);

                    userController.fetchUserList();
                    userController.isInsertingUser.value = false;
                    controller.clear();

                    Navigator.of(context).pop();
                  }
                },
                child: Text('Update'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }
}

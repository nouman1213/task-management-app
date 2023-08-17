import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/components/roundbutton.dart';

import '../../constant/const.dart';
import '../../controller/menu_controller/company_controller.dart';

class CompanyListScreen extends StatelessWidget {
  CompanyListScreen({super.key});
  final companyController = Get.put(CompanyController());
  void _showAddPriorityDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Company'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: companyController.insertCompanyController,
                  decoration: InputDecoration(labelText: 'Company Name'),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (companyController.isInsertingCompany.value) {
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
                  if (companyController
                      .insertCompanyController.text.isNotEmpty) {
                    await companyController.insertCompany(
                        companyController.insertCompanyController.text);
                    companyController.insertCompanyController.clear();
                    Navigator.of(context).pop();
                    companyController.fetchCompanyList();
                    companyController.isInsertingCompany.value = false;
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
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: Text(
          "Company List",
          style: kTextStyleBoldWhite(context, 18),
        ),
      ),
      body: FutureBuilder(
        future: companyController.fetchCompanyList(),
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
                  Obx(() => Expanded(
                        child: ListView.builder(
                          key: UniqueKey(),
                          itemCount: companyController.companyList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final company =
                                companyController.companyList[index];
                            return GestureDetector(
                              onTap: () {
                                print(company.cOID);
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(company.cONAME ?? '',
                                      style: kTextStyleBlack(context, 18)),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _showDeleteCompanyDialog(context, 2);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                  RoundButton(
                      width: 200,
                      backgroundColor: Colors.green.shade500,
                      title: "Add Company",
                      onTap: () {
                        _showAddPriorityDialog(context);
                      })
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showDeleteCompanyDialog(BuildContext context, int? cOID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Company'),
          content: Text('Are you sure you want to delete this company?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Call the delete method using cOID and handle deletion logic
                await companyController.deleteCompany(cOID);
                Navigator.of(context).pop(); // Close the dialog
                companyController.fetchCompanyList(); // Update the company list
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
}

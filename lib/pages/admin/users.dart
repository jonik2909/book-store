// ignore_for_file: prefer_const_constructors

import 'package:book_store/controller/admin.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController bookController = Get.put(AdminController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Users list',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Obx(() => Visibility(
            visible: bookController.memberList.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Users',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
                itemCount: bookController.memberList.length,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  var member = bookController.memberList[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(member.nick.toString()),
                      subtitle: Text(member.email.toString()),
                      trailing: Icon(Icons.delete),
                    ),
                  );
                }),
          )),
    );
  }
}

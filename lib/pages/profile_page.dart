// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/controller/controller.dart';
import 'package:book_store/controller/member.controller.dart';
import 'package:book_store/helper/alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());
    final MemberController memberController = Get.put(MemberController());
    final _focusNode = FocusNode();

    // final TextEditingController nickController =
    //     TextEditingController(text: memberController.member.value.nick);
    // final TextEditingController emailController =
    //     TextEditingController(text: memberController.member.value.email);

    void _removeFocus() {
      // Unfocus the TextField
      _focusNode.unfocus();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Center(
          //     child: Obx(
          //   () => GestureDetector(
          //     // onTap: () {
          //     //   controller.picImage();
          //     // },
          //     child: true
          //         ? Container(
          //             width: 105,
          //             height: 105,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               image: DecorationImage(
          //                 image: AssetImage('lib/assets/book.jpg'),
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             child: Align(
          //               alignment: Alignment.bottomRight,
          //               child: Container(
          //                 width: 28,
          //                 height: 28,
          //                 decoration: BoxDecoration(
          //                   color: Color(0xffD45555),
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Icon(
          //                   Icons.edit,
          //                   color: Colors.white,
          //                   size: 15,
          //                 ),
          //               ),
          //             ),
          //           )
          //         : ClipRRect(
          //             borderRadius: BorderRadius.circular(50),
          //             child: Image.file(
          //               controller.thumnailImage.value!,
          //               width: 105,
          //               height: 105,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //   ),
          // )),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Member nick",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.04),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    // controller: nickController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Member nick',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff8E8E93),
                      )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Member email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.04),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: TextField(
                    focusNode: _focusNode,
                    // controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Member email',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xff8E8E93),
                      )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // await memberController.updateUserData(
                        //   memberController.authToken.value,
                        //   memberController.member.value.id,
                        //   nickController.text,
                        //   emailController.text,
                        // );
                        _removeFocus();
                        alertDialog(context, "Success",
                            "Member information updated successfully!");
                      } catch (err) {
                        alertDialog(context, "Success", err.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffEB5757),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Update User info',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      memberController.logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffEB5757),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Border radius
                      ),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

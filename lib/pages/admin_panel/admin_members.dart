// ignore_for_file: prefer_const_constructors

import 'package:book_store/components/command/app_bar/custom_bar.dart';
import 'package:book_store/controller/admin.controller.dart';
import 'package:book_store/models/member.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class AdminMembers extends StatelessWidget {
  const AdminMembers({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.put(AdminController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "All Members", desc: "Manage all members"),
      body: Obx(
        () => Visibility(
          visible: adminController.adminMembers.isNotEmpty,
          replacement: Center(
            child: Text(
              'No Members Found',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: adminController.adminMembers.length,
            itemBuilder: (context, index) {
              var member = adminController.adminMembers[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xffEB5757).withOpacity(0.1),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Member Avatar
                        // Member Avatar qismini o'zgartiramiz
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffEB5757).withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xffEB5757).withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: member.memberImage != null &&
                                  member.memberImage!.isNotEmpty
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${dotenv.env['UPLOAD_URL']}/${member.memberImage}',
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    member.memberNick[0].toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffEB5757),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                        // Member Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.memberNick,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff151E47),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                member.memberEmail,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Member Type Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getMemberTypeIcon(member.memberType),
                                      size: 16,
                                      color: _getMemberTypeColor(
                                          member.memberType),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      member.memberType
                                          .toString()
                                          .split('.')
                                          .last,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getMemberTypeColor(
                                            member.memberType),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete button
                        GestureDetector(
                          onTap: () async {
                            final result = await Get.dialog(
                              AlertDialog(
                                title: Text('Delete Member'),
                                content: Text('Are you sure?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(result: true),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Color(0xffEB5757),
                                    ),
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                            if (result == true) {
                              await adminController
                                  .removeMember(member.id.toString());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              size: 16,
                              color: Color(0xffEB5757),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color _getMemberTypeColor(MemberType type) {
    switch (type) {
      case MemberType.AUTHOR:
        return Colors.blue;
      case MemberType.USER:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getMemberTypeIcon(MemberType type) {
    switch (type) {
      case MemberType.AUTHOR:
        return Icons.verified;
      case MemberType.USER:
        return Icons.person;
      default:
        return Icons.person_outline;
    }
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthorHomeCard extends StatelessWidget {
  final String memberNick;
  final String memberEmail;
  final int memberBooks;
  final int memberViews;
  final String? memberImage;
  final VoidCallback? onTap;
  final double width;

  const AuthorHomeCard({
    super.key,
    required this.memberNick,
    required this.memberEmail,
    required this.memberBooks,
    required this.memberViews,
    this.memberImage,
    this.onTap,
    this.width = 160,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Important! Let it take only needed space
                children: [
                  // Author Photo
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: memberImage == null
                          ? const Color(0xffEB5757).withValues(alpha: 0.1)
                          : null,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffEB5757).withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: memberImage != null && memberImage!.isNotEmpty
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${dotenv.env['UPLOAD_URL']}/$memberImage',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                width: 70,
                                height: 70,
                                child: Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text(
                                memberNick.isNotEmpty
                                    ? memberNick[0].toUpperCase()
                                    : '',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffEB5757),
                                ),
                              ),
                            ),
                          ),
                  ),

                  SizedBox(height: 10),

                  // Author Name
                  Text(
                    memberNick,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),

                  // Author Email
                  Text(
                    memberEmail,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 15),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Books Count
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.book, color: Colors.red, size: 20),
                          SizedBox(height: 2),
                          Text(
                            "$memberBooks",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Books",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 15),

                      // Views Count
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.visibility, color: Colors.red, size: 20),
                          SizedBox(height: 2),
                          Text(
                            "$memberViews",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Views",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

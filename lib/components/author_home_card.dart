// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthorHomeCard extends StatelessWidget {
  final String name;
  final String email;
  final int bookCount;
  final int viewsCount;
  final String? photoUrl;
  final VoidCallback? onTap;
  final double width;

  const AuthorHomeCard({
    Key? key,
    required this.name,
    required this.email,
    required this.bookCount,
    required this.viewsCount,
    this.photoUrl,
    this.onTap,
    this.width = 160,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fixed height based on the screenshot
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
                  color: Colors.grey.withOpacity(0.2),
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
                      color: photoUrl == null
                          ? const Color(0xffEB5757).withOpacity(0.1)
                          : null,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xffEB5757).withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: photoUrl != null && photoUrl!.isNotEmpty
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: '${dotenv.env['UPLOAD_URL']}/$photoUrl',
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
                                name.isNotEmpty ? name[0].toUpperCase() : '',
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
                    name,
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
                    email,
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
                            "$bookCount",
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
                            "$viewsCount",
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

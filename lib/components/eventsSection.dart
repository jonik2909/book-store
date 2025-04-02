// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Container(
          height: 50,
          color: Color.fromARGB(229, 248, 248, 248),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Events",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),

        // Scrollable Events
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              _buildEventCard(
                context,
                title: "Muallif bilan uchrashuv",
                authorName: "John Smith",
                date: DateTime.now().add(Duration(days: 5)),
                location: "Kitoblar olami, Toshkent",
                imageColor: Colors.blue.shade100,
                icon: Icons.people,
              ),
              _buildEventCard(
                context,
                title: "Yangi kitob taqdimoti",
                authorName: "Sarah Johnson",
                date: DateTime.now().add(Duration(days: 10)),
                location: "Milliy kutubxona, Toshkent",
                imageColor: Colors.amber.shade100,
                icon: Icons.menu_book,
              ),
              _buildEventCard(
                context,
                title: "Kitobxonlar kechasi",
                authorName: "Book Store jamoasi",
                date: DateTime.now().add(Duration(days: 15)),
                location: "Mirzo Ulug'bek bog'i, Toshkent",
                imageColor: Colors.green.shade100,
                icon: Icons.nightlight_round,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required String authorName,
    required DateTime date,
    required String location,
    required Color imageColor,
    required IconData icon,
  }) {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final timeFormat = DateFormat('HH:mm');

    return GestureDetector(
      onTap: () {
        // Handle event tap
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          width: 250,
          margin: EdgeInsets.symmetric(horizontal: 8),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event image banner
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: imageColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 50,
                    color: imageColor
                        .withBlue(imageColor.blue - 40)
                        .withRed(imageColor.red - 40),
                  ),
                ),
              ),

              // Event details
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),

                    // Author/Host
                    Text(
                      authorName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 8),

                    // Date and Time
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.red),
                        SizedBox(width: 4),
                        Text(
                          "${dateFormat.format(date)} | ${timeFormat.format(date)}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),

                    // Location
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.red),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to use in HomePage:
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Your app bar
//       ),
//       body: ListView(
//         children: [
//           // Your other sections
//           SizedBox(height: 30),
//           EventsSection(),
//           SizedBox(height: 30),
//           // More sections
//         ],
//       ),
//     );
//   }
// }
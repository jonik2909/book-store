// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatefulWidget {
  const VideoSection({Key? key}) : super(key: key);

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/assets/videos/video.mp4')
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          // Avtomatik ijro etish
          _controller.play();
          // Ovozni o'chirish
          _controller.setVolume(0);
        });
      });

    // Videoni loop qilish (qayta-qayta ijro etish)
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header qismi
        Container(
          height: 50,
          color: Color.fromARGB(229, 248, 248, 248),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Video",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Watch",
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

        // Video player - boshqaruv elementlarsiz
        Container(
          width: double.infinity,
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: _isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
        ),
      ],
    );
  }
}

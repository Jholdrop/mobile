import 'package:flutter/material.dart';

class BannerProfile extends StatelessWidget {
  const BannerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1555066931-4365d14bab8c",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const Positioned(
          bottom: 10,
          child: CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(
              "https://i.pravatar.cc/300",
            ),
          ),
        ),
      ],
    );
  }
}
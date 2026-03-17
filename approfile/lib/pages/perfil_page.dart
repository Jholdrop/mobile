import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/banner_profile.dart';
import '../widgets/social_row.dart';
import '../widgets/stats_row.dart';
import '../widgets/profile_list.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: const Text(
          "Perfil",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [

          FaIcon(FontAwesomeIcons.instagram, color: Colors.black),
          SizedBox(width: 15),

          FaIcon(FontAwesomeIcons.github, color: Colors.black),
          SizedBox(width: 15),

          FaIcon(FontAwesomeIcons.linkedin, color: Colors.black),
          SizedBox(width: 15),

          Icon(Icons.share, color: Colors.black),
          SizedBox(width: 15),

          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: const [

            SizedBox(height: 20),

            BannerProfile(),

            SizedBox(height: 50),

            Text(
              "Higor Silva",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 5),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Desenvolvedor Flutter, com paixão pela tecnologia",
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 10),

            SocialRow(),

            SizedBox(height: 20),

            StatsRow(),

            SizedBox(height: 20),

            ProfileList(),

            SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "",
          ),
        ],
      ),
    );
  }
}
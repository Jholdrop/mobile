import 'package:flutter/material.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black26),
      ),

      child: const Column(
        children: [

          ListTile(
            leading: Icon(Icons.star_border),
            title: Text("Carreira"),
            trailing: Icon(Icons.keyboard_arrow_down),
          ),

          ListTile(
            leading: Icon(Icons.star_border),
            title: Text("Projetos"),
            trailing: Icon(Icons.keyboard_arrow_down),
          ),

          ListTile(
            leading: Icon(Icons.star_border),
            title: Text("Atividade"),
            trailing: Icon(Icons.keyboard_arrow_down),
          ),

          ListTile(
            leading: Icon(Icons.star_border),
            title: Text("Habilidades"),
            trailing: Icon(Icons.keyboard_arrow_down),
          ),
          
          ListTile(
            leading: Icon(Icons.star_border),
            title: Text("Contato"),
            trailing: Icon(Icons.keyboard_arrow_down),
          ),

        ],
      ),
    );
  }
}
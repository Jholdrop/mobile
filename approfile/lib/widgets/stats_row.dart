import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF5C6BC0),
        borderRadius: BorderRadius.circular(20),
      ),

      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Column(
            children: [
              Text("120",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("Seguidores",
                  style: TextStyle(color: Colors.white)),
            ],
          ),

          Column(
            children: [
              Text("15",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("Projetos",
                  style: TextStyle(color: Colors.white)),
            ],
          ),

          Column(
            children: [
              Text("37",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              Text("Apps",
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
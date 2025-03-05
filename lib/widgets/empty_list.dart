import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 64,
            color: Color.fromARGB(255, 74, 55, 128),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              'Create your first todo item!!',
              style: GoogleFonts.chewy(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 74, 55, 128),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

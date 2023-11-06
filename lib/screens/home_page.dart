import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/screens/add_notes_screen.dart';
import 'package:unicons/unicons.dart';

import 'widgets/notes_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNoteScreen()));
        },
        // splashColor: Colors.red,
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.withOpacity(0.3),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notes",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 30),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(
                        UniconsLine.search,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Expanded(child: NotesWidget())
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/controller/app_controllers.dart';
import 'package:notes/controller/app_database_provider.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/screens/add_notes_screen.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'widgets/notes_widget.dart';

String get noteColor =>
    Colors.primaries[Random().nextInt(Colors.primaries.length - 1)].shade300
        .toString();

int get parsed => int.parse(actualColor);
Color color = Color(parsed);
String get actualColor => noteColor.substring(6, 16);
List<NotesModel> notes = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print(actualColor);
    // print(noteColor);
    bool isVisible = context.watch<AppControllerProvider>().isSearchBarVisible;
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
              child: isVisible
                  ? TextField(
                      cursorColor: Colors.white,
                      onChanged: (input) {
                        context
                            .read<AppDataBaseProvider>()
                            .foundNotes(input, context);
                      },
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            context
                                .read<AppControllerProvider>()
                                .changeSearchBarVisiblity();
                            context.read<AppDataBaseProvider>().getAllNotes();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notes",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 30),
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<AppControllerProvider>()
                                .changeSearchBarVisiblity();
                          },
                          child: Container(
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

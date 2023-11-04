import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/models/notes_model.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descEditingController = TextEditingController();
  final NotesData notes = NotesData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Center(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 17,
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (titleEditingController.text.toString().trim().isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actionsAlignment: MainAxisAlignment.center,
                              elevation: 12,
                              backgroundColor: Colors.grey.withOpacity(0.2),
                              title: Text(
                                "Blank Title",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                ),
                              ),
                              content: Text(
                                "Title is required...",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                ),
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.3)),
                                  child: const Text("Ok"),
                                )
                              ],
                            );
                          });
                    } else {
                      DateTime now = DateTime.now();
                      final formattedDate =
                          DateFormat('MMM, d yyyy').format(now);
                      notes.addNote(NotesModel(
                          id: notes.id,
                          time: formattedDate,
                          title: titleEditingController.text.toString().trim(),
                          desc: descEditingController.text.toString().trim()));
                      notes.id++;
                      Navigator.pop(context);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Save",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleEditingController,
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.withOpacity(0.9), fontSize: 40),
                    cursorColor: Colors.white,
                    // keyboardType: TextInputType.multiline,
                    maxLines: 100,
                    minLines: 1,
                    // maxLength: 50,
                    textAlign: TextAlign.left,
                    // scrollPhysics: NeverScrollableScrollPhysics(),
                    decoration: InputDecoration(
                      hintText: "Title",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 35),
                      hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey.withOpacity(0.9), fontSize: 40),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: descEditingController,
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.withOpacity(0.9), fontSize: 20),
                    cursorColor: Colors.white,
                    // keyboardType: TextInputType.multiline,
                    maxLines: 100,
                    minLines: 1,
                    // maxLength: 50,

                    // scrollPhysics: NeverScrollableScrollPhysics(),
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 35),
                      hintStyle: GoogleFonts.montserrat(
                          color: Colors.grey.withOpacity(0.9), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

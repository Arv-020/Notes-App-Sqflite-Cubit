import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/controller/app_db_cubit.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/screens/home_page.dart';
import 'package:notes/screens/update_screen.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({
    super.key,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late final TextEditingController titleEditingController;

  late final TextEditingController descEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleEditingController = TextEditingController();
    descEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleEditingController.dispose();
    descEditingController.dispose();
  }

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
                      context.read<AppDataBaseProvider>().addNote(NotesModel(
                          noteColor: actualColor,
                          id: 1,
                          time: formattedDate,
                          title: titleEditingController.text.toString().trim(),
                          desc: descEditingController.text.toString().trim()));
                      FocusManager.instance.primaryFocus?.unfocus();
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
                crossAxisAlignment: CrossAxisAlignment.start,
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

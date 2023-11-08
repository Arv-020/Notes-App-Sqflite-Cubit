import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes/controller/app_controllers.dart';
import 'package:notes/controller/app_database_provider.dart';
import 'package:notes/models/notes_model.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

DateTime now = DateTime.now();
final formattedDate = DateFormat('MMM, d yyyy').format(now);

class UpdateNoteScreen extends StatefulWidget {
  const UpdateNoteScreen({
    super.key,
    required this.note,
  });
  final NotesModel note;
  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  late final TextEditingController titleEditingController;

  late final TextEditingController descEditingController;
  late bool isVisible;
  late String date;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleEditingController = TextEditingController();
    descEditingController = TextEditingController();
    titleEditingController.text = widget.note.title;
    descEditingController.text = widget.note.desc;
    date = widget.note.time;
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
    isVisible = context.watch<AppControllerProvider>().isVisible;

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
                      context.read<AppControllerProvider>().setFalse();
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
                isVisible
                    ? InkWell(
                        onTap: () {
                          context.read<AppDataBaseProvider>().updateNote(
                              NotesModel(
                                  noteColor: widget.note.noteColor,
                                  time: formattedDate,
                                  title: titleEditingController.text.toString(),
                                  desc: descEditingController.text.toString(),
                                  id: widget.note.id));
                          context.read<AppControllerProvider>().setFalse();

                          date = formattedDate;
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
                              UniconsLine.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          context.read<AppControllerProvider>().setTrue();
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
                              UniconsLine.edit,
                              color: Colors.white,
                            ),
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
                    enableInteractiveSelection: true,
                    enabled: isVisible,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      // widget.date,
                      date,
                      style: GoogleFonts.mPlus1(
                        fontSize: 16,
                        color: Colors.grey.shade800.withOpacity(1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: descEditingController,
                    enabled: isVisible,
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

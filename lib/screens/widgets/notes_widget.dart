import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/screens/add_notes_screen.dart';
import 'package:notes/screens/update_screen.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as console show log;

class NotesWidget extends StatelessWidget {
  const NotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var notes = context.watch<NotesProvider>().items;
    return notes.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                Lottie.network(
                  "https://lottie.host/9439805d-4618-471c-8943-eda4dd79e0bb/YpGopBbgYL.json",
                  height: 200,
                  frameRate: FrameRate(2),
                ),
                Text(
                  "No Notes!, Add Notes",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: notes
                  .map(
                    (e) => StaggeredGridTile.fit(
                      // axisDirection: AxisDirection.right,
                      crossAxisCellCount: e.title.length > 100 ? 2 : 1,
                      child: Dismissible(
                        key: ValueKey(e.id),
                        dragStartBehavior: DragStartBehavior.start,
                        behavior: HitTestBehavior.deferToChild,
                        direction: DismissDirection.up,
                        // direction: index % 2 == 0
                        //     ? DismissDirection.endToStart
                        //     : DismissDirection.startToEnd,
                        background: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Colors.red.withOpacity(0.3),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        onDismissed: (direction) {
                          context.read<NotesProvider>().removeNote(e);
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateNoteScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: e.noteColor,
                            ),
                            // margin: EdgeInsets.only(
                            //     left: index % 2 == 0 ? 20 : 0,
                            //     right: index % 2 == 1 ? 20 : 0),
                            // height: MediaQuery.sizeOf(context).height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 20, right: 20),
                                  child: Text(
                                    e.title,
                                    style: GoogleFonts.mPlus1(
                                        fontSize:
                                            e.title.length > 100 ? 22 : 18,
                                        fontWeight: e.title.length > 100
                                            ? FontWeight.w700
                                            : FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: e.title.length > 100
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.time,
                                        style: GoogleFonts.mPlus1(
                                          fontSize: 16,
                                          color: Colors.grey.shade800
                                              .withOpacity(1),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ));
  }
}

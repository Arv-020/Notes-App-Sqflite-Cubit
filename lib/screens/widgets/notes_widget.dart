import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/controller/app_db_cubit.dart';
import 'package:notes/controller/app_db_state.dart';
import 'package:notes/screens/update_screen.dart';
import 'package:provider/provider.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllNotes();
  }

  void getAllNotes() async {
    context.read<AppDataBaseProvider>().getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBaseProvider, NotesState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LoadedState) {
        var listNotes = state.notes;
        return listNotes.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Lottie.asset(
                      "assets/animation/no-notes.json",
                      height: 200,
                      frameRate: FrameRate(2),
                    ),
                    Text(
                      "No Notes!, Add Notes",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: listNotes
                        .map(
                          (e) => StaggeredGridTile.fit(
                            // axisDirection: AxisDirection.right,
                            crossAxisCellCount: e.desc.length > 100 ? 2 : 1,
                            child: Dismissible(
                              key: ValueKey(e.id),
                              dragStartBehavior: DragStartBehavior.start,
                              behavior: HitTestBehavior.deferToChild,
                              direction: DismissDirection.horizontal,
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
                                context
                                    .read<AppDataBaseProvider>()
                                    .removeNote(e);
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateNoteScreen(
                                                note: e,
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    color: Color(int.parse(e.noteColor!)),
                                  ),
                                  // margin: EdgeInsets.only(
                                  //     left: index % 2 == 0 ? 20 : 0,
                                  //     right: index % 2 == 1 ? 20 : 0),
                                  // height: MediaQuery.sizeOf(context).height * 0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 20, right: 20),
                                        child: Text(
                                          e.title,
                                          style: GoogleFonts.mPlus1(
                                              fontSize: e.title.length > 100
                                                  ? 22
                                                  : 18,
                                              fontWeight: e.title.length > 100
                                                  ? FontWeight.w700
                                                  : FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          e.desc,
                                          maxLines: 2,
                                          style: GoogleFonts.mPlus1(
                                              fontSize:
                                                  e.desc.length > 100 ? 22 : 18,
                                              fontWeight: e.title.length > 100
                                                  ? FontWeight.w400
                                                  : FontWeight.w300),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              e.title.length > 100
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
                  ),
                ));
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Container(
        color: Colors.red,
      );
    });

    // return notes.isEmpty
    //     ? Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           // mainAxisAlignment: MainAxisAlignment.,
    //           children: [
    //             Lottie.asset(
    //               "assets/animation/no-notes.json",
    //               height: 200,
    //               frameRate: FrameRate(2),
    //             ),
    //             Text(
    //               "No Notes!, Add Notes",
    //               style:
    //                   GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
    //             ),
    //           ],
    //         ),
    //       )
    //     : Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //         child: SingleChildScrollView(
    //           child: StaggeredGrid.count(
    //             crossAxisCount: 2,
    //             crossAxisSpacing: 12,
    //             mainAxisSpacing: 12,
    //             children: notes
    //                 .map(
    //                   (e) => StaggeredGridTile.fit(
    //                     // axisDirection: AxisDirection.right,
    //                     crossAxisCellCount: e.title.length > 100 ? 2 : 1,
    //                     child: Dismissible(
    //                       key: ValueKey(e.id),
    //                       dragStartBehavior: DragStartBehavior.start,
    //                       behavior: HitTestBehavior.deferToChild,
    //                       direction: DismissDirection.horizontal,
    //                       // direction: index % 2 == 0
    //                       //     ? DismissDirection.endToStart
    //                       //     : DismissDirection.startToEnd,
    //                       background: Container(
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(11),
    //                           color: Colors.red.withOpacity(0.3),
    //                         ),
    //                         child: const Icon(
    //                           Icons.delete,
    //                           color: Colors.red,
    //                         ),
    //                       ),
    //                       onDismissed: (direction) {
    //                         context.read<AppDataBaseProvider>().removeNote(e);
    //                       },
    //                       child: InkWell(
    //                         onTap: () {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) => UpdateNoteScreen(
    //                                         note: e,
    //                                       )));
    //                         },
    //                         child: Container(
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(11),
    //                             color: Color(int.parse(e.noteColor!)),
    //                           ),
    //                           // margin: EdgeInsets.only(
    //                           //     left: index % 2 == 0 ? 20 : 0,
    //                           //     right: index % 2 == 1 ? 20 : 0),
    //                           // height: MediaQuery.sizeOf(context).height * 0.3,
    //                           child: Column(
    //                             mainAxisAlignment: MainAxisAlignment.end,
    //                             // mainAxisSize: MainAxisSize.min,
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     top: 20.0, left: 20, right: 20),
    //                                 child: Text(
    //                                   e.title,
    //                                   style: GoogleFonts.mPlus1(
    //                                       fontSize:
    //                                           e.title.length > 100 ? 22 : 18,
    //                                       fontWeight: e.title.length > 100
    //                                           ? FontWeight.w700
    //                                           : FontWeight.w500),
    //                                 ),
    //                               ),
    //                               const SizedBox(
    //                                 height: 8,
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 20, right: 20, bottom: 20),
    //                                 child: Row(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.end,
    //                                   mainAxisAlignment: e.title.length > 100
    //                                       ? MainAxisAlignment.end
    //                                       : MainAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                       e.time,
    //                                       style: GoogleFonts.mPlus1(
    //                                         fontSize: 16,
    //                                         color: Colors.grey.shade800
    //                                             .withOpacity(1),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //                 .toList(),
    //           ),
    //         ));
  }
}

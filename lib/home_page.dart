import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/add_notes_screen.dart';
import 'package:notes/constants/constants.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final NotesData notes = NotesData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()));
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
                // mainAxisSize: MainAxisSize.min,
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
            Expanded(
                child: SingleChildScrollView(
              child: ValueListenableBuilder(
                valueListenable: notes,
                builder: (context, value, child) {
                  return value.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.1,
                            ),
                            Lottie.network(
                              "https://lottie.host/9439805d-4618-471c-8943-eda4dd79e0bb/YpGopBbgYL.json",
                              height: 200,
                              frameRate: FrameRate(2),
                            ),
                            Text(
                              "No Notes!, Add Notes",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            children: value.map((e) {
                              bool isTLength = e.title.length > 100;
                              return StaggeredGridTile.fit(
                                // axisDirection: AxisDirection.right,
                                crossAxisCellCount: isTLength ? 2 : 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    color: Colors
                                        .primaries[Random().nextInt(
                                            Colors.primaries.length - 1)]
                                        .shade300,
                                  ),
                                  // height: MediaQuery.sizeOf(context).height * 0.3,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20.0, left: 20, right: 20),
                                          child: Text(
                                            e.title,
                                            style: GoogleFonts.mPlus1(
                                                fontSize: isTLength ? 22 : 18,
                                                fontWeight: isTLength
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment: isTLength
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
                              );
                            }).toList(),
                          ),
                        );
                },
              ),
            )

                // MasonryGridView.builder(
                //     mainAxisSpacing: 10,
                //     crossAxisSpacing: 10,
                //     itemCount: notes.length,
                //     shrinkWrap: true,
                //     gridDelegate:
                //         SliverSimpleGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //     ),
                //     itemBuilder: (context, index) {
                //       return Container(
                //         padding:
                //             EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                //         margin: EdgeInsets.only(
                //             left: index % 2 == 0 ? 15 : 0,
                //             right: index % 2 == 1 ? 15 : 0),
                //         // height: MediaQuery.sizeOf(context).height * 0.25,
                //         width:
                //             index == 5 ? MediaQuery.sizeOf(context).width : 150,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(11),
                //             color: Colors
                //                 .primaries[Random()
                //                     .nextInt(Colors.primaries.length - 1)]
                //                 .shade400),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               notes[index].title,
                //               style: GoogleFonts.montserrat(
                //                   fontSize: 25, fontWeight: FontWeight.w600),
                //             ),
                //             SizedBox(
                //               height: 11,
                //             ),
                //             Text(
                //               notes[index].time,
                //               style: GoogleFonts.montserrat(
                //                   fontSize: 20,
                //                   color: Colors.blueGrey,
                //                   fontWeight: FontWeight.bold),
                //             )
                //           ],
                //         ),
                //       );
                //     })

                //  GridView.builder(
                //     itemCount: notes.length,
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 2,
                //         crossAxisSpacing: 10,
                //         mainAxisSpacing: 10),
                //     itemBuilder: (context, index) {
                //       return Container(
                //         margin: EdgeInsets.only(
                //             left: index % 2 == 0 ? 10 : 0,
                //             right: index % 2 == 1 ? 10 : 0),
                //         decoration: BoxDecoration(
                //             color: Colors
                //                 .primaries[
                //                     Random().nextInt(Colors.primaries.length - 1)]
                //                 .shade300,
                //             borderRadius: BorderRadius.circular(11)),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           // mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Text(
                //               notes[index].title,
                //               style: GoogleFonts.montserrat(
                //                   fontSize: 20, fontWeight: FontWeight.w500),
                //             ),
                //             Text(
                //               notes[index].time,
                //               style: TextStyle(
                //                 fontSize: 20,
                //                 color: Colors.grey.shade100,
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     }),
                )
          ],
        ),
      ),
    );
  }
}

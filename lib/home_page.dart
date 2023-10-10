import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/constants.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                child: StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: notes
                  .map((e) => StaggeredGridTile.count(
                      crossAxisCellCount: e.id % 3 == 0 ? 2 : 1,
                      mainAxisCellCount: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors
                              .primaries[
                                  Random().nextInt(Colors.primaries.length - 1)]
                              .shade400,
                        ),
                        // height: MediaQuery.sizeOf(context).height * 0.3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: e.id % 3 == 0
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(e.title),
                            SizedBox(
                              height: 11,
                            ),
                            Text(e.time)
                          ],
                        ),
                      )))
                  .toList(),
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

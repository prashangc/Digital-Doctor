import 'package:digitaldoctor/screens/DoctorDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';

class FavouriteDoctors extends StatefulWidget {
  static const routeName = "/favouriteDoctors-screen";
  const FavouriteDoctors({Key? key}) : super(key: key);

  @override
  _FavouriteDoctorsState createState() => _FavouriteDoctorsState();
}

class _FavouriteDoctorsState extends State<FavouriteDoctors> {
  bool _init = true;
  bool _isLoading = false;

  int? i;
  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .addDoctorsToFavourites(i!.toInt());
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final doctorsList = Provider.of<DetailsState>(context).doctorsList;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: doctorsList!.length,
          itemBuilder: (ctx, i) {
            return doctorsList[i].favourite! == true
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      width: 70.0,
                      child: Column(
                        children: [
                          const SizedBox(height: 25.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: ExpansionPanelList.radio(
                              dividerColor: Colors.green,
                              expansionCallback: (panelIndex, isExpanded) {},
                              // elevation: 1.0,
                              animationDuration:
                                  const Duration(milliseconds: 500),
                              children: [
                                ExpansionPanelRadio(
                                  value: Null,
                                  canTapOnHeader: true,
                                  headerBuilder: (context, isExpanded) {
                                    return SizedBox(
                                      height: 80.0,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Hero(
                                              tag: 'image',
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(doctorsList[
                                                                    i]
                                                                .doctorImage ==
                                                            null
                                                        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA75A6F-dujF0c8TTn8ThpgqHIIJfgtTKfCg&usqp=CAU"
                                                        : doctorsList[i]
                                                            .doctorImage
                                                            .toString()),
                                                    alignment: Alignment.center,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5.0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 18.0,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            height: 100.0,
                                            child: Center(
                                              child: Container(
                                                child: Text(
                                                  doctorsList[i]
                                                      .doctorName
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.clip,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  body: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 20, 15),
                                        child: Column(
                                          children: [
                                            Container(
                                                color: Colors.white,
                                                width: double.infinity,
                                                // height: 60,
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      FontAwesomeIcons
                                                          .searchLocation,
                                                      color: Colors.blue,
                                                      size: 15.0,
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    Container(
                                                      color: Colors.white,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                      height: 40.0,
                                                      child: Align(
                                                        alignment:
                                                            const Alignment(
                                                                -1, 0),
                                                        child: Text(
                                                          doctorsList[i]
                                                              .address
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    const Icon(
                                                      FontAwesomeIcons
                                                          .phoneSquareAlt,
                                                      color: Colors.blue,
                                                      size: 18.0,
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    Container(
                                                      color: Colors.white,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                      height: 40.0,
                                                      child: Align(
                                                        alignment:
                                                            const Alignment(
                                                                -1, 0),
                                                        child: Text(
                                                          doctorsList[i]
                                                              .address
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            const SizedBox(height: 18.0),
                                            SizedBox(
                                              width: 150.0,
                                              height: 40.0,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          DoctorDetailScreen
                                                              .routeName,
                                                          arguments:
                                                              doctorsList[i]
                                                                  .id!);
                                                },
                                                child: const Text(
                                                  'MORE',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ExpansionPanelRadio(
                                //   value: Null,
                                //   // isExpanded: _expanded,
                                //   canTapOnHeader: true,
                                //   // backgroundColor: Colors.red,
                                //   headerBuilder: (context, isExpanded) {
                                //     return SizedBox(
                                //       height: 100.0,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Hero(
                                //               tag: 'image',
                                //               child: Container(
                                //                 width: 100.0,
                                //                 decoration: BoxDecoration(
                                //                   image: DecorationImage(
                                //                     fit: BoxFit.fill,
                                //                     // image: AssetImage('assets/xd.jpg'),
                                //                     image: NetworkImage(widget
                                //                         .hospitalsData.hospitalImage
                                //                         .toString()),
                                //                     alignment: Alignment.center,
                                //                   ),
                                //                   borderRadius: const BorderRadius.all(
                                //                     Radius.circular(5.0),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //           const SizedBox(
                                //             width: 18.0,
                                //           ),
                                //           SizedBox(
                                //             width: 160.0,
                                //             height: 100.0,
                                //             child: Center(
                                //               child: Text(
                                //                 widget.hospitalsData.hospitalName
                                //                     .toString(),
                                //                 // APIdata[i].hospitalName.toString(),
                                //                 // '${snapshot.data![index]['hospital_name'].substring(0, 12)}...',
                                //                 // snapshot.data![index]
                                //                 //     ['hospital_name'],
                                //                 textAlign: TextAlign.start,
                                //                 overflow: TextOverflow.clip,
                                //                 style: const TextStyle(
                                //                   color: Colors.black,
                                //                   fontSize: 18,
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     );
                                //   },
                                //   body: Stack(
                                //     clipBehavior: Clip.none,
                                //     children: [
                                //       Padding(
                                //         padding:
                                //             const EdgeInsets.fromLTRB(25, 5, 5, 10),
                                //         child: Column(
                                //           // mainAxisAlignment:
                                //           //     MainAxisAlignment
                                //           //         .spaceBetween,
                                //           children: [
                                //             Text(
                                //               '${widget.hospitalsData.hospitalDetail.toString().substring(0, 200)}...',
                                //               // '${APIdata[i].hospitalDetail.toString().substring(0, 200)}...',
                                //               // '${snapshot.data![index]['hospital_detail'].substring(0, 200)}...',
                                //               style: const TextStyle(fontSize: 18.0),
                                //             ),
                                //             const SizedBox(height: 18.0),
                                //             SizedBox(
                                //               width: 150.0,
                                //               height: 40.0,
                                //               child: ElevatedButton(
                                //                 style: ElevatedButton.styleFrom(
                                //                   primary: Colors.red,
                                //                   padding: const EdgeInsets.all(8.0),
                                //                   shape: RoundedRectangleBorder(
                                //                       borderRadius:
                                //                           BorderRadius.circular(12)),
                                //                 ),
                                //                 onPressed: () {
                                //                   Navigator.of(context).pushNamed(
                                //                       HospitalDetailsScreen.routeName,
                                //                       arguments:
                                //                           widget.hospitalsData.id!);
                                //                 },
                                //                 child: const Text(
                                //                   'MORE',
                                //                   style: TextStyle(
                                //                     fontSize: 20.0,
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container();
          }),
    );
  }
}

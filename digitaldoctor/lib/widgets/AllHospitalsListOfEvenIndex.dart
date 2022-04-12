import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/HospitalsDataModel.dart';
import 'package:flutter/material.dart';

import '../screens/HospitalDetailsScreen.dart';

class AllHospitalsListOfEvenIndex extends StatefulWidget {
  final HospitalDataModel hospitalsData;
  const AllHospitalsListOfEvenIndex(this.hospitalsData);
  @override
  _AllHospitalsListOfEvenIndexState createState() =>
      _AllHospitalsListOfEvenIndexState();
}

class _AllHospitalsListOfEvenIndexState
    extends State<AllHospitalsListOfEvenIndex> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ExpansionPanelList.radio(
              dividerColor: Colors.green,
              expansionCallback: (panelIndex, isExpanded) {},
              // elevation: 1.0,
              animationDuration: const Duration(milliseconds: 500),
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
                                width: MediaQuery.of(context).size.width / 5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child:
                                    widget.hospitalsData.hospitalImage == null
                                        ? Image.asset('assets/hospitalIcon.png')
                                        : Image.network(
                                            widget.hospitalsData.hospitalImage
                                                .toString(),
                                          ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 18.0,
                          ),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 100.0,
                            child: Center(
                              child: Container(
                                child: Text(
                                  widget.hospitalsData.hospitalName.toString(),
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
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                        child: Column(
                          children: [
                            // Container(
                            //   color: Colors.blue,
                            //   width: double.infinity,
                            //   // height: 60,
                            //   child: Text(
                            //     widget.hospitalsData.hospitalDetail.toString(),
                            //     overflow: TextOverflow.clip,
                            //     textAlign: TextAlign.justify,
                            //     style: const TextStyle(fontSize: 16.0),
                            //   ),
                            // ),

                            Container(
                                color: Colors.white,
                                width: double.infinity,
                                // height: 60,
                                child: Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.searchLocation,
                                      color: Colors.blue,
                                      size: 15.0,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Container(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height: 40.0,
                                      child: Align(
                                        alignment: const Alignment(-1, 0),
                                        child: Text(
                                          widget.hospitalsData.address
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    const Icon(
                                      FontAwesomeIcons.phoneSquareAlt,
                                      color: Colors.blue,
                                      size: 18.0,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Container(
                                      color: Colors.white,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height: 40.0,
                                      child: Align(
                                        alignment: const Alignment(-1, 0),
                                        child: Text(
                                          widget.hospitalsData.phone.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
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
                                  padding: const EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      HospitalDetailsScreen.routeName,
                                      arguments: widget.hospitalsData.id!);
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

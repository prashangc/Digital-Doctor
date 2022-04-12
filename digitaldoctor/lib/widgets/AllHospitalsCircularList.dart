import 'package:flutter/material.dart';

import '../model/HospitalsDataModel.dart';
import '../screens/HospitalDetailsScreen.dart';

class AllHospitalsCircularList extends StatefulWidget {
  final HospitalDataModel hospitalsData;
  const AllHospitalsCircularList(this.hospitalsData);

  @override
  _AllHospitalsCircularListState createState() =>
      _AllHospitalsCircularListState(hospitalsData: hospitalsData);
}

class _AllHospitalsCircularListState extends State<AllHospitalsCircularList> {
  final HospitalDataModel hospitalsData;
  _AllHospitalsCircularListState({required this.hospitalsData});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 20.0, 12.0),
        child: SizedBox(
          width: 70.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                      HospitalDetailsScreen.routeName,
                      arguments: widget.hospitalsData.id!);
                },
                child: Hero(
                  tag: 'image',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 38,
                      child: widget.hospitalsData.hospitalImage == null
                          ? Image.asset('assets/hospitalIcon.png')
                          : Image.network(
                              widget.hospitalsData.hospitalImage.toString(),
                            ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        HospitalDetailsScreen.routeName,
                        arguments: widget.hospitalsData.id!);
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.hospitalsData.hospitalName.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      // "${snapshot.data![index]['hospital_name'].substring(0, 6)}...",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

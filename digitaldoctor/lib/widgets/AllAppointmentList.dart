import '../model/AppointmentDataModel.dart';
import 'package:flutter/material.dart';

class AllAppointmentList extends StatefulWidget {
  final AppointmentDataModel appointmentData;
  const AllAppointmentList(this.appointmentData);

  @override
  State<AllAppointmentList> createState() => _AllAppointmentListState();
}

class _AllAppointmentListState extends State<AllAppointmentList> {
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: width,
      height: height / 5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 224, 223, 223),
          )),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Colors.black,
              child: widget.appointmentData.doctorImage == null
                  ? const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/userIcon.png'),
                      backgroundColor: Colors.transparent,
                    )
                  : CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        widget.appointmentData.doctorImage.toString(),
                      ),
                    ),
            ),
            const SizedBox(width: 40.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.appointmentData.doctorName.toString(),
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(widget.appointmentData.appointmentDate.toString()),
              ],
            )
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 248, 248, 248),
                  padding: const EdgeInsets.all(8.0),
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                onPressed: () {},
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 150.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 248, 79, 67),
                  padding: const EdgeInsets.all(8.0),
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                onPressed: () {},
                child: const Text(
                  'SCHEDULE',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

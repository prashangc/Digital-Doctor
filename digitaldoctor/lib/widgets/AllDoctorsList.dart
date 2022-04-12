import '../model/DoctorsDataModel.dart';
import '../screens/DoctorDetailScreen.dart';
import 'package:flutter/material.dart';

class AllDoctorsList extends StatefulWidget {
  final DoctorsDataModel doctorsData;
  final onTap;
  final isSelected;
  const AllDoctorsList(this.doctorsData, this.onTap, this.isSelected);

  @override
  State<AllDoctorsList> createState() => _AllDoctorsListState();
}

class _AllDoctorsListState extends State<AllDoctorsList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: widget.isSelected ? Colors.green : Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black,
              child: widget.doctorsData.doctorImage == null
                  ? const CircleAvatar(
                      radius: 48,
                      backgroundImage: AssetImage('assets/userIcon.png'),
                      backgroundColor: Colors.transparent,
                    )
                  : CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(
                        widget.doctorsData.doctorImage.toString(),
                      ),
                    ),
            ),

            // Image.network(widget.doctorsData.doctorImage.toString()),
            // height: 23,

            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 180.0,
                        child: Text(
                          widget.doctorsData.doctorName.toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          // "${snapshot.data![index]['hospital_name'].substring(0, 6)}...",
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 0,
                          padding: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              DoctorDetailScreen.routeName,
                              arguments: widget.doctorsData.id!);
                        },
                        child: const Text(
                          'View Profile',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    widget.isSelected ? Icons.check_circle : Icons.circle,
                    color: widget.isSelected
                        ? Colors.green
                        : const Color.fromARGB(255, 211, 208, 208),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

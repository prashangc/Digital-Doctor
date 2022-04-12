import 'package:digitaldoctor/screens/DoctorDetailScreen.dart';

import '../screens/SelectDoctorScreen.dart';
import '../state/details_state.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class HospitalDetailsScreen extends StatefulWidget {
  static const routeName = "/hospitalsDetails-screen";
  const HospitalDetailsScreen({Key? key}) : super(key: key);
  // final HospitalsDataModel hospitalsList;
  // const HospitalDetailsScreen(this.hospitalsList);
  @override
  _HospitalDetailsScreenState createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  LocalStorage storages = LocalStorage("usertoken");

  bool isReadMore = false;
  bool isLiked = false;
  bool _init = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAllDoctorsData();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  var size, height, width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final id = ModalRoute.of(context)?.settings.arguments;
    final hospitalData = Provider.of<DetailsState>(context)
        .singleHospitalData(int.parse(id.toString()));
    final doctorsLists = Provider.of<DetailsState>(context).doctorsList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.red,
        title: Text(
          hospitalData!.hospitalName.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: width,
                  height: height / 4.5,
                  color: Colors.red,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 20.0),
                      Hero(
                        tag: 'image',
                        child: Container(
                          width: width / 3,
                          height: height / 3,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: const CircleBorder(
                              side: BorderSide(width: 1, color: Colors.white),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              // image: AssetImage('assets/xd.jpg'),
                              image: NetworkImage(hospitalData.hospitalImage ==
                                      null
                                  ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA75A6F-dujF0c8TTn8ThpgqHIIJfgtTKfCg&usqp=CAU"
                                  : hospitalData.hospitalImage.toString()),
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                const SizedBox(width: 10.0),
                                SizedBox(
                                  width: width / 2.1,
                                  height: 40.0,
                                  child: Align(
                                    alignment: const Alignment(-1, 0),
                                    child: Text(
                                      hospitalData.phone.toString(),
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.mailBulk,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                const SizedBox(width: 10.0),
                                SizedBox(
                                  width: width / 2.1,
                                  height: 40.0,
                                  child: Align(
                                    alignment: const Alignment(-1, 0),
                                    child: Text(
                                      hospitalData.email.toString(),
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.searchLocation,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                const SizedBox(width: 10.0),
                                SizedBox(
                                  width: width / 2.1,
                                  height: 40.0,
                                  child: Align(
                                    alignment: const Alignment(-1, 0),
                                    child: Text(
                                      hospitalData.address.toString(),
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 150.0,
                  right: 20.0,
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.red),
                      ),
                      color: Colors.white,
                    ),
                    child: LikeButton(
                      onTap: (isLiked) async {
                        var token = storages.getItem('token');
                        token == "6b48eb163afe48b9762c983b8ebc5fa037d7f807"
                            ? Fluttertoast.showToast(
                                backgroundColor:
                                    const Color.fromARGB(255, 48, 48, 48),
                                msg: "Register an account",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 20.0,
                              )
                            : Provider.of<DetailsState>(context, listen: false)
                                .addHospitalsToFavourites(hospitalData.id!);
                        return !isLiked;
                      },
                      size: 40.0,
                      circleColor: const CircleColor(
                          start: Color.fromARGB(255, 34, 32, 32),
                          end: Colors.red),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.red,
                        dotSecondaryColor: Colors.red,
                      ),
                      likeBuilder: (bool isliked) {
                        return Icon(
                          hospitalData.favourite!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Text(
                    hospitalData.hospitalDetail.toString(),
                    textAlign: TextAlign.justify,
                    maxLines: isReadMore ? null : 5,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isReadMore = !isReadMore;
                        });
                      },
                      child: isReadMore
                          ? const Icon(Icons.keyboard_arrow_up, size: 25.0)
                          : const Icon(Icons.keyboard_arrow_down, size: 25.0)),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height / 6,
              color: Colors.white,
              child: ListView.builder(
                itemCount: doctorsLists!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            DoctorDetailScreen.routeName,
                            arguments: doctorsLists[index].id!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: width / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromARGB(255, 240, 238, 238)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(
                                  side:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  // image: AssetImage('assets/xd.jpg'),
                                  image: NetworkImage(hospitalData
                                              .hospitalImage ==
                                          null
                                      ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA75A6F-dujF0c8TTn8ThpgqHIIJfgtTKfCg&usqp=CAU"
                                      : doctorsLists[index]
                                          .doctorImage
                                          .toString()),
                                  alignment: Alignment.center,
                                ),
                              ),
                              // child: Image.network(
                              //   doctorsLists[index].doctorImage.toString(),
                              // ),
                            ),
                            // CircleAvatar(
                            //   radius: 40,
                            //   backgroundColor: Colors.black,
                            //   child: CircleAvatar(
                            //     radius: 38,
                            //     child: Image.network(
                            //       doctorsLists[index].doctorImage.toString(),
                            //     ),
                            //   ),
                            // ),

                            const SizedBox(width: 20.0),
                            Column(
                              children: [
                                SizedBox(
                                  width: 140.0,
                                  child: Text(
                                    doctorsLists[index].doctorName.toString(),
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                SizedBox(
                                  width: 140.0,
                                  child: Text(
                                    doctorsLists[index].speciality.toString(),
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width,
              height: 200.0,
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hospitalData.totalDoctors.toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 150.0,
                        child: Text(
                          'Total Doctors Available',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        '50+',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 150.0,
                        child: Text(
                          'Major Operations Available',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0),
                    child: VerticalDivider(
                      color: Colors.black,
                      // height: 10,
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 0,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '150+',
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        child: Text(
                          'Emergency room Available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        child: Text(
                          'International Medical Operations',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelectDoctorScreen()));
          },
          child: const Text(
            'BOOK AN APPOINTMENT',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
      ),
    );
  }
}

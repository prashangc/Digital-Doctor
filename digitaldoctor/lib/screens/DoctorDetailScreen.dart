import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';
import 'SelectDoctorScreen.dart';

class DoctorDetailScreen extends StatefulWidget {
  const DoctorDetailScreen({Key? key}) : super(key: key);
  static const routeName = "/doctorsDetails-screen";

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  LocalStorage storages = LocalStorage("usertoken");

  bool isReadMore = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final id = ModalRoute.of(context)?.settings.arguments;
    final doctorData = Provider.of<DetailsState>(context)
        .singleDoctorData(int.parse(id.toString()));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          doctorData!.doctorName.toString(),
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
                  height: 180.0,
                  color: Colors.green,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 20.0),
                      Hero(
                        tag: 'image',
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: ShapeDecoration(
                            shape: const CircleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              // image: AssetImage('assets/xd.jpg'),
                              image: NetworkImage(doctorData.doctorImage == null
                                  ? "https://www.google.com/search?q=user+account+icon&client=opera-gx&hs=sLu&tbm=isch&sxsrf=APq-WBvbzwD-OYqtXq2Gf_8j7MCRi3lV1A:1647683707812&source=lnms&sa=X&ved=2ahUKEwj4vuyQ9NH2AhUaZ94KHUt_DAoQ_AUoAXoECAEQAw#imgrc=S_FQL4MpQz3ayM"
                                  : doctorData.doctorImage.toString()),
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
                                  width: width / 2.5,
                                  height: 40.0,
                                  child: Align(
                                    alignment: const Alignment(-1, 0),
                                    child: Text(
                                      doctorData.doctorName.toString(),
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
                                  width: width / 2.5,
                                  height: 40.0,
                                  child: Align(
                                    alignment: const Alignment(-1, 0),
                                    child: Text(
                                      doctorData.doctorName.toString(),
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
                                  width: width / 2.5,
                                  height: 40.0,
                                  child: Align(
                                    alignment: const Alignment(-1, 0),
                                    child: Text(
                                      doctorData.address.toString(),
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
                                .addDoctorsToFavourites(doctorData.id!);
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
                          doctorData.favourite!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        );
                      },
                    ),
                    //     Center(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Provider.of<DetailsState>(context, listen: false)
                    //           .addLike(hospitalData.id!);
                    //     },
                    //     child: Icon(
                    //       hospitalData.favourite!
                    //           ? Icons.favorite
                    //           : Icons.favorite_border,
                    //       color: Colors.red,
                    //     ),
                    //   ),
                    // ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            const Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Text(
                    doctorData.speciality.toString(),
                    textAlign: TextAlign.justify,
                    maxLines: isReadMore ? null : 5,
                    style: const TextStyle(
                      fontSize: 20.0,
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
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '19',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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
                      SizedBox(height: 20.0),
                      Text(
                        '50+',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
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

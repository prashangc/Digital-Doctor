import '../screens/HospitalsListScreen.dart';
import '../widgets/app_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens/EnterSymptomsScreen.dart';
import '../state/details_state.dart';
import '../widgets/AllHospitalsCircularList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = "/HomePage-screen";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _init = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getHospitalsDataByProvider();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  int activeIndex = 0;
  DetailsState APIData = DetailsState();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final hospitalLists = Provider.of<DetailsState>(context).hospitalsList;
    // if (_isLoading == false || hospitalLists == null) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(FontAwesomeIcons.solidBell),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30.0,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 10.0),
            Container(
              width: width / 1.5,
              height: height / 9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/digital_doctor.png'),
                  // image: NetworkImage(snapshot.data![index]['hospital_image']),
                  alignment: Alignment.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EnterSymptomsScreen())),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color.fromARGB(255, 223, 220, 220),
                        width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Search by Symptoms",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 189, 188, 188),
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.search,
                        color: Color.fromARGB(255, 189, 188, 188),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 190.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color.fromARGB(255, 223, 220, 220),
                          width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
                          child: Text(
                            'Hospitals',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 0.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: hospitalLists!.length,
                                itemBuilder: (ctx, i) {
                                  return AllHospitalsCircularList(
                                      hospitalLists[i]);
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: width / 7,
                    top: 165.0,
                    child: SizedBox(
                        width: 220.0,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            label: const Text(
                              'VIEW MORE',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HospitalsListScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: FutureBuilder<List>(
                future: APIData.getMedicalNewsImages(),
                builder: (context, snapshot) {
                  // print(snapshot.data);
                  var actualImages = snapshot.data;
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        CarouselSlider.builder(
                          options: CarouselOptions(
                              height: 200.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index;
                                });
                              }),
                          itemCount: actualImages!.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    actualImages[index]['pictures'].toString(),
                                  ),
                                  fit: BoxFit.fill,

                                  // width: double.infinity,
                                  // height: double.infinity,
                                  // fit: BoxFit.fill,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSmoothIndicator(
                              activeIndex: activeIndex,
                              count: snapshot.data!.length,
                              effect: const ExpandingDotsEffect(
                                activeDotColor: Colors.red,
                                dotColor: Color.fromARGB(255, 216, 216, 216),
                                dotWidth: 8.0,
                                dotHeight: 8.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Images found for image slider',
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

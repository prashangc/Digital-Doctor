import 'package:digitaldoctor/widgets/FavouriteDoctors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';
import '../widgets/AllFavHospitalsList.dart';

class Favourite extends StatefulWidget {
  // final HospitalDataModel hospitalsData;
  // const FavouriteHospitals(this.hospitalsData);
  static const routeName = "/favouriteHospitals-screen";
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool _init = true;
  bool _isLoading = false;

  int? i;
  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .addHospitalsToFavourites(i!.toInt());
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final hospitalLists = Provider.of<DetailsState>(context).hospitalsList;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.red,
          title: const Center(
            child: Text(
              'Favourites',
              style: TextStyle(color: Colors.white),
            ),
          ),
          elevation: 0.0,
          // backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 280.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    color: const Color.fromARGB(255, 252, 118, 116),
                  ),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Hospitals',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Doctors',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                      itemCount: hospitalLists!.length,
                      itemBuilder: (ctx, i) {
                        return AllFavHospitalsList(hospitalLists[i]);
                      }),
                  const FavouriteDoctors(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

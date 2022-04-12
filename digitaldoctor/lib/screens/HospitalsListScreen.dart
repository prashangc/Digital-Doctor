import '../BottomNavigations/Favourites.dart';
import '../widgets/AllHospitalsListOfEvenIndex.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/details_state.dart';

class HospitalsListScreen extends StatefulWidget {
  static const routeName = "/hospitalsList-screen";
  const HospitalsListScreen({Key? key}) : super(key: key);

  @override
  _HospitalsListScreenState createState() => _HospitalsListScreenState();
}

class _HospitalsListScreenState extends State<HospitalsListScreen> {
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

  // DetailsState APIData = DetailsState();
  @override
  Widget build(BuildContext context) {
    final hospitalLists = Provider.of<DetailsState>(context).hospitalsList;

    // final hospitalsData =
    //     Provider.of<HospitalsDataModel>(context, listen: false);
    if (_isLoading == false || hospitalLists == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Hospitals',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(Favourite.routeName, arguments: hospitalLists);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.black,
              ),
            ),
          ],
          // backgroundColor: Colors.white,
        ),
        body: ListView.builder(
            itemCount: hospitalLists.length,
            itemBuilder: (ctx, i) {
              return AllHospitalsListOfEvenIndex(hospitalLists[i]);
            }),
      );
    }
  }
}

import '../screens/BookAppointment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';
import '../widgets/AllDoctorsList.dart';

class SelectDoctorScreen extends StatefulWidget {
  const SelectDoctorScreen({Key? key}) : super(key: key);

  @override
  State<SelectDoctorScreen> createState() => _SelectDoctorScreenState();
}

class _SelectDoctorScreenState extends State<SelectDoctorScreen> {
  final List _selectedIndexs = [];

  bool _init = true;
  bool _isLoading = false;

  var size, height, width;

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

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final doctorsLists = Provider.of<DetailsState>(context).doctorsList;
    if (_isLoading == false || doctorsLists == null) {
      return const Scaffold(
        body: Center(
          child: Text("No data found"),
          //  CircularProgressIndicator()
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            "Select Doctor",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(
            itemCount: doctorsLists.length,
            itemBuilder: (ctx, i) {
              final _isSelected = _selectedIndexs.contains(i);
              print(_selectedIndexs);
              return AllDoctorsList(doctorsLists[i], () {
                setState(
                  () {
                    if (_isSelected) {
                      _selectedIndexs.remove(i);
                    } else if (_selectedIndexs.isNotEmpty) {
                      _selectedIndexs.clear();
                      _selectedIndexs.add(i);
                      _selectedIndexs.add(doctorsLists[i].doctorName);
                      _selectedIndexs.add(doctorsLists[i].speciality);
                      _selectedIndexs.add(doctorsLists[i].doctorImage);
                    } else {
                      _selectedIndexs.add(i);
                    }
                  },
                );
              }, _isSelected);
            }),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _selectedIndexs.isNotEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
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
                                  builder: (context) =>
                                      const SelectDoctorScreen()));
                        },
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              _selectedIndexs.isNotEmpty
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                        ),
                        onPressed: () {
                          context.read<DetailsState>().data(_selectedIndexs[1],
                              _selectedIndexs[2], _selectedIndexs[3]);
                          print("objec33333333t");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BookAppointment()));
                        },
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    }
  }
}

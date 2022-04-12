import '../widgets/AllAppointmentList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';

class AllAppointments extends StatefulWidget {
  const AllAppointments({Key? key}) : super(key: key);
  static const routeName = "/Appointments-screen";

  @override
  State<AllAppointments> createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  bool _init = true;
  bool _isLoading = false;

  int? i;
  @override
  void didChangeDependencies() async {
    if (_init) {
      _isLoading = await Provider.of<DetailsState>(context, listen: false)
          .getAppointmentsDataByProvider();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<DetailsState>(context).appointmentList;
    final hospitalLists = Provider.of<DetailsState>(context).hospitalsList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            'Your Appointments ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 0.0,
        // backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: appointments!.length,
          itemBuilder: (ctx, i) {
            return AllAppointmentList(appointments[i]);
          }),
    );
  }
}

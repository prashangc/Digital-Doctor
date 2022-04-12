import '../screens/PaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../state/details_state.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final _form = GlobalKey<FormState>();
  String? formattedDate;
  String? _symptoms;
  String? _query;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDate = DateTime.now();
  // String now = DateFormat();
  DateTime focusedDay = DateTime.now();

  var doctorNameData;
  var doctorImageData;
  var doctorSpecData;
  var imageData;

  String? _user;
  String? _appointmentDate;
  String? _fullName;
  String? _email;
  String? _phone;
  String? _address;

  void _bookAppointment() async {
    var isValid = _form.currentState?.validate();
    var _doctorName = doctorNameData.data;
    var _imageData = imageData;

    if (!isValid!) {
      //if not valid / if empty)
      return;
    }
    _form.currentState?.save();
    bool isBooked = await Provider.of<DetailsState>(context, listen: false)
        .postAppointmentDetails(
            _doctorName.toString(),
            _imageData.toString(),
            formattedDate.toString(),
            _fullName.toString(),
            _email.toString(),
            _phone.toString(),
            _address.toString());

    if (isBooked) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PaymentScreen()));
      // Navigator.of(context).pushReplacementNamed(const HomeScreen().routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Please provide correct credentials.",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var name =
        Provider.of<DetailsState>(context, listen: false).nameData.toString();
    var speciality = Provider.of<DetailsState>(context, listen: false)
        .specialityData
        .toString();
    var image =
        Provider.of<DetailsState>(context, listen: false).imageData.toString();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // drawer: AppDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Schedule Appointment',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                // const SizedBox(height: 13.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 238, 238),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green,
                            image: DecorationImage(
                                image: NetworkImage(imageData = image)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          doctorNameData = Text(name),
                          doctorSpecData = Text(speciality),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 260,
                  child: TableCalendar(
                    shouldFillViewport: true,
                    focusedDay: focusedDay,
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2050),
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekVisible: true,
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDate, date);
                    },
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDate = selectDay;
                        focusedDay = focusDay;
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        formattedDate = formatter.format(selectDay);
                        print(formattedDate);
                      });
                    },
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      formatButtonShowsNext: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    width: double.infinity,
                    // height: 300.0,
                    decoration: const BoxDecoration(
                      // color: Color.fromARGB(255, 250, 249, 249),

                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1.0, vertical: 1.0),
                      child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Enter your full name';
                                }
                                return null;
                              },
                              onSaved: (v) {
                                _fullName = v;
                              },
                              cursorHeight: 22,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                labelText: 'Full name',
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Enter your phone number';
                                }
                                return null;
                              },
                              onSaved: (v) {
                                _phone = v;
                              },
                              cursorHeight: 22,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                labelText: 'Phone',
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Enter your address';
                                }
                                return null;
                              },
                              onSaved: (v) {
                                _address = v;
                              },
                              cursorHeight: 22,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                labelText: 'Address',
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextFormField(
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Enter your email';
                                }
                                return null;
                              },
                              onSaved: (v) {
                                _email = v;
                              },
                              cursorHeight: 22,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                labelText: 'Email',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  onPressed: () {
                    print('dateeeeeeeee: ${selectedDate.toIso8601String()}');
                    print(selectedDate);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             const PaymentScreen()));
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  onPressed: () {
                    _bookAppointment();
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

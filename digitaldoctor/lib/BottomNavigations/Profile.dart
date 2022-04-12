import 'dart:io';

import 'package:digitaldoctor/model/BloodGroupsDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/AllBloodGroupLists.dart';

class Profile extends StatefulWidget {
  final BloodGroups? bloodGroups;
  const Profile({this.bloodGroups});
  static const routeName = "/Profile-screen";

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        Navigator.pop(context);
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("failed $e");
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.red, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final List _selectedIndexs = [];
  final _form = GlobalKey<FormState>();
  String? _fullname;
  String? _email;
  String? _mobile;
  String? _address;

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  String? value;
  List<String> gender = [
    "Male",
    "Female",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.red,
          title: const Center(
            child: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
          elevation: 0.0,
          // backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Stack(children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // Container(
                                  //   child: image == null
                                  //       ? Image.asset('assets/fonepay.png')
                                  //       : Image.file(image!),
                                  // ),
                                  // CircleAvatar(
                                  //   radius: 70.0,
                                  //   backgroundColor: Colors.green,
                                  //   backgroundImage: FileImage(image!),
                                  // ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100.0),
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      color: Colors.green,
                                      child: image == null
                                          ? Image.asset('assets/xd.jpg')
                                          : Image.file(
                                              image!,
                                              height: 140,
                                              width: 140,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  )
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(100.0),
                                  //   child: image == null
                                  //       ? Image.asset('assets/xd.jpg')
                                  //       : Image.file(
                                  //           image!,
                                  //           height: 140,
                                  //           width: 140,
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  // ),
                                  // Container(
                                  //   width: 140.0,
                                  //   height: 140.0,
                                  //   decoration: const BoxDecoration(
                                  //     color: Colors.red,
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: image == null
                                  //       ? Image.asset('assets/xd.jpg')
                                  //       : Image.file(
                                  //           image!,
                                  //           height: 140,
                                  //           width: 140,
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  // ),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 90.0, right: 100.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 25.0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 23.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: ((builder) =>
                                                    bottomSheet()),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              size: 30.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),
                    Container(
                      // padding: const EdgeInsets.only(bottom: 5.0),
                      padding: const EdgeInsets.only(
                          left: 23.0, right: 25.0, top: 12.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              const Text(
                                'Personal Information',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              _status ? _getEditIcon() : Container()
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          const Text(
                            'Full Name',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                            onSaved: (v) {
                              _fullname = v;
                            },
                            cursorHeight: 22,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0.0),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 206, 206, 206),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              labelText: 'Full Name',
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0.0),
                              prefixIcon: Icon(
                                Icons.mail,
                                size: 20,
                                color: Color.fromARGB(255, 206, 206, 206),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              labelText: 'Email',
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Mobile Number',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return 'Enter your Mobile Number';
                              }
                              return null;
                            },
                            onSaved: (v) {
                              _mobile = v;
                            },
                            cursorHeight: 22,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0.0),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color.fromARGB(255, 206, 206, 206),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              labelText: 'Mobile Number',
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Blood Group',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(0.0),
                            height: 50.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final _isSelected =
                                    _selectedIndexs.contains(index);
                                return AllBloodGroupLists(bloodGroups[index],
                                    () {
                                  setState(
                                    () {
                                      if (_isSelected) {
                                        _selectedIndexs.remove(index);
                                      } else if (_selectedIndexs.isNotEmpty) {
                                        _selectedIndexs.clear();
                                        _selectedIndexs.add(index);
                                      } else {
                                        _selectedIndexs.add(index);
                                      }
                                    },
                                  );
                                }, _isSelected);
                              },
                              itemCount: bloodGroups.length,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Address',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0.0),
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Color.fromARGB(255, 206, 206, 206),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              labelText: 'Address',
                            ),
                            enabled: !_status,
                            autofocus: !_status,
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 223, 220, 220),
                                  width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: DropdownButton<String>(
                                  // hint: const Text("Select Gender",
                                  //     style: TextStyle(
                                  //       color: Colors.grey,
                                  //     )),
                                  iconEnabledColor:
                                      const Color.fromARGB(255, 194, 192, 192),
                                  value: value,
                                  elevation: 16,
                                  isExpanded: true,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 194, 192, 192),
                                  ),
                                  items: gender.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    this.value = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Date of Birth',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 223, 220, 220),
                                  width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 194, 192, 192),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          !_status ? _getActionButtons() : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SizedBox(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text("Cancel"),
              onPressed: () {
                setState(() {
                  _status = true;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
            )),
            flex: 2,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: SizedBox(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  _status = true;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
            )),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          const Text(
            "Choose Profile Picture",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ),
              const SizedBox(width: 25.0),
              Expanded(
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("Gallery")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

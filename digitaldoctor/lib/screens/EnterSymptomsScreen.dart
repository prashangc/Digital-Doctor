import 'package:flutter/material.dart';

class EnterSymptomsScreen extends StatefulWidget {
  const EnterSymptomsScreen({Key? key}) : super(key: key);
  static const routeName = "/symptoms-screen";

  @override
  _EnterSymptomsScreenState createState() => _EnterSymptomsScreenState();
}

class _EnterSymptomsScreenState extends State<EnterSymptomsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Symptoms',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,

        // backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
            child: TextFormField(
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Enter symtoms';
                }
                return null;
              },
              onSaved: (v) {
                // _username = v;
              },
              cursorHeight: 22,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                labelText: 'Enter Symptoms',
                labelStyle: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

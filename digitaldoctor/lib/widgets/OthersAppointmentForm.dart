import 'package:flutter/material.dart';

class OthersAppointmentForm extends StatefulWidget {
  const OthersAppointmentForm({Key? key}) : super(key: key);

  @override
  State<OthersAppointmentForm> createState() => _OthersAppointmentFormState();
}

class _OthersAppointmentFormState extends State<OthersAppointmentForm> {
  final _form = GlobalKey<FormState>();
  String? _symptoms;
  String? _query;
  final gender = ['Male', 'Female'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
          child: Container(
            width: double.infinity,
            // height: 500.0
            decoration: const BoxDecoration(
              color: Colors.red,
              // color: Color.fromARGB(255, 250, 249, 249),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
              child: Container(
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter patient name';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _symptoms = v;
                        },
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          labelText: 'Patient Name',
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter the address';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _query = v;
                        },
                        obscureText: true,
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          labelText: 'Person_address',
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: value,
                            isExpanded: true,
                            items: gender.map(buildGenderItem).toList(),
                            onChanged: (value) {
                              setState(() {
                                this.value = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Enter the age';
                          }
                          return null;
                        },
                        onSaved: (v) {
                          _query = v;
                        },
                        obscureText: true,
                        cursorHeight: 22,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          labelText: 'Age',
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100.0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                padding: const EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'NEXT',
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildGenderItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }
}

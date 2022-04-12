import 'package:flutter/material.dart';

class OwnAppointmentForm extends StatefulWidget {
  const OwnAppointmentForm({Key? key}) : super(key: key);

  @override
  State<OwnAppointmentForm> createState() => _OwnAppointmentFormState();
}

class _OwnAppointmentFormState extends State<OwnAppointmentForm> {
  final _form = GlobalKey<FormState>();
  String? _symptoms;
  String? _query;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    const Text(
                      'Current Symptoms',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter your symptoms';
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
                        labelText: 'Nausea, Vomiting',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Patient Query',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 13.0),
                    TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Enter your media query';
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
                        labelText: 'Bone swelling',
                      ),
                    ),
                    const SizedBox(height: 13.0),
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
      ],
    );
  }
}

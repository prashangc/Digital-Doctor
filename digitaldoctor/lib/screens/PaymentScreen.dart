import '../model/PaymentMethods.dart';
import '../widgets/AllPaymentMethods.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/details_state.dart';

class PaymentScreen extends StatefulWidget {
  final PaymentMethods? paymentMethods;
  const PaymentScreen({this.paymentMethods});
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  _initPayment(String product) async {
    ESewaConfiguration _configuration = ESewaConfiguration(
        clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
        secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
        environment: ESewaConfiguration.ENVIRONMENT_TEST);

    ESewaPnp _esewaPnp = ESewaPnp(configuration: _configuration);

    ESewaPayment _payment = ESewaPayment(
        amount: 1000,
        productName: "hello",
        productID: "1",
        callBackURL: "http:example.com");
    try {
      final _res = await _esewaPnp.initPayment(payment: _payment);
      // Handle success
    } on ESewaPaymentException {
      // Handle error
    }
  }

  final List _selectedIndexs = [];
  var size, height, width;
  @override
  Widget build(BuildContext context) {
    var name =
        Provider.of<DetailsState>(context, listen: false).nameData.toString();
    var speciality = Provider.of<DetailsState>(context, listen: false)
        .specialityData
        .toString();
    var image =
        Provider.of<DetailsState>(context, listen: false).imageData.toString();

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: const Text("Payment"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 245, 244, 243),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: 100.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final _isSelected = _selectedIndexs.contains(index);
                    return AllPaymentMethods(paymentMethods[index], () {
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
                  itemCount: paymentMethods.length,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: width,
                height: height / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [boxShadowBlue],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Appointment Summary',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 160,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Selected Hospital: ',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Selected Doctor: ',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Patient Name: ',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Schedule Date: ',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ]),
                        ),
                        Container(
                          width: 160,
                          color: Colors.white,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  name,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  name,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  name,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Note:',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: width,
                      child: const Text(
                        "Please select one of the payment gateway to proceed the appointment booking. For any issues regarding the payment gateways, contact us at support@digitaldoctor.com.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total Payment:',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rs. 1000',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
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
                  _initPayment("product");
                },
                child: const Text(
                  'PAY',
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

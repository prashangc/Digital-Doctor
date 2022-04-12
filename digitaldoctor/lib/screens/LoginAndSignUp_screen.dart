import '../widgets/Doctor_tabView.dart';
import '../widgets/Patient_tabView.dart';
import 'package:flutter/material.dart';

class LoginAndSignUpScreen extends StatelessWidget {
  static const routeName = "/login-screen";
  const LoginAndSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          toolbarHeight: 190.0,
          title: Center(
            child: Container(
              width: 250.0,
              height: 80.0,
              margin: const EdgeInsets.only(left: 20.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/digital_doctor.png'),
                  alignment: Alignment.center,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              // child: Image.network(snapshot
              //     .data![index]['hospital_image']),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: Colors.red[400],
                    ),
                    tabs: const [
                      Tab(
                        child: Text(
                          'PATIENT',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'DOCTOR',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    PatientTabView(),
                    DoctorTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

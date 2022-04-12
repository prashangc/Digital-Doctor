import 'package:digitaldoctor/BottomNavigations/AllAppointments.dart';
import 'package:digitaldoctor/BottomNavigations/Favourites.dart';
import 'package:digitaldoctor/BottomNavigations/HomePage.dart';
import 'package:digitaldoctor/BottomNavigations/Profile.dart';
import 'package:digitaldoctor/BottomNavigations/Settings.dart';
import 'package:digitaldoctor/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'screens/DoctorDetailScreen.dart';
import 'screens/EnterSymptomsScreen.dart';
import 'screens/HospitalDetailsScreen.dart';
import 'screens/HospitalsListScreen.dart';
import 'screens/LoginAndSignUp_screen.dart';
import 'state/details_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage("usertoken");

    return ChangeNotifierProvider(
      create: (ctx) => DetailsState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Digital Doctor',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: storage.ready,
            builder: (context, snapshop) {
              if (snapshop.data == null) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (storage.getItem('token') == null) {
                return const LoginAndSignUpScreen();
              }
              return const HomeScreen();
            }),
        routes: {
          LoginAndSignUpScreen.routeName: (ctx) => const LoginAndSignUpScreen(),
          HospitalsListScreen.routeName: (ctx) => const HospitalsListScreen(),
          HospitalDetailsScreen.routeName: (ctx) =>
              const HospitalDetailsScreen(),
          Favourite.routeName: (ctx) => const Favourite(),
          EnterSymptomsScreen.routeName: (ctx) => const EnterSymptomsScreen(),
          DoctorDetailScreen.routeName: (ctx) => const DoctorDetailScreen(),
          AllAppointments.routeName: (ctx) => const AllAppointments(),
          HomePage.routeName: (ctx) => const HomePage(),
          Settings.routeName: (ctx) => const Settings(),
          Profile.routeName: (ctx) => const Profile(),
        },
      ),
    );
  }
}

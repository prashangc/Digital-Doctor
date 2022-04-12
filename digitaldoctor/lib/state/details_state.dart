import 'dart:convert';

import '../model/AppointmentDataModel.dart';
import '../model/DoctorsDataModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../model/HospitalsDataModel.dart';

class DetailsState with ChangeNotifier {
  LocalStorage local_storage = LocalStorage("usertoken");
  List<HospitalDataModel>? _hospitalsLists;
  List<AppointmentDataModel>? _appointmentsLists;

  List<DoctorsDataModel>? _doctorsLists;
  // String baseUrl = 'http://100.64.199.116:8000/';
  String baseUrl = 'http://192.168.1.88:8000/'; // home  IP
  // String baseUrl = 'http://100.64.255.39:8000/'; //college IP
  // String baseUrl = 'http://10.0.2.2:8000/'; //emulator IP
  // String baseUrl = 'http://192.168.10.86:8000/';

  var nameData, specialityData, imageData;
  // late List<> _favouritesLists;

  Future<bool> loginPatient(String username, String password) async {
    try {
      String url = '${baseUrl}api/login/patient/';
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data.containsKey('token')) {
        // print(data['token']);
        local_storage.setItem('token', data['token']);
        // print(storage.getItem('token'));
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      print("error loginNow patient");
      return true;
    }
  }

  Future<bool> loginDoctor(String username, String password) async {
    try {
      String url = '${baseUrl}api/login/doctor/';
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            'username': username,
            'password': password,
          }));
      var data = json.decode(response.body) as Map;
      // print(data);
      if (data.containsKey('token')) {
        // print(data['token']);
        local_storage.setItem('token', data['token']);
        // print(storage.getItem('token'));
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      print("error loginNow doctor");
      return true;
    }
  }

  Future<bool> guestLogin(String username, String password) async {
    try {
      String url = '${baseUrl}api/login/';
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token 19ec0fe8d589d0b004bff57d3320ecb8f501c832",
          },
          body: json.encode({
            'username': "Guest",
            'password': "password",
          }));
      var data = json.decode(response.body) as Map;
      print(data);
      if (data.containsKey('token')) {
        // print(data['token']);
        local_storage.setItem('token', data['token']);
        // print(storage.getItem('token'));
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      print("error loginNow guest");
      return true;
    }
  }

  Future<bool> registerPatient(String username, String email, String phone,
      String password, String confirmPassword) async {
    try {
      String url = '${baseUrl}api/register/patient/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
          "email": email,
          "phone": phone,
          "password": password,

          // "confirmPassword": confirmPassword,
        }),
      );
      var data = json.decode(response.body) as Map;

      return data['error'];
    } catch (e) {
      print("error register patient");
      print(e);
      return true;
    }
  }

  Future<bool> registerDoctor(String username, String email, String phone,
      String password, String confirmPassword) async {
    try {
      String url = '${baseUrl}api/register/doctor/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
          "email": email,
          "phone": phone,
          "password": password,

          // "confirmPassword": confirmPassword,
        }),
      );
      var data = json.decode(response.body) as Map;

      return data['error'];
    } catch (e) {
      print("error register doctor");
      print(e);
      return true;
    }
  }

  Future<List> getMedicalNewsImages() async {
    try {
      var token = local_storage.getItem('token');
      String url = '${baseUrl}api/images/';
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'token $token'});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error('Server error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> getHospitalsDataByProvider() async {
    try {
      var token = local_storage.getItem('token');
      print('storage: $local_storage');

      print('token: $token');
      // var tokens = '944f875ffdd653872855d3d4e6f8731b1b0b61df';
      String url = '${baseUrl}api/hospitals/';
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
      );
      var data = json.decode(response.body) as List;
      List<HospitalDataModel> temp = [];
      for (var element in data) {
        HospitalDataModel hospitalsDataModel =
            HospitalDataModel.fromJson(element);
        temp.add(hospitalsDataModel);
      }
      _hospitalsLists = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("error getScreenTitleData");
      print(e);
      return false;
    }
  }

  Future<bool> addHospitalsToFavourites(int id) async {
    try {
      var token = local_storage.getItem('token');
      String url = '${baseUrl}api/favourites/hospitals/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          "id": id,
        }),
      );
      print('response of fav hospital: ${response.body}');

      var data = json.decode(response.body);
      if (data['error'] == false) {
        getHospitalsDataByProvider();
      }

      notifyListeners();
      return true;
    } catch (e) {
      print("error in addHospitalsToFavourites method");

      print(e);
      return false;
    }
  }

  Future<bool> addDoctorsToFavourites(int id) async {
    try {
      var token = local_storage.getItem('token');
      String url = '${baseUrl}api/favourites/doctors/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          "id": id,
        }),
      );
      print('response of fav doc: ${response.body}');

      var data = json.decode(response.body);
      if (data['error'] == false) {
        getHospitalsDataByProvider();
      }

      notifyListeners();
      return true;
    } catch (e) {
      print("error in addDoctorsToFavourites method");

      print(e);
      return false;
    }
  }

  Future<bool> getAllDoctorsData() async {
    try {
      var token = local_storage.getItem('token');
      print('storage: $local_storage');

      print('token: $token');
      // var tokens = '944f875ffdd653872855d3d4e6f8731b1b0b61df';
      String url = '${baseUrl}api/doctors/';
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
      );
      var data = json.decode(response.body) as List;
      List<DoctorsDataModel> temp = [];
      for (var element in data) {
        DoctorsDataModel doctorsDataModel = DoctorsDataModel.fromJson(element);
        temp.add(doctorsDataModel);
      }
      _doctorsLists = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("error is in getAllDoctorsData method");
      print(e);
      return false;
    }
  }

  Future<bool> postAppointmentDetails(
    String doctorName,
    String doctorImage,
    String appointmentDate,
    String fullName,
    String email,
    String phone,
    String address,
  ) async {
    try {
      var token = local_storage.getItem('token');
      print('storage: $local_storage');
      String url = '${baseUrl}api/appointments/';
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          // "user": user,
          "doctor_name": doctorName,
          "doctor_image": doctorImage,
          "appointment_date": appointmentDate,
          "full_name": fullName,
          "email": email,
          "phone": phone,
          "address": address
        }),
      );
      print('response of appointment: ${response.body}');
      var data = json.decode(response.body);
      notifyListeners();
      return true;
    } catch (e) {
      print("error in all appointments");
      print(e);
      return false;
    }
  }

  Future<bool> getAppointmentsDataByProvider() async {
    try {
      var token = local_storage.getItem('token');
      print('storage: $local_storage');

      print('token: $token');
      // var tokens = '944f875ffdd653872855d3d4e6f8731b1b0b61df';
      String url = '${baseUrl}api/appointments/';
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
      );
      var data = json.decode(response.body) as List;
      List<AppointmentDataModel> temp = [];
      for (var element in data) {
        AppointmentDataModel appointmentDataModel =
            AppointmentDataModel.fromJson(element);
        temp.add(appointmentDataModel);
      }
      _appointmentsLists = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("error get appointments data");
      print(e);
      return false;
    }
  }

  Future<bool> getAllAppointmentsData() async {
    try {
      var token = local_storage.getItem('token');
      String url = '${baseUrl}api/appointments/';
      http.Response response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'token $token'});
      if (response.statusCode == 200) {
        print("pugoooo iF ma");
        return jsonDecode(response.body);
      } else {
        return Future.error(' error found in appointments data');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  List<HospitalDataModel>? get hospitalsList {
    return [...?_hospitalsLists];
  }

  List<DoctorsDataModel>? get doctorsList {
    return [...?_doctorsLists];
  }

  List<AppointmentDataModel>? get appointmentList {
    return [...?_appointmentsLists];
  }

  HospitalDataModel? singleHospitalData(int id) {
    return _hospitalsLists?.firstWhere((element) => element.id == id);
  }

  DoctorsDataModel? singleDoctorData(int id) {
    return _doctorsLists?.firstWhere((element) => element.id == id);
  }

  AppointmentDataModel? singleAppointmentData(int id) {
    return _appointmentsLists?.firstWhere((element) => element.id == id);
  }

  void data(var name, var speciality, var image) {
    nameData = name;
    specialityData = speciality;
    imageData = image;
    notifyListeners();
  }
}

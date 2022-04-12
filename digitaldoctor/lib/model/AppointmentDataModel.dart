class AppointmentDataModel {
  int? id;
  String? doctorImage;
  String? doctorName;
  String? appointmentDate;
  String? fullName;
  String? email;
  String? phone;
  String? address;

  AppointmentDataModel(
      {this.id,
      this.doctorImage,
      this.doctorName,
      this.appointmentDate,
      this.fullName,
      this.email,
      this.phone,
      this.address});

  AppointmentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorImage = json['doctor_image'];
    doctorName = json['doctor_name'];
    appointmentDate = json['appointment_date'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_image'] = doctorImage;
    data['doctor_name'] = doctorName;
    data['appointment_date'] = appointmentDate;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    return data;
  }
}

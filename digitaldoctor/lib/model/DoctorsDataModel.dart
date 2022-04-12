class DoctorsDataModel {
  int? id;
  int? hospitalId;
  String? doctorName;
  String? doctorImage;
  String? speciality;
  String? address;
  String? doctorDetail;
  bool? favourite;
  int? totalFavourite;

  DoctorsDataModel(
      {this.id,
      this.hospitalId,
      this.doctorName,
      this.doctorImage,
      this.speciality,
      this.address,
      this.doctorDetail,
      this.favourite,
      this.totalFavourite});

  DoctorsDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalId = json['hospital_id'];
    doctorName = json['doctor_name'];
    doctorImage = json['doctor_image'];
    speciality = json['speciality'];
    address = json['address'];
    doctorDetail = json['doctor_detail'];
    favourite = json['favourite'];
    totalFavourite = json['totalFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_id'] = hospitalId;
    data['doctor_name'] = doctorName;
    data['doctor_image'] = doctorImage;
    data['speciality'] = speciality;
    data['address'] = address;
    data['doctor_detail'] = doctorDetail;
    data['favourite'] = favourite;
    data['totalFavourite'] = totalFavourite;
    return data;
  }
}

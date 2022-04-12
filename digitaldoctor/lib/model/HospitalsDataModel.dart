class HospitalDataModel {
  int? id;
  String? hospitalName;
  String? hospitalImage;
  String? address;
  String? hospitalDetail;
  String? email;
  String? phone;
  int? user;
  bool? favourite;
  int? totalFavourite;
  int? totalDoctors;

  HospitalDataModel(
      {this.id,
      this.hospitalName,
      this.hospitalImage,
      this.address,
      this.hospitalDetail,
      this.email,
      this.phone,
      this.user,
      this.favourite,
      this.totalFavourite,
      this.totalDoctors});

  HospitalDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospital_name'];
    hospitalImage = json['hospital_image'];
    address = json['address'];
    hospitalDetail = json['hospital_detail'];
    email = json['email'];
    phone = json['phone'];
    user = json['user'];
    favourite = json['favourite'];
    totalFavourite = json['totalFavourite'];
    totalDoctors = json['totalDoctors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_name'] = hospitalName;
    data['hospital_image'] = hospitalImage;
    data['address'] = address;
    data['hospital_detail'] = hospitalDetail;
    data['email'] = email;
    data['phone'] = phone;
    data['user'] = user;
    data['favourite'] = favourite;
    data['totalFavourite'] = totalFavourite;
    data['totalDoctors'] = totalDoctors;
    return data;
  }
}

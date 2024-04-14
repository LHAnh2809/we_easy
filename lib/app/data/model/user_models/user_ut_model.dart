class UserUTModel {
  ParentStatus? parentStatus;
  int? childStatus;

  UserUTModel({this.parentStatus, this.childStatus});

  UserUTModel.fromJson(Map<String, dynamic> json) {
    parentStatus = json['parentStatus'] != null
        ? new ParentStatus.fromJson(json['parentStatus'])
        : null;
    childStatus = json['childStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parentStatus != null) {
      data['parentStatus'] = this.parentStatus!.toJson();
    }
    data['childStatus'] = this.childStatus;
    return data;
  }
}

class ParentStatus {
  int? viewU;
  String? soTruong;
  String? kinhNghiemLamViec;
  String? companyName;
  String? imageAVT;
  String? nganhNghe;
  int? permission;
  String? gioiTinh;
  String? businessRegistration;
  String? lop;
  String? chuyenNganh;
  String? khoaHoc;
  String? tinhTrangHonNhan;
  String? sinhVienNamMay;
  String? phone;
  String? kyNangThanhThao;
  String? name;
  String? ngaySinh;
  String? imageTheSV;
  String? id;
  String? businessAddress;
  String? email;

  ParentStatus(
      {this.viewU,
      this.soTruong,
      this.kinhNghiemLamViec,
      this.companyName,
      this.imageAVT,
      this.nganhNghe,
      this.permission,
      this.gioiTinh,
      this.businessRegistration,
      this.lop,
      this.chuyenNganh,
      this.khoaHoc,
      this.tinhTrangHonNhan,
      this.sinhVienNamMay,
      this.phone,
      this.kyNangThanhThao,
      this.name,
      this.ngaySinh,
      this.imageTheSV,
      this.id,
      this.businessAddress,
      this.email});

  ParentStatus.fromJson(Map<String, dynamic> json) {
    viewU = json['viewU'];
    soTruong = json['soTruong'];
    kinhNghiemLamViec = json['kinhNghiemLamViec'];
    companyName = json['companyName'];
    imageAVT = json['imageAVT'];
    nganhNghe = json['nganhNghe'];
    permission = json['permission'];
    gioiTinh = json['gioiTinh'];
    businessRegistration = json['businessRegistration'];
    lop = json['lop'];
    chuyenNganh = json['chuyenNganh'];
    khoaHoc = json['khoaHoc'];
    tinhTrangHonNhan = json['tinhTrangHonNhan'];
    sinhVienNamMay = json['sinhVienNamMay'];
    phone = json['phone'];
    kyNangThanhThao = json['kyNangThanhThao'];
    name = json['name'];
    ngaySinh = json['ngaySinh'];
    imageTheSV = json['imageTheSV'];
    id = json['id'];
    businessAddress = json['businessAddress'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewU'] = this.viewU;
    data['soTruong'] = this.soTruong;
    data['kinhNghiemLamViec'] = this.kinhNghiemLamViec;
    data['companyName'] = this.companyName;
    data['imageAVT'] = this.imageAVT;
    data['nganhNghe'] = this.nganhNghe;
    data['permission'] = this.permission;
    data['gioiTinh'] = this.gioiTinh;
    data['businessRegistration'] = this.businessRegistration;
    data['lop'] = this.lop;
    data['chuyenNganh'] = this.chuyenNganh;
    data['khoaHoc'] = this.khoaHoc;
    data['tinhTrangHonNhan'] = this.tinhTrangHonNhan;
    data['sinhVienNamMay'] = this.sinhVienNamMay;
    data['phone'] = this.phone;
    data['kyNangThanhThao'] = this.kyNangThanhThao;
    data['name'] = this.name;
    data['ngaySinh'] = this.ngaySinh;
    data['imageTheSV'] = this.imageTheSV;
    data['id'] = this.id;
    data['businessAddress'] = this.businessAddress;
    data['email'] = this.email;
    return data;
  }
}

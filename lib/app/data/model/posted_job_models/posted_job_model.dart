import 'package:cloud_firestore/cloud_firestore.dart';

class PostedJobModel {
  String? soTruong;
  String? kinhNghiemLamViec;
  String? companyName;
  String? imageAVT;
  int? permission;
  String? gioiTinh;
  String? businessRegistration;
  String? lop;
  String? chuyenNganh;
  String? khoaHoc;
  int? view;
  int? viewU;
  String? tinhTrangHonNhan;
  String? phone;
  String? sinhVienNamMay;
  String? kyNangThanhThao;
  String? name;
  String? ngaySinh;
  String? imageTheSV;
  String? id;
  String? businessAddress;
  String? email;
  Timestamp? date;
  String? yeuCauHoiSo;
  String? ngheNghiep;
  String? title;
  String? chucVu;
  String? hoaHong;
  String? yeuCauCongViec;
  String? mucluong;
  String? hanNop;
  String? moTaCongViec;
  String? hinhThucLamViec;
  String? idCty;
  String? quyenLoiDuocHuong;
  String? bangCap;
  String? thoiGianThuViec;
  String? kinhNghiep;
  String? soLuong;
  String? nameCty;
  String? postId;

  PostedJobModel({
    this.soTruong,
    this.kinhNghiemLamViec,
    this.companyName,
    this.imageAVT,
    this.permission,
    this.gioiTinh,
    this.businessRegistration,
    this.lop,
    this.chuyenNganh,
    this.khoaHoc,
    this.view,
    this.viewU,
    this.tinhTrangHonNhan,
    this.phone,
    this.sinhVienNamMay,
    this.kyNangThanhThao,
    this.name,
    this.ngaySinh,
    this.imageTheSV,
    this.id,
    this.businessAddress,
    this.email,
    this.date,
    this.yeuCauHoiSo,
    this.ngheNghiep,
    this.title,
    this.chucVu,
    this.hoaHong,
    this.yeuCauCongViec,
    this.mucluong,
    this.hanNop,
    this.moTaCongViec,
    this.hinhThucLamViec,
    this.postId,
    this.idCty,
    this.quyenLoiDuocHuong,
    this.bangCap,
    this.thoiGianThuViec,
    this.kinhNghiep,
    this.soLuong,
    this.nameCty,
  });

  PostedJobModel.fromJson(Map<String, dynamic> json) {
    soTruong = json['soTruong'];
    kinhNghiemLamViec = json['kinhNghiemLamViec'];
    companyName = json['companyName'];
    imageAVT = json['imageAVT'];
    permission = json['permission'];
    gioiTinh = json['gioiTinh'];
    businessRegistration = json['businessRegistration'];
    lop = json['lop'];
    chuyenNganh = json['chuyenNganh'];
    khoaHoc = json['khoaHoc'];
    view = json['view'];
    postId = json['postId'];
    viewU = json['viewU'];
    tinhTrangHonNhan = json['tinhTrangHonNhan'];
    phone = json['phone'];
    sinhVienNamMay = json['sinhVienNamMay'];
    kyNangThanhThao = json['kyNangThanhThao'];
    name = json['name'];
    ngaySinh = json['ngaySinh'];
    imageTheSV = json['imageTheSV'];
    id = json['id'];
    businessAddress = json['businessAddress'];
    email = json['email'];
    date = json['date'];
    yeuCauHoiSo = json['yeuCauHoiSo'];
    ngheNghiep = json['ngheNghiep'];
    title = json['title'];
    chucVu = json['chucVu'];
    hoaHong = json['hoaHong'];
    yeuCauCongViec = json['yeuCauCongViec'];
    mucluong = json['mucluong'];
    hanNop = json['hanNop'];
    moTaCongViec = json['moTaCongViec'];
    hinhThucLamViec = json['hinhThucLamViec'];
    idCty = json['idCty'];
    quyenLoiDuocHuong = json['quyenLoiDuocHuong'];
    bangCap = json['bangCap'];
    thoiGianThuViec = json['thoiGianThuViec'];
    kinhNghiep = json['kinhNghiep'];
    soLuong = json['soLuong'];
    nameCty = json['nameCty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soTruong'] = this.soTruong;
    data['kinhNghiemLamViec'] = this.kinhNghiemLamViec;
    data['companyName'] = this.companyName;
    data['imageAVT'] = this.imageAVT;
    data['permission'] = this.permission;
    data['gioiTinh'] = this.gioiTinh;
    data['businessRegistration'] = this.businessRegistration;
    data['lop'] = this.lop;
    data['chuyenNganh'] = this.chuyenNganh;
    data['khoaHoc'] = this.khoaHoc;
    data['view'] = this.view;
    data['viewU'] = this.viewU;
    data['tinhTrangHonNhan'] = this.tinhTrangHonNhan;
    data['phone'] = this.phone;
    data['postId'] = this.postId;
    data['sinhVienNamMay'] = this.sinhVienNamMay;
    data['kyNangThanhThao'] = this.kyNangThanhThao;
    data['name'] = this.name;
    data['ngaySinh'] = this.ngaySinh;
    data['imageTheSV'] = this.imageTheSV;
    data['id'] = this.id;
    data['businessAddress'] = this.businessAddress;
    data['email'] = this.email;
    data['date'] = this.date;
    data['yeuCauHoiSo'] = this.yeuCauHoiSo;
    data['ngheNghiep'] = this.ngheNghiep;
    data['title'] = this.title;
    data['chucVu'] = this.chucVu;
    data['hoaHong'] = this.hoaHong;
    data['yeuCauCongViec'] = this.yeuCauCongViec;
    data['mucluong'] = this.mucluong;
    data['hanNop'] = this.hanNop;
    data['moTaCongViec'] = this.moTaCongViec;
    data['hinhThucLamViec'] = this.hinhThucLamViec;
    data['idCty'] = this.idCty;
    data['quyenLoiDuocHuong'] = this.quyenLoiDuocHuong;
    data['bangCap'] = this.bangCap;
    data['thoiGianThuViec'] = this.thoiGianThuViec;
    data['kinhNghiep'] = this.kinhNghiep;
    data['soLuong'] = this.soLuong;
    data['nameCty'] = this.nameCty;
    return data;
  }
}

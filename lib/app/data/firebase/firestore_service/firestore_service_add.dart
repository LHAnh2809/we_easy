import 'package:cloud_firestore/cloud_firestore.dart';

import '../collection/collection_reference.dart';

class FirestoreServiceAdd {
  Future<void> addMoreBusinesses(
    String? id,
    String? email,
    String? companyName,
    String? businessRegistration,
    String? businessAddress,
    String? phone,
    String? name,
    String? ngaySinh,
    String? gioiTinh,
    String? tinhTrangHonNhan,
    String? lop,
    String? khoaHoc,
    String? sinhVienNamMay,
    String? chuyenNganh,
    String? soTruong,
    String? kinhNghiemLamViec,
    String? kyNangThanhThao,
    String? imageUrl,
    String? nganhNghe,
    int? permission,
  ) async {
    try {
      // Thêm dữ liệu vào Firestore
      await FirestoreCollections.usersCollection.doc(email).set({
        'id': id ?? '',
        'email': email ?? '',
        'companyName': companyName ?? '',
        'businessRegistration': businessRegistration ?? '',
        'businessAddress': businessAddress ?? '',
        'phone': phone ?? '',
        'name': name ?? '',
        'ngaySinh': ngaySinh ?? '',
        'gioiTinh': gioiTinh ?? '',
        'tinhTrangHonNhan': tinhTrangHonNhan ?? '',
        'lop': lop ?? '',
        'khoaHoc': khoaHoc ?? '',
        'sinhVienNamMay': sinhVienNamMay ?? '',
        'chuyenNganh': chuyenNganh ?? '',
        'soTruong': soTruong ?? '',
        'kinhNghiemLamViec': kinhNghiemLamViec ?? '',
        'imageTheSV': imageUrl ?? '',
        'imageAVT': '',
        'kyNangThanhThao': kyNangThanhThao ?? '',
        'nganhNghe': nganhNghe ?? '',
        'permission': permission ?? '',
        'viewU': 0,
      });
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error adding user to Firestore: $e');
      throw e;
    }
  }

  Future<void> addJob(
      String? idCty,
      String? nameCty,
      String? title,
      String? mucluong,
      String? hanNop,
      String? chucVu,
      String? hinhThucLamViec,
      String? soLuong,
      String? hoaHong,
      String? thoiGianThuViec,
      String? kinhNghiep,
      String? bangCap,
      String? gioiTinh,
      String? ngheNghiep,
      String? moTaCongViec,
      String? yeuCauCongViec,
      String? quyenLoiDuocHuong,
      String? yeuCauHoiSo,
      Timestamp? date) async {
    try {
      // Thêm dữ liệu vào Firestore
      await FirestoreCollections.postJobCollection.doc().set({
        'nameCty': nameCty ?? '',
        'idCty': idCty ?? '',
        'title': title ?? '',
        'mucluong': mucluong ?? '',
        'hanNop': hanNop ?? '',
        'chucVu': chucVu ?? '',
        'hinhThucLamViec': hinhThucLamViec ?? '',
        'soLuong': soLuong ?? '',
        'hoaHong': hoaHong ?? '',
        'thoiGianThuViec': thoiGianThuViec ?? '',
        'kinhNghiep': kinhNghiep ?? '',
        'bangCap': bangCap ?? '',
        'gioiTinh': gioiTinh ?? '',
        'ngheNghiep': ngheNghiep ?? '',
        'moTaCongViec': moTaCongViec ?? '',
        'yeuCauCongViec': yeuCauCongViec ?? '',
        'quyenLoiDuocHuong': quyenLoiDuocHuong ?? '',
        'yeuCauHoiSo': yeuCauHoiSo,
        'date': date ?? '',
        'view': 0
      });
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error adding user to Firestore: $e');
      throw e;
    }
  }

  Future<void> addDocument(
      String parentId, Map<String, dynamic> newData, String coll) async {
    try {
      // Thêm một tài liệu mới vào bộ sưu tập "iView" của tài liệu cha có ID là parentId
      await FirestoreCollections.postJobCollection
          .doc(parentId)
          .collection(coll)
          .add(newData);

      print('Tài liệu mới đã được thêm thành công.');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  Future<void> addDocumentV(String parentId, Map<String, dynamic> newData,
      String coll, String email) async {
    try {
      // Thêm một tài liệu mới vào bộ sưu tập "coll" của tài liệu cha có ID là "parentId"
      await FirestoreCollections.postJobCollection
          .doc(parentId)
          .collection(coll)
          .doc(email) // Sử dụng email làm ID cho tài liệu mới
          .set(newData);

      print('Tài liệu mới đã được thêm thành công.');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  Future<void> addDocumentU(String parentId, Map<String, dynamic> newData,
      String coll, String postID) async {
    try {
      // Thêm một tài liệu mới vào bộ sưu tập "iView" của tài liệu cha có ID là parentId
      await FirestoreCollections.usersCollection
          .doc(parentId)
          .collection(coll)
          .doc(postID)
          .set(newData);

      print('Tài liệu mới đã được thêm thành công.');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  Future<void> addDocumentRecruitment(
      String parentId,
      Map<String, dynamic> newData,
      Map<String, dynamic> newDataU,
      String coll,
      String email) async {
    try {
      DocumentReference parentRef =
          FirestoreCollections.postJobCollection.doc(parentId);
      DocumentReference parentReff =
          FirestoreCollections.usersCollection.doc(email);

      // Thêm một tài liệu mới vào bộ sưu tập "coll" của tài liệu cha có ID là "parentId"
      DocumentReference newDocRef = parentRef.collection(coll).doc(email);
      DocumentReference newDocReff = parentReff.collection(coll).doc(parentId);

      // Thêm dữ liệu mới vào tài liệu con
      await newDocRef.set(newData);
      await newDocReff.set(newDataU);

      print('Tài liệu mới đã được thêm thành công.');
    } catch (e) {
      print('Error adding document: $e');
    }
  }
}

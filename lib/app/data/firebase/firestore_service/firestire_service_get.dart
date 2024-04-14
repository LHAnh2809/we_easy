import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../collection/collection_reference.dart';

class FirestoreServiceGet {
  Future<DocumentSnapshot?> getUser(String documentId) async {
    try {
      DocumentSnapshot snapshot = await FirestoreCollections.firestore
          .collection('users')
          .doc(documentId)
          .get();

      return snapshot;
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserJob(
      String documentId, String postID) async {
    try {
      // Lấy dữ liệu từ tài liệu cha
      DocumentSnapshot parentSnapshot = await FirestoreCollections.firestore
          .collection('users')
          .doc(documentId)
          .get();

      // Lấy dữ liệu từ tài liệu con sử dụng ID đã lấy được
      DocumentSnapshot childSnapshot = await FirestoreCollections.firestore
          .collection('users')
          .doc(documentId)
          .collection('recruitment')
          .doc(postID)
          .get();

      // Kiểm tra xem cả tài liệu cha và tài liệu con có tồn tại không
      if (parentSnapshot.exists && childSnapshot.exists) {
        // Trả về dữ liệu từ cả tài liệu cha và tài liệu con
        return {
          'parentData': parentSnapshot.data(),
          'childData': childSnapshot.data(),
        };
      } else {
        if (!parentSnapshot.exists) {
          print('Tài liệu cha không tồn tại.');
        }
        if (!childSnapshot.exists) {
          print('Tài liệu con không tồn tại.');
        }
        return null;
      }
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      return null;
    }
  }

  Future<DocumentSnapshot?> getJob(String Id) async {
    try {
      DocumentSnapshot snapshot =
          await FirestoreCollections.postJobCollection.doc(Id).get();
      return snapshot;
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }

  Future<bool> isNameExist(
      String parentId, String inputName, String coll) async {
    try {
      // Truy vấn tất cả các tài liệu con trong bộ sưu tập "iView" của tài liệu cha có ID là parentId
      QuerySnapshot querySnapshot = await FirestoreCollections.postJobCollection
          .doc(parentId)
          .collection(coll)
          .get();

      // Duyệt qua từng tài liệu con trong querySnapshot
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Lấy giá trị của trường "name" từ tài liệu con
        String name = documentSnapshot['id'];

        // So sánh trường "name" của tài liệu con với trường "name" bạn nhập vào
        if (name == inputName) {
          // Nếu trùng, trả về true (tên đã tồn tại)
          return true;
        }
      }

      // Nếu không có tên nào trùng, trả về false (tên không tồn tại)
      return false;
    } catch (e) {
      print('Error checking name existence: $e');
      // Nếu có lỗi xảy ra, trả về false (tên không tồn tại)
      return false;
    }
  }

  Future<Map<String, dynamic>?> getJobUserU(
      String parentId, String coll, String email) async {
    try {
      QuerySnapshot querySnapshot = await FirestoreCollections.usersCollection
          .doc(parentId)
          .collection(coll)
          .get();

      List<DocumentSnapshot> results = [];

      for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
        String? id = snapshot['id'] as String?;

        if (id != null) {
          // Sử dụng giá trị "id" để lấy một tài liệu cụ thể từ bộ sưu tập
          DocumentSnapshot parentSnapshot =
              await FirestoreCollections.postJobCollection.doc(id).get();

          if (parentSnapshot.exists) {
            // Lấy dữ liệu từ tài liệu con sử dụng ID đã lấy được
            DocumentSnapshot childSnapshot = await FirestoreCollections
                .postJobCollection
                .doc(id)
                .collection(coll)
                .doc(email)
                .get();

            // Kiểm tra xem tài liệu con có tồn tại không
            if (childSnapshot.exists) {
              // Thêm cặp snapshot cha và con vào danh sách kết quả
              results.add(parentSnapshot);
              results.add(childSnapshot);
            } else {
              print('Tài liệu con không tồn tại.');
            }
          } else {
            print('Tài liệu cha không tồn tại.');
          }
        }
      }

      // Trả về danh sách kết quả
      return {'results': results};
    } catch (e) {
      print('Error searching documents: $e');
      return null;
    }
  }

  Future<List<DocumentSnapshot>> getDataUserUT(
      String parentId, String coll) async {
    List<DocumentSnapshot> results = [];

    try {
      // Truy vấn dữ liệu từ collection "coll" của tài liệu cha có ID là "parentId"
      QuerySnapshot querySnapshot = await FirestoreCollections.postJobCollection
          .doc(parentId)
          .collection(coll)
          .get();

      results.addAll(querySnapshot.docs);
    } catch (e) {
      print('Error searching documents: $e');
    }

    return results;
  }

  Future<List<DocumentSnapshot>> searchText(
      String collectionName, String searchText) async {
    List<DocumentSnapshot> results = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      querySnapshot.docs.forEach((doc) {
        // Kiểm tra xem trường 'name' của mỗi tài liệu có chứa chuỗi searchText không
        String docName = doc['name'].toString().toLowerCase();
        String search = searchText.toLowerCase();
        if (docName.contains(search)) {
          results.add(doc);
        }
      });
    } catch (e) {
      print('Error searching documents: $e');
    }

    return results;
  }

  Future<List<CombinedData>> searchTextAll(String searchText) async {
    List<CombinedData> results = [];

    try {
      // Lấy dữ liệu từ collectionName
      QuerySnapshot querySnapshot = await FirestoreCollections.postJobCollection
          .orderBy('date', descending: true)
          .get();

      // Lặp qua từng tài liệu trong postJobSnapshot
      for (QueryDocumentSnapshot postJobDoc in querySnapshot.docs) {
        String ngheNghiep = postJobDoc['ngheNghiep'].toString().toLowerCase();
        // Kiểm tra nếu ngheNghiep chứa searchText
        if (ngheNghiep.contains(searchText.toLowerCase())) {
          String docName = postJobDoc['idCty'].toString().toLowerCase();

          // Truy vấn dữ liệu từ 'usersCollection' với điều kiện 'id' bằng docName
          DocumentSnapshot userSnapshot =
              await FirestoreCollections.usersCollection.doc(docName).get();

          // Tạo một CombinedData object và gán dữ liệu từ cả hai bảng vào đó
          CombinedData combinedData = CombinedData(
            userData: userSnapshot.data() as Map<String, dynamic>,
            postData: postJobDoc.data() as Map<String, dynamic>,
            postId: postJobDoc.id,
          );

          // Thêm CombinedData vào danh sách kết quả
          results.add(combinedData);
        }
      }

      print(results);
      return results;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }

  Future<List<CombinedData>> searchTextAllCty(String id) async {
    List<CombinedData> results = [];

    try {
      // Lấy dữ liệu từ collectionName
      QuerySnapshot querySnapshot = await FirestoreCollections.postJobCollection
          .orderBy('date', descending: true)
          .get();

      // Lặp qua từng tài liệu trong postJobSnapshot
      for (QueryDocumentSnapshot postJobDoc in querySnapshot.docs) {
        String ngheNghiep = postJobDoc['idCty'].toString().toLowerCase();

        // Kiểm tra nếu ngheNghiep chứa searchText
        if (ngheNghiep.contains(id.toLowerCase())) {
          String docName = postJobDoc['idCty'].toString().toLowerCase();

          // Truy vấn dữ liệu từ 'usersCollection' với điều kiện 'id' bằng docName
          DocumentSnapshot userSnapshot =
              await FirestoreCollections.usersCollection.doc(docName).get();

          // Tạo một CombinedData object và gán dữ liệu từ cả hai bảng vào đó
          CombinedData combinedData = CombinedData(
            userData: userSnapshot.data() as Map<String, dynamic>,
            postData: postJobDoc.data() as Map<String, dynamic>,
            postId: postJobDoc.id,
          );

          // Thêm CombinedData vào danh sách kết quả
          results.add(combinedData);
        }
      }

      print(results);
      return results;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }

  Future<List<CombinedData>> getPostedJob() async {
    List<CombinedData> results = [];

    try {
      // Lấy ngày hôm nay
      DateTime now = DateTime.now();
      // Lấy dữ liệu từ Firestore và sắp xếp theo trường 'date' giảm dần
      QuerySnapshot querySnapshot = await FirestoreCollections.postJobCollection
          .orderBy('date', descending: true)
          .get();

      // Lặp qua từng tài liệu trong querySnapshot
      for (QueryDocumentSnapshot postJobDoc in querySnapshot.docs) {
        // Lấy ngày hạn nộp từ tài liệu và chuyển đổi thành kiểu dữ liệu ngày tháng
        DateTime hanNop = DateFormat('dd/MM/yyyy').parse(postJobDoc['hanNop']);

        // Kiểm tra nếu ngày hôm nay nhỏ hơn ngày hạn nộp
        if (now.isBefore(hanNop)) {
          String docName = postJobDoc['idCty'].toString().toLowerCase();

          // Truy vấn dữ liệu từ 'usersCollection' với điều kiện 'id' bằng docName
          DocumentSnapshot userSnapshot =
              await FirestoreCollections.usersCollection.doc(docName).get();

          // Tạo một CombinedData object và gán dữ liệu từ cả hai bảng vào đó
          CombinedData combinedData = CombinedData(
            userData: userSnapshot.data() as Map<String, dynamic>,
            postData: postJobDoc.data() as Map<String, dynamic>,
            postId: postJobDoc.id,
          );

          // Thêm CombinedData vào danh sách kết quả
          results.add(combinedData);
        }
      }
      return results;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }

  Future<List<CombinedData>> getPostedJobExpired() async {
    List<CombinedData> results = [];

    try {
      // Lấy ngày hôm nay
      DateTime now = DateTime.now();
      // Lấy dữ liệu từ Firestore và sắp xếp theo trường 'date' giảm dần
      QuerySnapshot querySnapshot = await FirestoreCollections.postJobCollection
          .orderBy('date', descending: true)
          .get();

      // Lặp qua từng tài liệu trong querySnapshot
      for (QueryDocumentSnapshot postJobDoc in querySnapshot.docs) {
        // Lấy ngày hạn nộp từ tài liệu và chuyển đổi thành kiểu dữ liệu ngày tháng
        DateTime hanNop = DateFormat('dd/MM/yyyy').parse(postJobDoc['hanNop']);

        // Kiểm tra nếu ngày hôm nay nhỏ hơn ngày hạn nộp
        if (now.isAfter(hanNop)) {
          String docName = postJobDoc['idCty'].toString().toLowerCase();

          // Truy vấn dữ liệu từ 'usersCollection' với điều kiện 'id' bằng docName
          DocumentSnapshot userSnapshot =
              await FirestoreCollections.usersCollection.doc(docName).get();

          // Tạo một CombinedData object và gán dữ liệu từ cả hai bảng vào đó
          CombinedData combinedData = CombinedData(
            userData: userSnapshot.data() as Map<String, dynamic>,
            postData: postJobDoc.data() as Map<String, dynamic>,
            postId: postJobDoc.id,
          );

          // Thêm CombinedData vào danh sách kết quả
          results.add(combinedData);
        }
      }

      print(results);
      return results;
    } catch (e) {
      print('Error retrieving documents: $e');
      return [];
    }
  }

  Future<QuerySnapshot<Object?>?> getAllData(String collectionName) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection(collectionName);

      // Lấy dữ liệu từ collection
      QuerySnapshot<Object?> snapshot = await collectionReference.get();

      // Trả về snapshot chứa toàn bộ dữ liệu trong collection
      return snapshot;
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }
}

class CombinedData {
  Map<String, dynamic> userData;
  Map<String, dynamic> postData;
  String postId;

  CombinedData({
    required this.userData,
    required this.postData,
    required this.postId,
  });
}

class UserData {
  Map<String, dynamic> userData;
  String status;

  UserData({
    required this.userData,
    required this.status,
  });
}

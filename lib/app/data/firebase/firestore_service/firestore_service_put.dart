import '../collection/collection_reference.dart';

class FirestoreServicePut {
  Future<void> updateView(String parentId, int newValue) async {
    try {
      // Thực hiện cập nhật giá trị của trường "view" trong tài liệu có ID là documentId
      await FirestoreCollections.postJobCollection
          .doc(parentId)
          .update({'view': newValue});

      print('Giá trị "view" đã được cập nhật thành công.');
    } catch (e) {
      print('Error updating view: $e');
    }
  }
}

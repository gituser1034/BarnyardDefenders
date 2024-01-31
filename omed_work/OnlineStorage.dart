// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FirestoreService {
//   static final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   static Future<void> addOrUpdateStat(String userId, int score) async {
//     await _db.collection('stats').doc(userId).set({
//       'score': score,
//     }, SetOptions(merge: true));
//   }
//
//   static Future<int> getStat(String userId) async {
//     DocumentSnapshot doc = await _db.collection('stats').doc(userId).get();
//     if (doc.exists) {
//       return doc.data()['score'];
//     }
//     return 0;
//   }
//
//   // Method to update or set complex data structures
//   Future<void> addOrUpdateComplexStat(
//       String userId, Map<String, dynamic> data) async {
//     await _db
//         .collection('stats')
//         .doc(userId)
//         .set(data, SetOptions(merge: true));
//   }
//
//   // Batch write example
//   Future<void> batchWriteExample(List<Map<String, dynamic>> data) async {
//     WriteBatch batch = _db.batch();
//     data.forEach((dataMap) {
//       DocumentReference docRef = _db.collection('stats').doc(dataMap['userId']);
//       batch.set(docRef, dataMap);
//     });
//     await batch.commit();
//   }
// }

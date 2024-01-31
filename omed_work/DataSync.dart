// New

// class DataSync {
//   static void syncData(String userId) async {
//     var db = DBHelper.instance;
//
//     // Sync local data to Firebase
//     List<Map<String, dynamic>> localStats = await db.queryAllRows();
//     for (var stat in localStats) {
//       await FirestoreService.addOrUpdateStat(userId, stat['score']);
//     }
//
//     // Optionally, sync Firebase data to local (if needed)
//     int firebaseScore = await FirestoreService.getStat(userId);
//     await db.insert({'score': firebaseScore});
//   }
//
//   // Advanced sync method with error handling and network check
//   static Future<void> advancedSyncData(String userId) async {
//     var db = DBHelper.instance;
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       // Handle offline scenario
//       return;
//     }
//
//     try {
//       // Sync local data to Firebase
//       List<Map<String, dynamic>> localStats = await db.queryAllRows();
//       for (var stat in localStats) {
//         await FirestoreService.addOrUpdateStat(userId, stat['score']);
//       }
//
//       // Sync Firebase data to local
//       int firebaseScore = await FirestoreService.getStat(userId);
//       Map<String, dynamic> localData = await db.queryRow(userId);
//       if (localData == null || localData['score'] != firebaseScore) {
//         await db.insert({'id': userId, 'score': firebaseScore});
//       }
//     } catch (e) {
//       // Handle errors (logging, user notifications, etc.)
//     }
//   }
// }

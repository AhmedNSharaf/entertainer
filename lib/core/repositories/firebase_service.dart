import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:neuss_utils/image_utils/src/super_image_class.dart';
import 'package:neuss_utils/utils/helpers.dart';
import 'package:ready_extensions/ready_extensions.dart';
import 'package:uuid/uuid.dart';

import '../../app/controllers/app_controller.dart';
import '../../app/models/notification_model.dart';
import '../../app/models/user_model.dart';
import '../utils/app_constants.dart';

class FirebaseService extends GetxService {
  static FirebaseService get to => Get.find();

  static AppController appController = AppController.to;

  ///************************************************************************************************
  static const String refUserDoc = 'users';
  static const String refNotifications = 'notifications';

  ///************************************************************************************************
  static FirebaseFirestore storeInstance = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> usersCollection = storeInstance.collection(refUserDoc);

  ///************************************************************************************************
  ///region Current User
  ///************************************************************************************************
  static DocumentReference? get currentUserRef => appController.mAuth.currentUser != null ? usersCollection.doc(appController.mAuth.currentUser!.uid) : null;

  static Future<DocumentSnapshot<Object?>>? get currentUserDoc => currentUserRef?.get();

  static Stream<DocumentSnapshot<Object?>>? get currentUserSnapshots => currentUserRef?.snapshots();

  static Future<bool> deleteMyFirebaseUser() async {
    try {
      if (currentUserRef != null) {
        await currentUserRef!.delete();
        return true;
      }
    } on Exception catch (e) {
      mPrint({'deleteMyUser': ' Exception $e'});
      return false;
    }
    return false;
  }

  static Future<void> updateMyUser(Map<String, dynamic> data) async {
    if (currentUserRef != null) {
      await currentUserRef!.update(data);
    } else {
      mPrintError('currentUserRef not found');
    }
  }

  static Future<void> updateMyFCMToken(String? token) => updateMyUser({UserModelFields.fcm_token: token});

  ///endregion Current User

  ///region Users
  ///************************************************************************************************
  static DocumentReference<Map<String, dynamic>> getUserRef(String id) => usersCollection.doc(id);

  static Query<Map<String, dynamic>> getUserQueryPhoneRef(String phone) => usersCollection.where('phone', isEqualTo: phone);

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserQueryPhone(String phone) => usersCollection.where('phone', isEqualTo: phone).get();

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserQueryFull(UserModel userModel) =>
      usersCollection.where('phone', isEqualTo: userModel.phone).where('password', isEqualTo: userModel.password).get();

  static Query<Map<String, dynamic>> getUserQueryId(String id) => usersCollection.where('id', isEqualTo: id);

  static Future<QuerySnapshot<Map<String, dynamic>>> getUserDoc(String id) => getUserQueryId(id).get();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserSnapshots(String id) => getUserRef(id).snapshots();

  ///endregion Users

  ///region Notifications
  ///************************************************************************************************
  static Query<Map<String, dynamic>> getMyNotificationsRef() => currentUserRef!.collection(refNotifications);

  static Future<QuerySnapshot<Map<String, dynamic>>> getMyNotifications() => getMyNotificationsRef().get();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyNotificationsSnapshots() => getMyNotificationsRef().snapshots();

  static Future<bool> saveNotification(NotificationModel notificationModel, {String? targetUserID}) async {
    if (currentUserRef != null) {
      try {
        DocumentReference<Object?>? ref = (targetUserID == null ? currentUserRef : usersCollection.doc(targetUserID));
        if (ref != null) {
          if (notificationModel.id == null) {
            notificationModel.id = getNextID().trim();
            await ref.collection(refNotifications).doc(notificationModel.id).set(notificationModel.toMap());
          } else {
            await ref.collection(refNotifications).doc(notificationModel.id!).update(notificationModel.toMap());
          }
        } else {
          mPrintError('Target not found');
        }
        return true;
      } on Exception catch (e) {
        mPrintError('Exception $e');
        return false;
      }
    } else {
      mPrintError('currentUserRef not found');

      return false;
    }
  }

  ///endregion Notifications

  ///region functions
  ///************************************************************************************************

  static String getNextID([String prefix = '']) {
    if (!prefix.isNullOrEmptyOrWhiteSpace) prefix += "_";
    return '$prefix${DateTime.now().millisecondsSinceEpoch}_${(const Uuid()).v1().replaceAll('-', '')}';
  }

  static Future<DocumentSnapshot<Object?>?> checkIfDocExists(CollectionReference collection, String docID) async {
    try {
      var doc = await collection.doc(docID).get();
      return (doc.exists ? doc : null);
    } catch (e) {
      mPrintError('Exception $e');
      return null;
    }
  }

  static Future<void> setUserById(id, Map<String, dynamic> data) async {
    try {
      await getUserRef(id).set(data);
    } on Exception catch (e) {
      mPrint(e.toString());
    }
  }

  static Future<void> updateUserById(id, Map<String, dynamic> data) async {
    try {
      await getUserRef(id).update(data);
    } on Exception catch (e) {
      mPrint(e.toString());
    }
  }

  static Future<void> updateUserDoc(DocumentReference userRef, data) async {
    try {
      await userRef.update(data);
    } on Exception catch (e) {
      mPrintError({'updateUserDoc': ' Exception $e'});

      mPrint(e.toString());
    }
  }

  ///************************************************************************************************
  ///endregion functions
}

class FirebaseStorageUploadResult {
  bool success;
  String result;

  FirebaseStorageUploadResult({this.success = true, this.result = ''});
}

class FirebaseStorageHelper {
  static final storage = FirebaseStorage.instance;
  static Future<FirebaseStorageUploadResult?> uploadImage(SuperImageClass imageClass) async {
    Completer<FirebaseStorageUploadResult> uploadCompleter = Completer<FirebaseStorageUploadResult>();
    String? imgUrl;
    String path = '${AppConstants.appUploadCenter}_${const Uuid().v1()}';

    //Select Image
    TaskSnapshot? snapshot;
    if (imageClass.imgList != null) {
      snapshot = await storage.ref().child(path).putData(imageClass.imgList!);
    } else if (imageClass.imgString != null) {
      snapshot = await storage.ref().child(path).putString(imageClass.imgString!, format: PutStringFormat.base64);
    }

    if (snapshot != null) {
      imgUrl = await snapshot.ref.getDownloadURL();
      uploadCompleter.complete(FirebaseStorageUploadResult(result: imgUrl));
    } else {
      mPrint('No Image Path Received');
      uploadCompleter.completeError(FirebaseStorageUploadResult(success: false, result: 'No Image Path Received'));
    }

    return uploadCompleter.future;
  }
}

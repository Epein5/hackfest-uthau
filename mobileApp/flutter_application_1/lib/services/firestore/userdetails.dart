import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/serivces/userstatusservice.dart';
import 'package:flutter_application_1/utils/popupmessages.dart';
import 'package:flutter_application_1/utils/routes/routes.dart';

class UserDetails {
  final _auth = FirebaseAuth.instance;
  // CurrentUserStatus _currentUserStatus = CurrentUserStatus();

  createUserinFirestore(String email) async {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': email, 'blocked': false});
  }

  adduserdetails(BuildContext context, String first, String last,
      String address, String phonenumber, String dob) {
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'first-name': first,
      'last-name': last,
      'address': address,
      'phone-number': phonenumber,
      'dob': dob,
      'profile-video-url': '',
    }, SetOptions(merge: true)).then((value) {
      Navigator.pushReplacementNamed(context, RouteName.onboardingview);
      PopUpMessages.snackBar("Your Profile is ready.", context);
    });
  }

  uploadvideo(BuildContext context, videourl, String name) async {
    final firestore = FirebaseFirestore.instance.collection('users');
    var user = _auth.currentUser;
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref('${user!.email!}Profile$id');
    UploadTask uploadTask = reference.putFile(videourl);

    await Future.value(uploadTask).then((value) async {
      var newUrl = await reference.getDownloadURL();
      firestore.doc(user.uid).set(
          {'profile-video-url': newUrl.toString()}, SetOptions(merge: true));
    }).onError((error, stackTrace) {
      PopUpMessages.flushBarErrorMessage(error.toString(), context);
    });
    // }

    // updatestatus(String value) {
    //   CollectionReference ref = FirebaseFirestore.instance.collection('users');
    //   var user = _auth.currentUser;

    //   ref.doc(user!.uid).set({'status': value}, SetOptions(merge: true));
    // }

    // setBlockStatus(bool value, User user) {
    //   CollectionReference ref = FirebaseFirestore.instance.collection('users');

    //   ref.doc(user.uid).set({'blocked': value}, SetOptions(merge: true));
    // }

    // updateUserRoleto(String value, User user) {
    //   CollectionReference ref = FirebaseFirestore.instance.collection('users');

    //   ref.doc(user.uid).set({'role': value}, SetOptions(merge: true));
    // }

//   Future getUserDetails() async {
//     GetOptions options = await GetOptions(source: Source.serverAndCache);
//     DocumentSnapshot snapshot = await _currentUserStatus.tryfunc(options);

//     Map<String, dynamic> userDetails = {
//       'role': snapshot.get('role'),
//       'email': snapshot.get('email'),
//       'first-name': snapshot.get('first-name'),
//       'last-name': snapshot.get('last-name'),
//       'phone-number': snapshot.get('phone-number'),
//       'address': snapshot.get('address'),
//       'dob': snapshot.get('dob'),
//       'blocked': snapshot.get('blocked'),
//       'about-me': snapshot.get('about-me'),
//       'profile-pic': snapshot.get('profile-pic'),
//     };

//     return userDetails;
//   }
  }
}

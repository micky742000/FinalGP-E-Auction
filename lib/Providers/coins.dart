import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class coins extends ChangeNotifier{
   int Coins  ;

  Future<int> getFromUID() async {
    int totalClasses = await FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      return value.data()['coins']; // Access your after your get the data
    });
    return await  totalClasses;
  }


}
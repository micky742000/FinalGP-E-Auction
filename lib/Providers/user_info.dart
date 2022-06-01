import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class userInfo extends ChangeNotifierProvider {
final String address;
final String firstname;
final String lastname;
final String phonenumber;
userInfo({
  this.address,this.firstname,this.lastname,this.phonenumber
});

factory userInfo.fromJson(Map<String, dynamic> json) {
  return userInfo(
      address: json['address'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phonenumber: json['phonenumber']
  );
}




}
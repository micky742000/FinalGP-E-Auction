import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/Sign_in_up/complete_profile/components/profile_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/productservices.dart';
import '../../../constants/constant.dart';

class UserScreen extends StatefulWidget {
  UserScreen(
      {Key key, this.firstname, this.lastname, this.phonenumber, this.address})
      : super(key: key);
  final String firstname;
  final String lastname;
  final String phonenumber;
  final String address;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          DocumentSnapshot data = snapshot.data.docs[0];
          if (snapshot.hasData == null) return const Text("Check Your Connection");
          if( snapshot.hasError)return const Text("Loading...");
          if( snapshot.data == null)return const Text("Loading...");
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text("Loading...");
            default:
              return  SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(data['profilepic'].toString()),
                    ),
                    SizedBox(
                      height: 20,
                      width: 150,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${data['firstname'].toString().trim()} ${data['lastname'].toString().trim()}',
                      style: headingStyle,
                    ),
                    SizedBox(
                      height: 20,
                      width: 150,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Card(
                        shadowColor: kAccentColor,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          title: Text(
                            '${data['phonenumber'].toString().trim()}',
                            style: headingStyle2,
                          ),
                        )),
                    Card(
                        shadowColor: kAccentColor,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          title: Text(
                            '${FirebaseAuth.instance.currentUser.email}',
                            style: headingStyle2,
                          ),
                        )),
                    Card(
                        shadowColor: kAccentColor,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.black,
                          ),
                          title: Text(
                            '${data['address'].toString().trim()}',
                            style: headingStyle2,
                          ),
                        )),
                  ],
                ),
              );
              
          }
        },
      ),
    );
  }
}

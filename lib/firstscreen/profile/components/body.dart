import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/firstscreen/profile/components/profile_menu.dart';
import 'package:e_auction/Sign_in_up/complete_profile/components/profile_pic.dart';
import 'package:e_auction/firstscreen/profile/components/request_to_sell.dart';
import 'package:e_auction/firstscreen/profile/components/user_screen.dart';
import 'package:e_auction/splashscreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Body extends StatefulWidget {


  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
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
                    return  SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child:               CircleAvatar(
                        radius: 100,
                        backgroundImage:
                        NetworkImage(data['profilepic'].toString()),
                      ),

                    );

                }
              },
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserScreen(),
                  ),
                )
              },
            ),
            ProfileMenu(
              text: "Request To Sell",
              icon: "assets/icons/Plus Icon.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestToSell(),
                  ),
                );

              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Chat bubble Icon.svg",
              press: () {

              },
            ),
            ProfileMenu(
              text: "Privacy and Policies",
              icon: "assets/icons/Question mark.svg",
              press: () {

              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

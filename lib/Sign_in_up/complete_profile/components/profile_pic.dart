import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/Sign_in_up/complete_profile/components/complete_profile_form.dart';
import 'package:e_auction/constants/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Providers/productservices.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File imagess;
  String urls;
  Future<PickedFile> pickImage(context) async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      imagess = File(image.path) ;
    });
    return image;
  }
  Future<String> uploadImage(context) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instanceFor(bucket:'gs://e-auction-b3cec.appspot.com');
      Reference ref = storage.ref().child(imagess.path);
      UploadTask storageUploadTask = ref.putFile(imagess);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      String url = await taskSnapshot.ref.getDownloadURL();
      print('url $url');
      FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser.uid).set(
          {
            'profilepic':url,
            "email":FirebaseAuth.instance.currentUser.email,
            "firstname":null,
            "lastname":null,
            "phonenumber":null,
            "address":null,
            "coins":null,
            'uid':FirebaseAuth.instance.currentUser.uid
          });
      setState(() {
        urls = url;
      });
      return urls;
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }

  void loadImage() async {
    var imageId = await ImageDownloader.downloadImage(urls);
    var path = await ImageDownloader.findPath(imageId);
    File image = File(path);
    setState(() {
      imagess = image;
    });
  }
  @override
  Widget build(BuildContext context) {
    ProductService proServices = Provider.of<ProductService>(context,listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: imagess == null ? null : FileImage(imagess),
              radius: 80,
            ),
            GestureDetector(onTap:() {pickImage(context).whenComplete(() {
              loading(context);
              uploadImage(context).whenComplete(() => Navigator.pop(context));

            });
              }, child: Icon(Icons.camera_alt))
          ],
        ),
      ],
    );
  }
}




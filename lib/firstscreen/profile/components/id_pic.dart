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

class IdPic extends StatefulWidget {
  const IdPic({
    Key key,
  }) : super(key: key);

  @override
  State<IdPic> createState() => _IdPicState();
}

class _IdPicState extends State<IdPic> {
  File imagess;
  String urls;
  Future<PickedFile> pickImage(context) async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
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
      FirebaseFirestore.instance.collection("Requests").doc(FirebaseAuth.instance.currentUser.uid).update(
          {
            'IdPic':url,
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

            GestureDetector(onTap:() {pickImage(context).whenComplete(() {
              loading(context);
              uploadImage(context).whenComplete(() => Navigator.pop(context));
            });
              }, child: ClipRRect(
              child: Container(
                  height: 100,
                  width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.withOpacity(1)),
                ),

                child: imagess == null ? TextButton.icon(icon: Icon(Icons.camera_alt),label: Text("Your International ID"),) : Image(image: FileImage(imagess)),),
              ))
          ],
        ),
      ],
    );
  }
}




import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/constants/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImages extends StatefulWidget {
  const MultiImages({
    Key key,
  }) : super(key: key);

  @override
  State<MultiImages> createState() => _MultiImagesState();
}

class _MultiImagesState extends State<MultiImages> {
  final multiPicker = ImagePicker();
  List<XFile> images = [];
  String urls;
  List<String> impath=[];


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton.icon(
            onPressed: () async {
              //   pickImage(context).whenComplete(() {
              //   loading(context);
              //   uploadImage(context).whenComplete(() => Navigator.pop(context));
              //
              // }
              // );


            },
          label: Text("Insert Product Picture"),
            icon: Icon(Icons.camera_alt),

        ),
        Container(
          height: 150,
          width: 300,
          child: ListView.builder(
scrollDirection: Axis.horizontal,
              itemCount: images.isEmpty ? 9 : images.length,
              itemBuilder: (context,index)=>InkWell(

onTap: (){
  getMultiImages().whenComplete(() {
    loading(context);
    uploadImage(context, index).whenComplete(() => Navigator.pop(context));
  });
},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(1)),
                    ),
                    child:images.isEmpty ? Icon(Icons.camera):Image.file(
                      File(images[index].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ),
        ),
      ],
    );
  }
  Future getMultiImages() async {
    images.clear();
    final List<XFile> selectedImages = await multiPicker.pickMultiImage();
    setState(() {
      if (selectedImages.isNotEmpty) {
        images.addAll(selectedImages);
      } else {
        print('No Images Selected ');
      }
    });
  }
  Future<String> uploadImage(context,int i) async {
    try {
      for(i = 0 ; i<= images.length;i++) {
        FirebaseStorage storage = FirebaseStorage.instanceFor(
            bucket: 'gs://e-auction-b3cec.appspot.com');
        Reference ref = storage.ref(
            "Requests/${FirebaseAuth.instance.currentUser.uid}/${images[i].name}");
        UploadTask storageUploadTask = ref.putFile(File(images[i].path));
        TaskSnapshot taskSnapshot = await storageUploadTask;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('success'),
        ));
        String url = await taskSnapshot.ref.getDownloadURL();
        impath.add(url);
        print('url $url');
        FirebaseFirestore.instance.collection("Requests").doc(FirebaseAuth.instance.currentUser.uid).set(
            {
              'MultiImages':impath,
              "IdPic":null,
              "email": FirebaseAuth.instance.currentUser.email,
              'uid': FirebaseAuth.instance.currentUser.uid,
              "productname": null,
              "MinBid": null,
              "Location": null,
              "Category": null,
              "Date": null,
              "description":null,
            });
        setState(() {
          urls = url;
        });
      }
      return urls;
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
String getImageName(XFile image){
    return image.path.split("/").last;
}
}

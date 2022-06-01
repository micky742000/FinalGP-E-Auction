import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/constants/default_button.dart';
import 'package:e_auction/firstscreen/profile/components/id_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/constant.dart';
import '../../../constants/custom_surfix_icon.dart';
import '../../../constants/size_config.dart';
import 'multi_images.dart';

class RequestToSell extends StatefulWidget {
  @override
  State<RequestToSell> createState() => _RequestToSellState();
}

class _RequestToSellState extends State<RequestToSell> {
  TextEditingController dateinput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String productname;
  String MinBid;
  String Location;
  String Category;
  String Date;
  String description;
  String kNamelNullError = "";

  @override
  Widget build(BuildContext context) {
    dateinput.text = '';
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Request to Sell", style: headingStyle),
                const Text(
                  "Your Request May Take  \n24 Hour in Review",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                MultiImages(),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                IdPic(),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                TextFormField(
                  onSaved: (newValue) => productname = newValue,
                  onChanged: (value) {
                    productname = value;
                    if (value.isNotEmpty) {
                      removeError(error: kNamelNullError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kNamelNullError);
                      return kNamelNullError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: 'Product Name',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: CustomSurffixIcon(svgIcon:"assets/icons/Cart Icon.svg"),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                TextFormField(
                  onSaved: (newValue) => MinBid = newValue,
                  onChanged: (value) {
                    MinBid = value;
                    if (value.isNotEmpty) {
                      removeError(error: kNamelNullError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kNamelNullError);
                      return kNamelNullError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Minimum Price',
                    hintText: 'Minimum Price',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: CustomSurffixIcon(svgIcon:"assets/icons/Cart Icon.svg"),
                  ),
                ),
                const Text(
                  "*You Must Have 25% Coins of Entered Price",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                TextFormField(
                  onSaved: (newValue) => Location = newValue,
                  onChanged: (value) {
                    Location = value;
                    if (value.isNotEmpty) {
                      removeError(error: kNamelNullError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kNamelNullError);
                      return kNamelNullError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Location',
                    hintText: 'Ex :- Alex, Egypt',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: CustomSurffixIcon(svgIcon:"assets/icons/Cart Icon.svg"),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                TextFormField(
                  onSaved: (newValue) => Category = newValue,
                  onChanged: (value) {
                    Category = value;
                    if (value.isNotEmpty) {
                      removeError(error: kNamelNullError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kNamelNullError);
                      return kNamelNullError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Category',
                    hintText: 'Ex :- Cars',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: CustomSurffixIcon(svgIcon:"assets/icons/Cart Icon.svg"),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: null,
                  onSaved: (newValue) => description = newValue,
                  onChanged: (value) {
                    description = value;
                    if (value.isNotEmpty) {
                      removeError(error: kNamelNullError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kNamelNullError);
                      return kNamelNullError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Description", //label text of field
                    hintText: "Description"
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                TextFormField(
                  controller: dateinput, //editing controller of this TextField
                  onSaved: (newValue) => Date = newValue,
                  onChanged: (value) {
                    value = Date ;
                    if (Date.isNotEmpty) {
                      removeError(error: kNamelNullError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (Date == null) {
                      addError(error: kNamelNullError);
                      return kNamelNullError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Enter Date", //label text of field
                    hintText: Date,
                  ),
                  readOnly: true, //set it true, so that user will not able to edit text

                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime
                            .now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      Date = formattedDate;
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                DefaultButton(
                  text: "Submit Request",
                  press: ()async{
                    if (_formKey.currentState.validate()) {
                      await FirebaseFirestore.instance.collection("Requests").doc(FirebaseAuth.instance.currentUser.uid).update({
                        "productname": productname,
                        "MinBid": MinBid,
                        "Location": Location,
                        "Category": Category,
                        "Date": Date,
                      "description":description,

                      });
                    }
                  },
                ),

              ],
            ),
          ),
        ),
      )),
    );
  }

  void addError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  TextFormField buildProductNameFormField(
      String Name, String Hint, String Icon, String Value) {
    return TextFormField(
      onSaved: (newValue) => Value = newValue,
      onChanged: (value) {
        Value = value;
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return kNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: Name,
        hintText: Hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: Icon),
      ),
    );
  }
}

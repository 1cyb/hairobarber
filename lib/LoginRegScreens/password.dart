import 'package:hairobarber/main.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../intro.dart';

class PasswordScreen extends StatefulWidget {
  final String phone;
  final String uid;
  PasswordScreen(this.phone, this.uid);
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<PasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _phoneController.text = (widget.phone);
    var gendController = "";
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  'User Info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.deepOrangeAccent.shade700),
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, left: 30.0, top: 40.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orangeAccent),
                  cursorColor: Colors.orangeAccent,
                  keyboardType: TextInputType.text,
                  controller: _phoneController,
                  enabled: false,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrangeAccent.shade100),
                      )),
                )),
            Padding(
                padding:
                    const EdgeInsets.only(right: 30.0, left: 30.0, top: 40.0),
                child: GenderPickerWithImage(
                  onChanged: (Gender? gender) {
                    gendController = gender.toString().substring(7);
                  },
                  showOtherGender: false,
                  verticalAlignedText: false,
                  selectedGender: Gender.Male,
                  selectedGenderTextStyle: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold),
                  unSelectedGenderTextStyle: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.normal),
                  equallyAligned: true,
                  animationDuration: Duration(milliseconds: 300),
                  isCircular: true,
                  opacityOfGradient: 0.4,
                  padding: const EdgeInsets.all(3),
                  size: 50,
                )),
            Padding(
              padding:
                  const EdgeInsets.only(right: 30.0, left: 30.0, top: 40.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.orangeAccent,
                keyboardType: TextInputType.text,
                controller: _nameController,
                maxLength: 15,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.face_outlined,
                      color: Colors.deepOrangeAccent.shade100,
                    ),
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrangeAccent.shade100),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0, left: 30.0, top: 30.0, bottom: 40),
              child: TextField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.orangeAccent,
                keyboardType: TextInputType.text,
                controller: _passwordController,
                obscureText: true,
                maxLength: 15,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key_outlined,
                      color: Colors.deepOrangeAccent.shade100,
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white38),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepOrangeAccent.shade100),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, right: 100.0, left: 100.0),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                onPressed: () {
                  if (_nameController.text.length <= 4) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Name should be minimum 4 characters')));
                    return;
                  }
                  if (_passwordController.text.length <= 4) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Password should be minimum 4 characters')));
                  }
                  Map userDetails = {
                    "uid": widget.uid,
                    "mobile": widget.phone,
                    "password": _passwordController.text,
                    "name": _nameController.text,
                    "gender": gendController,
                  };
                  dbRef
                      .child(widget.phone)
                      .set(userDetails)
                      .then((value) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('uid', widget.uid);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Intro(userDetails)),
                        (route) => false);
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${error.toString()}')));
                  });
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}

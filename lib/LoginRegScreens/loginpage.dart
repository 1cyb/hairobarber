import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hairobarber/main.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import 'registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Container(
                  margin: EdgeInsets.only(top: 40),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.deepOrangeAccent.shade700),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, right: 10, left: 10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.orangeAccent,
                  decoration: InputDecoration(
                      prefixIcon: Text(
                        " +213 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrangeAccent.shade100,
                            fontSize: 14),
                      ),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 0, minHeight: 0),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.white38),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orangeAccent)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrangeAccent.shade100),
                      )),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 40, right: 10, left: 10, bottom: 40),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.orangeAccent,
                  keyboardType: TextInputType.text,
                  controller: _passwordcontroller,
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
            ]),
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
                  dbRef
                      .reference()
                      .orderByChild("mobile")
                      .equalTo(_controller.text)
                      .get()
                      .then((value) {
                    if (value.value == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No User Found')));
                      return;
                    }

                    print("User Password ${value.value}");
                    Map data = value.value;
                    var isFound = false;
                    data.forEach((key, value) async {
                      if (_passwordcontroller.text == value['password'] &&
                          (_controller.text == value['mobile'])) {
                        isFound = true;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('uid', key);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(value)),
                            (route) => false);
                      }
                    });
                    if (isFound == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'Incorrect username or password !',
                        style: TextStyle(color: Colors.red.shade600),
                        textAlign: TextAlign.center,
                      )));
                    }
                  });
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registartion()),
                  );
                },
                child: Text(
                  'Don\'t have an account ? - Signup',
                  style: TextStyle(color: Colors.deepOrangeAccent.shade100),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var uid = prefs.getString('uid');
      if (uid != null) {
        dbRef.child(uid).once().then((DataSnapshot snapshot) {
          Map<dynamic, dynamic> userValues = snapshot.value;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home(userValues)),
              (route) => false);
        });
      }
    });
  }
}

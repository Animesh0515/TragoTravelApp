import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trago/API/apiservices.dart';
import 'package:trago/login.dart';

import 'Models/SignupModel.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  bool validEmail = true;
  bool validPassword = true;
  bool validName = true;
  late String emailtext;
  bool visibletxt = true;
  late String passwordtext;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: Text(
                'Signup',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
              child: Text(
                '.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            )
          ],
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    errorText: validEmail ? null : emailtext,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                    labelText: 'PASSWORD ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    errorText: validPassword ? null : passwordtext,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibletxt = !visibletxt;
                          });
                        },
                        icon: Icon(visibletxt
                            ? Icons.visibility_off
                            : Icons.visibility))),
                obscureText: visibletxt,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                    labelText: 'FULL NAME ',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    errorText: validName ? null : "Please enter your name",
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(height: 50.0),
              GestureDetector(
                  onTap: () {
                    validEmail = validateEmail(emailcontroller.text);
                    validPassword = validatePassword(passwordcontroller.text);
                    validName = validtext(namecontroller.text);
                    if (validEmail && validPassword && validName) {
                      SingupRequestModel requestModel = new SingupRequestModel(
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                          name: namecontroller.text);
                      API api = new API();
                      api.Signup(requestModel).then((value) {
                        if (value!.statusCode == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('User already exists'),
                          ));
                        } else if (value.statusCode == 1) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('User created successfully'),
                          ));
                          emailcontroller.text = "";
                          passwordcontroller.text = "";
                          namecontroller.text = "";
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Something went wrong!'),
                          ));
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 60.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.lightGreen,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 30.0),
              Container(
                height: 60.0,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Center(
                      child: Text('Go Back',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ])));
  }

  bool validtext(String userInput) {
    if (userInput.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool validateEmail(String userInput) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (userInput.isEmpty) {
      setState(() {
        emailtext = "Please Enter the Email!";
      });
      return false;
    } else {
      if (regExp.hasMatch(userInput)) {
        return true;
      } else {
        setState(() {
          emailtext = "Incorrect Email format!";
        });
        return false;
      }
    }
  }

  bool validatePassword(String userInput) {
    String pattern = r'^([\w]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    if (userInput.isEmpty) {
      setState(() {
        passwordtext = "Please Enter the password!";
      });
      return false;
    } else {
      if (regExp.hasMatch(userInput)) {
        return true;
      } else {
        setState(() {
          passwordtext = "Password must be 7 character long!";
        });
        return false;
      }
    }
  }
}

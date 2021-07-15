import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trago/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  bool validemail = true;
  bool validpassword = true;
  bool visibletxt = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.only(left: 220, top: 30),
                //   child: CircleAvatar(
                //     radius: 70,
                //     backgroundImage: AssetImage('assets/logo.jpg'),
                //     backgroundColor: Colors.blue,
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    "Trago",
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 30,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 140.0, 0.0, 0.0),
                  child: Text(
                    'Login',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(220.0, 150.0, 0.0, 0.0),
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
                        errorText: validemail ? null : "Please enter Email.",
                        prefixIcon: Icon(
                          FontAwesomeIcons.user,
                          size: 20,
                        ), // hintText: 'EMAIL',
                        // hintStyle: ,
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
                          color: Colors.grey,
                        ),
                        errorText:
                            validpassword ? null : "Please enter the Password",
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          // color: Colors.black,
                          size: 20,
                        ),
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
                  SizedBox(height: 50.0),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          validemail = validtext(emailcontroller.text);
                          validpassword = validtext(passwordcontroller.text);
                        });
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
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 30.0),
                  Text('or'),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Center(
                          child: Text('Signup',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          // SizedBox(height: 15.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text(
          //       'New to Spotify?',
          //       style: TextStyle(
          //         fontFamily: 'Montserrat',
          //       ),
          //     ),
          //     SizedBox(width: 5.0),
          //     InkWell(
          //       child: Text('Register',
          //           style: TextStyle(
          //               color: Colors.green,
          //               fontFamily: 'Montserrat',
          //               fontWeight: FontWeight.bold,
          //               decoration: TextDecoration.underline)),
          //     )
          //   ],
          // )
        ])));
  }

  bool validtext(String userInput) {
    if (userInput.isEmpty) {
      // setState(() {
      //   validText = false;
      // });
      return false;
    } else {
      return true;
    }
  }
}

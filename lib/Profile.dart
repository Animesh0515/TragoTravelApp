import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trago/packages.dart';
import 'package:trago/signup.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 2;
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Row(
          children: <Widget>[
            navbarItems(Icons.home, 0),
            navbarItems(Icons.map_rounded, 1),
            navbarItems(Icons.person, 2),
          ],
        ),
        appBar: new AppBar(
          backgroundColor: Colors.greenAccent,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 40,
              // ),
              Icon(
                FontAwesomeIcons.user,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(children: [
              circularProfile(),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    labelText: 'NAME',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    labelText: 'EMAIL',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    labelText: 'OLD PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    labelText: 'NEW PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 100,
                    // ),
                    if (edit)
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              edit = false;
                            });
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.red,
                              fixedSize: Size(120, 50),
                              // minimumSize: Size(100, 10),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))),
                    SizedBox(
                      width: 10,
                    ),
                    edit
                        ? OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              "Save",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            // ),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                fixedSize: Size(120, 50),
                                // minimumSize: Size(100, 10),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))))
                        : Padding(
                            padding: const EdgeInsets.only(left: 120.0),
                            child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    edit = true;
                                  });
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                // ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    fixedSize: Size(120, 50),
                                    // minimumSize: Size(100, 10),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))))),
                          ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Widget navbarItems(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          if (index == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PackagesPage()));
          } else if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignupPage()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 3.0, color: Colors.grey),
            bottom: BorderSide(
                width: 5.0,
                color:
                    index == selectedIndex ? Colors.greenAccent : Colors.white),
          ),
        ),
        child: Icon(
          icon,
          size: 30,
          color: index == selectedIndex
              ? Colors.greenAccent
              : Colors.greenAccent.shade100,
        ),
      ),
    );
  }

  Widget circularProfile() {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: CircleAvatar(
          radius: 70.0,
          backgroundImage: AssetImage("assets/profile.jpg"),
        ),
      ),
      Positioned(
        bottom: 20.0,
        right: 20.0,
        child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (builder) => bottomSheet());
            },
            child: Icon(Icons.camera_alt, color: Colors.blue, size: 28.0)),
      )
    ]);
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Icon(Icons.camera),
                Text("Camera"),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Column(
              children: [
                Icon(Icons.image),
                Text("Gallery"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

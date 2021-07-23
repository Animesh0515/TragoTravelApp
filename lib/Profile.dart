import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_utilities/flutter_image_utilities.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trago/API/apiservices.dart';
import 'package:trago/packages.dart';
import 'package:trago/signup.dart';

import 'Models/UserModel.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 2;
  bool edit = false;
  API api = new API();
  late UserModelResponseModel user;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController oldpasswordController = new TextEditingController();
  TextEditingController newpasswordController = new TextEditingController();
  String image = "";
  String password = "";
  bool loading = true;
  final ImagePicker _picker = ImagePicker();
  bool validName = true;
  bool validEmail = true;
  String passwordtext = "";
  String oldPasswordtext = "";
  bool validOldps = true;
  bool validNewps = true;
  String emailtext = "";
  late int response;
  late UserUpdateRequest userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api.getUserData().then((value) {
      setState(() {
        nameController.text = value!.name;
        emailController.text = value.email;
        password = value.password;
        image = value.image;
        loading = false;
      });
    });
  }

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
        body: loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(children: [
                    circularProfile(image),
                    TextField(
                      enabled: edit,
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          errorText:
                              validName ? null : "Please enter full name",
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      enabled: edit,
                      controller: emailController,
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
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: edit,
                      controller: oldpasswordController,
                      decoration: InputDecoration(
                          labelText: 'OLD PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          errorText: validOldps ? null : oldPasswordtext,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      enabled: edit,
                      controller: newpasswordController,
                      decoration: InputDecoration(
                          labelText: 'NEW PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          errorText: validNewps ? null : passwordtext,
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
                                  api.getUserData().then((value) {
                                    setState(() {
                                      nameController.text = value!.name;
                                      emailController.text = value.email;
                                      password = value.password;
                                      image = value.image;
                                      loading = false;
                                    });
                                  });
                                  setState(() {
                                    edit = false;
                                  });
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    fixedSize: Size(120, 50),
                                    // minimumSize: Size(100, 10),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))))),
                          SizedBox(
                            width: 10,
                          ),
                          edit
                              ? OutlinedButton(
                                  onPressed: () {
                                    validName = validtext(nameController.text);
                                    validEmail =
                                        validateEmail(emailController.text);
                                    if (validName && validEmail) {
                                      if (oldpasswordController.text != "" ||
                                          newpasswordController.text != "") {
                                        validOldps = validtext(
                                            oldpasswordController.text);
                                        validNewps = validatePassword(
                                            newpasswordController.text, 1);
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.greenAccent,
                                      fixedSize: Size(120, 50),
                                      // minimumSize: Size(100, 10),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))))
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

  Widget circularProfile(String image) {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: CircleAvatar(
          radius: 70.0,
          backgroundImage: AssetImage(image),
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
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            child: Column(
              children: [
                Icon(Icons.camera),
                Text("Camera"),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              takePhoto(ImageSource.gallery);
            },
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

  void takePhoto(ImageSource imageSource) async {
    //final pickedFile = await imagePicker.getImage(source: imageSource);
    // ignore: deprecated_member_use
    final XFile? pickedImage = await _picker.pickImage(source: imageSource);
    // final File image = (awai t ImagePicker.pickImage(source: imageSource)) as File;

    File imgFile = File(pickedImage!.path);
    print(imgFile);

    // final String path = "F:/Punar/trago/assets/DP";
    // imgFile = await imgFile.copy('$path/' + 'abc.jpg');

    final imageProperties =
        await FlutterImageUtilities.getImageProperties(imgFile);
    final jpegFile = await FlutterImageUtilities.saveAsJpeg(
        sourceFile: File(imgFile.path),
        destinationFilePath: "F:/Punar/trago/assets/DP/file1.jpg",
        quality: 60,
        maxWidth: 1920,
        maxHeight: 1080,
        canScaleUp: false);
    // final File newImage =    await imgFile.copy('F:/Punar/trago/assets/DP/filename.jpg');
    //  var fileName = basename(file.path);

    // final Directory path = await getApplicationDocumentsDirectory();
    // print(path);

    // if (image != null) {
    //   String imageData = base64Encode(image.readAsBytesSync());
    //   print(imageData);
    //   Gallery.image = imageData;
    //   apiService.updatedProfileImage(imageData).then((value) {
    //     setState(() {
    //       if (!value) {
    //         imagecontroller.text = null;
    //         final snackBar = SnackBar(content: Text("Error saving image!"));
    //         // ignore: deprecated_member_use
    //         Scaffold.of(context).showSnackBar(snackBar);
    //       } else {
    //         imagecontroller.text = imageData;
    //       }
    //     });
    //   });
    // }
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

  bool validatePassword(String userInput, int numbering) {
    String pattern = r'^([\w]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    if (userInput.isEmpty) {
      setState(() {
        if (numbering == 0) {
          oldPasswordtext = "Please Enter the old password";
        } else {
          passwordtext = "Please Enter the password!";
        }
      });
      return false;
    } else {
      if (regExp.hasMatch(userInput)) {
        return true;
      } else {
        setState(() {
          if (numbering == 0) {
            oldPasswordtext = "Password must be 7 character long!";
          } else {
            passwordtext = "Password must be 7 character long!";
          }
        });
        return false;
      }
    }
  }
}

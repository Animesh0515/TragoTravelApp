import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:trago/API/apiservices.dart';
import 'package:trago/Models/HotelModel.dart';

class Hotel extends StatefulWidget {
  const Hotel({Key? key}) : super(key: key);

  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  API api = new API();
  List<dynamic> lst = [];
  DateTime _date = DateTime.now();
  TextEditingController _datecontroller = new TextEditingController();
  TextEditingController fullnamecontroller = new TextEditingController();
  TextEditingController contactnumbercontroller = new TextEditingController();

  bool validFullName = true;
  bool validDate = true;
  bool validContactNumber = true;
  String errorTxt = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api.getHotels().then((value) {
      setState(() {
        lst = value!;
      });
    });
  }

  _selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: _date,
      lastDate: DateTime(3000),
    );
    if (date != null && date != _date) {
      setState(() {
        _selectDate(context);
        _datecontroller.text = new DateFormat("yyyy-MM-dd").format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.greenAccent,
        title: Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Icon(
              FontAwesomeIcons.home,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Hotel Booking",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                height: 50,
                width: 375,
                child: TextField(
                    // controller: fromcontroller,
                    decoration: InputDecoration(
                      labelText: 'Search by name or location',
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: const BorderSide(color: Colors.grey)),
                      // errorText: validFrom
                      //     ? null
                      //     : 'Please enter the destination'),
                      prefixIcon:
                          //  Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          Icon(
                        FontAwesomeIcons.search,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (val) {
                      api.searchHotels(val).then((value) {
                        setState(() {
                          lst = value!;
                        });
                      });
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                physics:
                    NeverScrollableScrollPhysics(), // <-- this will disable scroll
                shrinkWrap: true,
                itemCount: lst.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: 200,
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: 500,
                              // color: Colors.red,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Stack(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        // color: Colors.blue,
                                        height: 100,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  lst[index]["Image"]),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        // color: Colors.green,
                                        height: 185,
                                        width: 230,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              lst[index]["Name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(lst[index]["Type"]),
                                                SizedBox(width: 90),
                                                Text("Room: " +
                                                    lst[index]["RoomType"] +
                                                    ""),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.users,
                                                  size: 18,
                                                  color:
                                                      Colors.greenAccent[200],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(lst[index]["MaxPerson"]
                                                    .toString())
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Contact No:" +
                                                lst[index]["ContactNo"]
                                                    .toString() +
                                                ""),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("Includes " +
                                                lst[index]["Facility"]),
                                            // Text("Duration:50 min"),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(children: [
                                              Container(
                                                child: Wrap(
                                                  spacing: 15,
                                                  children: [
                                                    OutlinedButton(
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (builder) =>
                                                                bottomsheet(
                                                                    lst[index][
                                                                        "HotelDetailID"],
                                                                    lst[index][
                                                                        "Price"]));
                                                      },
                                                      child: Text("Book Now"),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              fixedSize: Size(
                                                                  120, 10)),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15.0),
                                                      child: Text(
                                                        "Rs." +
                                                            lst[index]["Price"]
                                                                .toString(),
                                                        //
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ))
                                  ],
                                ),
                              ]),
                            ))
                      ]));
                })
          ],
        ),
      ),
    );
  }

  Widget bottomsheet(int hotelDetailId, int total) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Column(
            children: <Widget>[
              Text(
                "Booking",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.black,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Guest Full Name:"),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: TextField(
                      controller: fullnamecontroller,
                      decoration: InputDecoration(
                          labelText: "FullName",
                          errorText: validFullName ? null : "Enter full name",
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Check in Date:"),
                  SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    width: 120,
                    height: 35,
                    child: TextFormField(
                        onTap: () {
                          setState(() {
                            _selectDate(context);
                          });
                        },
                        controller: _datecontroller,
                        decoration: InputDecoration(
                          hintText: "Date",
                          errorText: validDate ? null : "Enter date",
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: const BorderSide(color: Colors.grey)),
                          // errorText: validateTextField
                          //     ? 'Please enter ' + "Date"
                          //     : null
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text("Contact Number:"),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: TextField(
                      controller: contactnumbercontroller,
                      decoration: InputDecoration(
                          labelText: "Contact No",
                          errorText: validContactNumber ? null : errorTxt,
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 260.0),
                child: Row(
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 2),
                    Text(
                      total.toString(),
                      // total.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    )
                  ],
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      validFullName = validtext(fullnamecontroller.text);
                      validDate = validtext(_datecontroller.text);
                      validContactNumber =
                          validContactNo(contactnumbercontroller.text);
                    });
                    if (validFullName && validDate && validContactNumber) {
                      HotelBooking hotelBooking = new HotelBooking(
                          hotelDetailID: hotelDetailId,
                          guestName: fullnamecontroller.text,
                          contactNumber: contactnumbercontroller.text,
                          checkInDate: _datecontroller.text);
                      _sendToKhalti(context, hotelBooking, total);
                    }
                  },
                  child: Text("Procced"))
            ],
          ),
        ),
      ));
    });
  }

  _sendToKhalti(BuildContext context, HotelBooking requestModel, int total) {
    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_02da791dba7241e591b286a94ef8302c",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
    );

    KhaltiProduct product = KhaltiProduct(
      id: "test",
      amount: total * 100,
      name: "Flight booking",
    );

    _flutterKhalti.startPayment(
        product: product,
        onSuccess: (data) {
          api.bookHotel(requestModel)!.then((value) {
            if (value == true) {
              {
                _datecontroller.text = "";
                fullnamecontroller.text = "";
                contactnumbercontroller.text = "";
              }
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Booking Successful'),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Something went wrong!'),
              ));
            }
          });
          print("Success message here");
        },
        onFaliure: (error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something went wrong while transaction!')));
          print("Error message here");
        });
  }

  bool validtext(String userInput) {
    if (userInput.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool validContactNo(String userInput) {
    String pattern = r'^([0-9]){10}$';
    RegExp regExp = new RegExp(pattern);
    if (userInput.isEmpty) {
      setState(() {
        errorTxt = "Enter contact no";
      });
      return false;
    } else {
      if (regExp.hasMatch(userInput)) {
        return true;
      } else {
        errorTxt = "Enter valid number";
        return false;
      }
    }
  }
}

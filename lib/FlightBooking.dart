import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:trago/API/apiservices.dart';
import 'package:trago/login.dart';
import 'package:trago/packages.dart';
import 'package:trago/signup.dart';
import 'package:flutter/cupertino.dart';

import 'Models/FlightModel.dart';

class FlightBooking extends StatefulWidget {
  const FlightBooking({Key? key}) : super(key: key);

  @override
  _FlightBookingState createState() => _FlightBookingState();
}

class _FlightBookingState extends State<FlightBooking> {
  bool validFrom = true;
  bool validTo = true;
  DateTime _date = DateTime.now();
  String person = "Select";
  String gender = "Gender";
  String nationality = "Nationality";
  TextEditingController fromcontroller = new TextEditingController();
  TextEditingController tocontroller = new TextEditingController();
  TextEditingController _datecontroller = new TextEditingController();
  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController contactnocontroller = new TextEditingController();
  TextEditingController passportnumbercontroller = new TextEditingController();

  API api = new API();
  List<dynamic> lst = [];
  bool data = false;
  bool validDate = true;
  bool validContactNO = true;
  bool validPassportNo = true;
  double total = 0;

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
                FontAwesomeIcons.plane,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Flight Booking",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Select Your Destination",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Container(
                      height: 50,
                      width: 150,
                      child: TextField(
                        controller: fromcontroller,
                        decoration: InputDecoration(
                            labelText: 'From',
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            errorText: validFrom
                                ? null
                                : 'Please enter the destination'),
                      ),
                    ),
                    // SizedBox(
                    //   width: 60,
                    // ),

                    Container(
                      height: 50,
                      width: 150,
                      child: TextField(
                        controller: tocontroller,
                        decoration: InputDecoration(
                            labelText: 'To',
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            errorText: validTo
                                ? null
                                : 'Please enter the destination'),
                      ),
                    ),
                    // SizedBox(
                    //   width: 30,
                    // ),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        // border: Border.all(color: Colors.white)
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            validFrom = validtext(fromcontroller.text);
                            validTo = validtext(tocontroller.text);
                          });

                          if (validFrom && validTo) {
                            SearchFlightData flightdata = new SearchFlightData(
                                from: fromcontroller.text,
                                to: tocontroller.text);
                            api.getFlightDetails(flightdata).then((value) {
                              setState(() {
                                lst = value!;
                                data = true;
                              });
                              print(lst.length);
                            });
                          }
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => LoginPage(),
                          //     ));
                        },
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (lst != [])
                ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // <-- this will disable scroll
                    shrinkWrap: true,
                    itemCount: lst.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           PackageDetails(index: index),
                          //     ));
                        },
                        child: Container(
                          height: 150,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
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
                                                  image: AssetImage(lst[index]
                                                      ["AirlineImage"]),
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
                                                  lst[index]["AirlineName"],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text("From: " +
                                                        lst[index]["From"] +
                                                        ""),
                                                    SizedBox(width: 30),
                                                    Text("To:" +
                                                        lst[index]["To"] +
                                                        ""),
                                                  ],
                                                ),
                                                Text("Departure: " +
                                                    lst[index]
                                                        ["DepartureTime"] +
                                                    ""),
                                                Text("Arrival:" +
                                                    lst[index]["ArrivalTime"] +
                                                    ""),
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
                                                                context:
                                                                    context,
                                                                builder: (builder) => bottomsheet(
                                                                    lst[index][
                                                                        "AirlineCode"],
                                                                    lst[index][
                                                                        "FlightDetailsID"],
                                                                    lst[index][
                                                                        "Cost"]));
                                                          },
                                                          child:
                                                              Text("Book Now"),
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  fixedSize:
                                                                      Size(120,
                                                                          10)),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 15.0),
                                                          child: Text(
                                                            "Rs. " +
                                                                lst[index]
                                                                        ["Cost"]
                                                                    .toString() +
                                                                "",
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
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
            ],
          ),
        ));
  }

  Widget bottomsheet(int flightNo, int fligthDetailID, double cost) {
    total = cost;
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Flight No:"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(flightNo.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text("Date:"),
                      SizedBox(
                        width: 35,
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
                              // labelText: new DateFormat("yyyy-MM-dd")
                              //     .format(_date),
                              hintText: "Date",
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              // errorText: validateTextField
                              //     ? 'Please enter ' + "Date"
                              //     : null
                            )),
                      ),
                      SizedBox(width: 20),
                      Text("Person:"),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        //color: Colors.blue,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton(
                            focusColor: Colors.grey,
                            hint: Text(person),
                            items: <String>[
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8'
                            ]
                                .map((String val) => DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  total = cost * int.parse(value.toString());
                                  person = value.toString();
                                },
                              );
                            }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      Text("Address:"),
                      SizedBox(width: 30),
                      SizedBox(
                        width: 280,
                        height: 45,
                        child: TextField(
                          controller: addresscontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text("Contact No:"),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 280,
                        height: 45,
                        child: TextField(
                          controller: contactnocontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                              errorText: validContactNO
                                  ? null
                                  : "Enter valid contact number"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text("Passport Number:"),
                          SizedBox(
                            width: 2,
                          ),
                          SizedBox(
                            width: 260,
                            height: 45,
                            child: TextField(
                              controller: passportnumbercontroller,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                  errorText: validPassportNo
                                      ? null
                                      : "Enter valid passport number"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text("Nationality"),
                          SizedBox(
                            width: 50,
                          ),
                          Container(
                            height: 30,
                            width: 120,
                            //color: Colors.blue,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            child: DropdownButton(
                                focusColor: Colors.grey,
                                hint: Text(nationality),
                                items: <String>['Nepal']
                                    .map((String val) =>
                                        DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(val),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      nationality = value.toString();
                                    },
                                  );
                                }),
                          )
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          if (_datecontroller.text == "" ||
                              person == "Select" ||
                              addresscontroller.text == "" ||
                              contactnocontroller.text == "" ||
                              passportnumbercontroller.text == "" ||
                              nationality == "Nationality") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Fill out all fields'),
                            ));
                          } else {
                            validContactNO =
                                validContactNo(contactnocontroller.text);
                            validPassportNo = validPassportNumber(
                                passportnumbercontroller.text);
                            if (validContactNO && validPassportNo) {
                              FlightBookingRequestModel flightreq =
                                  new FlightBookingRequestModel(
                                      packageDetailID: fligthDetailID,
                                      bookedForDate: _datecontroller.text,
                                      address: addresscontroller.text,
                                      contactNo: contactnocontroller.text,
                                      passportNo: int.parse(
                                          passportnumbercontroller.text),
                                      nationality: nationality);

                              _sendToKhalti(context, flightreq);
                            }
                          }
                        });
                      },
                      child: Text("Procced"))
                ],
              )),
        ),
      );
    });
  }

  _sendToKhalti(BuildContext context, FlightBookingRequestModel requestModel) {
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
        api.bookFlight(requestModel).then((value) {
          if (value == true) {
            setState(() {
              _datecontroller.text = "";
              person = "Select";
              addresscontroller.text = "";
              contactnocontroller.text = "";
              passportnumbercontroller.text = "";
              nationality = "Nationality";
            });
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
      },
    );
  }
  // _initPayment(Map<String, dynamic> flight) async {
  //   ESewaConfiguration _configuration = ESewaConfiguration(
  //       clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
  //       secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
  //       environment: ESewaConfiguration.ENVIRONMENT_TEST); //ENVIRONMENT_LIVE

  //   ESewaPnp _eSewaPnp = ESewaPnp(configuration: _configuration);
  //   ESewaPayment _payment = ESewaPayment(
  //       amount: flight["Price"],
  //       productName: flight["AirlineName"],
  //       productID: flight["FlightNo"],
  //       callBackURL: "http://example.com/");
  //   try {
  //     final _res = await _eSewaPnp.initPayment(payment: _payment);
  //   } on ESewaPaymentException catch (e) {
  //     print(e);
  //   }
  // }
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
      return false;
    } else {
      if (regExp.hasMatch(userInput)) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool validPassportNumber(String userInput) {
    String pattern = r'^([0-9]){8}$';
    RegExp regExp = new RegExp(pattern);
    if (userInput.isEmpty) {
      return false;
    } else {
      if (regExp.hasMatch(userInput)) {
        return true;
      } else {
        return false;
      }
    }
  }
}

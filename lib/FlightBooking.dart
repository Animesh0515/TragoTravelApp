import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:trago/API/apiservices.dart';
import 'package:trago/login.dart';
import 'package:trago/packages.dart';
import 'package:trago/signup.dart';
import 'package:flutter/cupertino.dart';

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
  TextEditingController _datecontroller = new TextEditingController();
  API api = new API();
  List<dynamic> lst = [];
  var flight = [
    {"FlightNo": 1, "AirlineName": "Nepal Airlines", "Price": 3000}
  ];

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
  void initState() {
    // TODO: implement initState
    super.initState();
    api.getFlightDetails().then((value) {
      lst = value!;
      print(lst);
    });
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
                      decoration: InputDecoration(
                          labelText: 'From',
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: const BorderSide(color: Colors.grey)),
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
                      decoration: InputDecoration(
                          labelText: 'To',
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: const BorderSide(color: Colors.grey)),
                          errorText:
                              validTo ? null : 'Please enter the destination'),
                    ),
                  ),
                  // SizedBox(
                  //   width: 30,
                  // ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.blue,
                    //         borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    //         border: Border.all(color: Colors.black)),
                    //     child: Text("Click"),
                    //   ),
                    // ),

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        // border: Border.all(color: Colors.white)
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                physics:
                    NeverScrollableScrollPhysics(), // <-- this will disable scroll
                shrinkWrap: true,
                itemCount: 5,
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
                                              image: AssetImage(
                                                  'assets/airlines/nepalairllines.jpg'),
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
                                              "Nepal Airlines",
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text("From: Kathmandu"),
                                                SizedBox(width: 30),
                                                Text("To:Pokhara"),
                                              ],
                                            ),
                                            Text("Departure: 9:40 am"),
                                            Text("Arrival:10:30 am"),
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
                                                                bottomsheet());
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
                                                        "Rs. 5000",
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20,
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
                }),
          ],
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
          height: 500,
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
                  Text("U4-603"),
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
                    width: 10,
                  ),
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: TextField(
                          onTap: () {
                            _selectDate(context);
                          },
                          controller: _datecontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black))))),
                  SizedBox(width: 40),
                  Text("Person:"),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 80,
                    //color: Colors.blue,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButton(
                        focusColor: Colors.grey,
                        hint: Text(person),
                        items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
                            .map((String val) => DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              person = value.toString();
                            },
                          );
                        }),
                  )
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
                  Text("First Name:"),
                  SizedBox(width: 2),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black))),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text("Last Name:"),
                  SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black))),
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
                    width: 10,
                  ),
                  Text("Address:"),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black))),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text("Gender:"),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 30,
                    width: 100,
                    //color: Colors.blue,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    child: DropdownButton(
                        focusColor: Colors.grey,
                        hint: Text(gender),
                        items: <String>['Male', 'Female']
                            .map((String val) => DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              gender = value.toString();
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
                    width: 10,
                  ),
                  Text("Email:"),
                  SizedBox(width: 35),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Optional",
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black))),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text("Contact No:"),
                  SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
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
                        width: 180,
                        height: 30,
                        child: TextField(
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
                                .map((String val) => DropdownMenuItem<String>(
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
                    padding: const EdgeInsets.only(left: 300.0),
                    child: Text("Total:5000"),
                  )
                ],
              ),
              OutlinedButton(
                  onPressed: () {
                    _sendToKhalti(context);
                    // await _initPayment(flight[0]);
                  },
                  child: Text("Procced"))
            ],
          ));
    });
  }

  _sendToKhalti(BuildContext context) {
    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_02da791dba7241e591b286a94ef8302c",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
    );

    KhaltiProduct product = KhaltiProduct(
      id: "test",
      amount: 1000,
      name: "Payment  Demo",
    );

    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data) {
        print("Success message here");
      },
      onFaliure: (error) {
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
}

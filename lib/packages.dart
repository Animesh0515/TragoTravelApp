import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trago/API/apiservices.dart';
import 'package:trago/Hotel.dart';
import 'package:trago/Map.dart';
import 'package:trago/Profile.dart';
import 'package:trago/packageDetails.dart';
import 'package:trago/signup.dart';

import 'FlightBooking.dart';
import 'Models/PackageModel.dart';

class PackagesPage extends StatefulWidget {
  const PackagesPage({Key? key}) : super(key: key);

  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  String address = "";
  int selectedIndex = 0;
  List<dynamic> package = [];
  API api = new API();
  bool searchDestination = false;
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    var location;
    // TODO: implement initState
    super.initState();
    api.getPackages().then((value) {
      setState(() {
        package = value!;
      });
    });
    // _determinePosition();

    //print(location);
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
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.grey),
        title:
            //  Padding(
            //   padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
            ),
            Container(
              height: 35,
              width: 245,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15, color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  //labelText: "Search for destination",
                  hintText: "Search for destination",
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black)),
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
                onSubmitted: (val) => api.searchPackage(val).then((value) {
                  setState(() {
                    package = value!;
                    searchDestination = true;
                  });
                }),
              ),

              //     child: Text(
              //   "Trago",
              //   style: TextStyle(
              //       color: Colors.lightGreen,
              //       fontSize: 20,
              //       fontFamily: 'Montserrat',
              //       fontWeight: FontWeight.bold),
              // )),
              // CircleAvatar(
              //     radius: 20, backgroundImage: AssetImage("assets/logo.jpg")
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Text(
                    address,
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Wander Explore Discover",
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Satisfy',
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 30.0,
            ),

            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                    // height: 60.0,
                    // width: 150.0,
                    // decoration: BoxDecoration(
                    //   color: Colors.grey[200],
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlightBooking(),
                          ));
                    },
                    // child: Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.plane,
                      color: Colors.white,
                      size: 30,
                    ),
                    // ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        fixedSize: Size(170, 60),
                        // minimumSize: Size(100, 10),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                SizedBox(
                  width: 20,
                ),
                OutlinedButton(
                    // height: 60.0,
                    // width: 150.0,
                    // decoration: BoxDecoration(
                    //   color: Colors.grey[200],
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Hotel(),
                          ));
                    },
                    // child: Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.hotel,
                      color: Colors.white,
                      size: 30,
                    ),
                    // ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        fixedSize: Size(170, 60),
                        // minimumSize: Size(100, 10),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Destinations",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 170,
                      ),
                      searchDestination
                          ? GestureDetector(
                              onTap: () {
                                api.getPackages().then((value) {
                                  setState(() {
                                    package = value!;
                                    searchDestination = false;
                                    searchController.text = "";
                                  });
                                });
                              },
                              child: Text(
                                "Show all",
                                style: TextStyle(
                                    color: Colors.greenAccent, fontSize: 15),
                              ),
                            )
                          : Text(""),
                    ],
                  ),
                ),
                // Container(
                //     height: 200,
                //     color: Colors.blue,

                ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // <-- this will disable scroll
                    shrinkWrap: true,
                    itemCount: package.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PackageDetails(package: package[index]),
                              ));
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
                                            height: 120,
                                            width: 160,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      package[index]["Image"]),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            // color: Colors.green,
                                            height: 185,
                                            width: 190,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  package[index]["Destination"],
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text("Duration:" +
                                                    package[index]["Duration"]),

                                                Text("Type:" +
                                                    package[index]["Type"]),

                                                deals(package[index]["Flight"],
                                                    package[index]["Hotel"]),

                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(children: [
                                                  Container(
                                                    child: Wrap(
                                                      spacing: 15,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4.0),
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .users,
                                                            size: 18,
                                                            color: Colors
                                                                    .greenAccent[
                                                                200],
                                                          ),
                                                        ),
                                                        // SizedBox(width: 20),
                                                        Text(
                                                          package[index]
                                                              ["MaxPerson"],
                                                          // style: TextStyle(
                                                          //   fontSize: 20,
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          width: 22,
                                                        ),
                                                        Text(
                                                          "Rs." +
                                                              package[index]
                                                                      ["Price"]
                                                                  .toString(),
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                                // Text(
                                                //     "Pokhara  is a metropolitan city in Nepal, which serves as the capital of Gandaki Province. It is the country's largest metropolitan city in terms of area and second-largest in terms of population. The city also serves as the headquarters of Kaski District.[2] Pokhara is located 200 kilometres (120 miles) west of the capital, Kathmandu. The city is on the shore of Phewa Lake, and sits at an elevation of approximately 822m.[3] The Annapurna Range, with three out of the ten highest peaks in the world—Dhaulagiri, Annapurna I and Manaslu—is within 15–35 mi (24–56 km) of the valley."),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ]),
                                ),
                              )
                            ],
                          ),
                          // padding: const EdgeInsets.all(20.0),
                          // children: const <Widget>[
                          //     child: Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text("I'm dedicating every day to you"),
                          // )
                        ),
                      );
                    }),
              ],
            ),

            //  ListView.separated(
            //   scrollDirection: Axis.vertical,
            //   itemCount: 6,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container(
            //       height: 50,
            //       child: Center(child: Text('Hello')),
            //     );
            //  Container(
            //   color: Colors.red,
            //   child: Stack(
            //     children: <Widget>[
            //       Column(
            //         children: [
            //           Container(
            //             height: 120.0,
            //             width: 200.0,
            //             color: Colors.white,
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // );
            // },
            // separatorBuilder: (BuildContext context, int index) =>
            //     const Divider(),
            // )
            // )
          ],
        ),
      ),
    );
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permisiions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied, we cannot request permission.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    setState(() {
      address = "${place.locality},${place.country}";
    });
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
                context, MaterialPageRoute(builder: (context) => Map()));
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

  Widget deals(bool flight, bool hotel) {
    if (flight && hotel) {
      return Text("Also includes flight and hotel");
    } else if (flight) {
      return Text("Also includes flight");
    } else if (hotel) {
      return Text("Also includes hotel");
    } else {
      return Text("");
    }
  }
}

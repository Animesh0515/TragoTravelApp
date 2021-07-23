import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trago/API/apiservices.dart';

class PackageDetails extends StatelessWidget {
  final Map<String, dynamic> package;
  API api = new API();

  PackageDetails({required this.package});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 500,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              image: DecorationImage(
                                  image: AssetImage(package["Image"]),
                                  fit: BoxFit.fill)),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      package["Destination"],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(package["Description"]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('No of Person:' + package["MaxPerson"]),
                    Text('Package Type:' + package["Type"]),
                    Text('Duration:' + package["Duration"]),
                    Text('Price:' + package["Price"].toString()),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       OutlinedButton(
                  //           onPressed: () {},
                  //           child: Text(
                  //             'View Flight',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //           // ),
                  //           style: OutlinedButton.styleFrom(
                  //               backgroundColor: Colors.greenAccent,
                  //               fixedSize: Size(120, 40),
                  //               // minimumSize: Size(100, 10),
                  //               shape: const RoundedRectangleBorder(
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(10))))),
                  //       OutlinedButton(
                  //           onPressed: () {},
                  //           child: Text(
                  //             'View Hotel',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //           // ),
                  //           style: OutlinedButton.styleFrom(
                  //               backgroundColor: Colors.greenAccent,
                  //               fixedSize: Size(120, 40),
                  //               // minimumSize: Size(100, 10),
                  //               shape: const RoundedRectangleBorder(
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(10))))),
                  OutlinedButton(
                      onPressed: () async {
                        _sendToKhalti(context);
                      },
                      child: Text(
                        'Book',
                        style: TextStyle(color: Colors.white),
                      ),
                      // ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: Size(120, 40),
                          // minimumSize: Size(100, 10),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                ],
              ),
            )
            // ],
            ),
        // ),
        // )
      ]),
    );
  }

  _sendToKhalti(BuildContext context) {
    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_02da791dba7241e591b286a94ef8302c",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
    );

    KhaltiProduct product = KhaltiProduct(
      id: "test",
      amount: double.parse(package["Price"].toString()) * 100,
      name: "Package Payment ",
    );

    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data) {
        api
            .bookPackage(int.parse(package["PackageID"].toString()))
            .then((value) => {
                  if (value)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Booking Successful'),
                      ))
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Something went wrong!'),
                      ))
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
}

// class PackageDetails extends StatefulWidget {
//   final int id;

//   const PackageDetails({required this.id});

//   @override
//   _PackageDetailsState createState() => _PackageDetailsState();
// }

// class _PackageDetailsState extends State<PackageDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(color: Colors.white, child: Text('index: $id'));
//   }
// }

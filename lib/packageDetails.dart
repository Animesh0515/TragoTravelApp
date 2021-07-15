import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PackageDetails extends StatelessWidget {
  final int index;
  PackageDetails({required this.index});
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
                                image: AssetImage('assets/pokhara.jpg'),
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
                    'Pokhara',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Pokhara is Nepals number 1 adventure and leisure destination, a gateway to treks in the Annapurna region with plenty of entertainment for individual travellers and their families.In Pokhara you can experience the excitement of adventure: boating, hiking, pony rides, paragliding, bungee, zipline or simply relaxing at one of the several lakes in the valley.Relax at the shores of Fewa lake in Pokhara Pokhara will overwhelm you with its natural beauty and great photo ops. Walk along the shores of the Fewa Lake, enjoy the greenery surrounding you and gaze at the spectacular panoramic view of the Himalayan peaks of the Annapurna Massif. Brightly painted wooden boats add vibrant colors to the greenery, while paragliders float down slowly from above. Flying over the lake is probably going to be one of the highlights of your travel experience in Nepal.'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('No of Person: 2'),
                  Text('Package Type: Couple Package'),
                  Text('Duration:3 days 1 night'),
                  Text('Price: 3000'),
                  SizedBox(
                    height: 10,
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'View Flight',
                            style: TextStyle(color: Colors.white),
                          ),
                          // ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              fixedSize: Size(120, 40),
                              // minimumSize: Size(100, 10),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))),
                      OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'View Hotel',
                            style: TextStyle(color: Colors.white),
                          ),
                          // ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              fixedSize: Size(120, 40),
                              // minimumSize: Size(100, 10),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))),
                      OutlinedButton(
                          onPressed: () {},
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
              ],
            ),
          ),
        )
      ]),
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

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: camel_case_types
class home_body extends StatefulWidget {
  const home_body({super.key});

  @override
  State<home_body> createState() => _home_bodyState();
}

// ignore: camel_case_types
class _home_bodyState extends State<home_body> {
  @override
  Widget build(BuildContext context) {
    double width = double.infinity;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    //letterSpacing: 10,
                  ),
                ),
                Text(
                  'Husman',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CarouselSlider(
            items: <Widget>[
              Card(
                color: Colors.amberAccent,
                child: SizedBox(
                  //   height: 150,
                  width: width,
                  child: Image.asset(
                    'assets/images/sliate/sliate2.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Card(
                color: Colors.blueAccent,
                child: SizedBox(
                  //  height: 250,
                  width: width,
                  child: Image.asset(
                    'assets/images/sliate/sliate1.jpeg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 180,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlay: true,
              autoPlayCurve: Curves.decelerate,
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              GestureDetector(
                child: const Text(
                  'Veiw All',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.blue,
                        child: const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'This is the modal bottom sheet. Slide down to dismiss.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Card(
                  color: Colors.amberAccent,
                  child: SizedBox(
                    height: 160,
                    width: 140,
                    child: Center(child: Text('Mr.Manas')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  color: Colors.amberAccent,
                  child: SizedBox(
                    height: 160,
                    width: 140,
                    child: Center(child: Text('Mr.Manas')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  color: Colors.amberAccent,
                  child: SizedBox(
                    height: 160,
                    width: 140,
                    child: Center(child: Text('Mr.Manas')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  color: Colors.amberAccent,
                  child: SizedBox(
                    height: 160,
                    width: 140,
                    child: Center(child: Text('Mr.Manas')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  color: Colors.amberAccent,
                  child: SizedBox(
                    height: 160,
                    width: 140,
                    child: Center(child: Text('Mr.Manas')),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  color: Colors.amberAccent,
                  child: SizedBox(
                    height: 160,
                    width: 140,
                    child: Center(child: Text('Mr.Manas')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

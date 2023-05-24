import 'package:flutter/material.dart';
import 'package:sliate/screens/categories/more.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hi Manas Afrid',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Icon(
                  Icons.notifications,
                  size: 35,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Today Thursday, 13 Apr 2023',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.lightBlue.shade900,
              ),
              child: const Center(child: Text('Manas')),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/images/icons/newsfeed.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/images/icons/lecturer.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/images/icons/lms.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/images/icons/lms.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('News Feed'),
                Text('Lecturers'),
                Text('Past Paper'),
                Text('Notes'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/images/icons/gallary.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/images/icons/forms.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(
                      'assets/images/icons/map.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Card(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const categories()),
                        ),
                      ),
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: Image.asset(
                        'assets/images/icons/more.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Gallary'),
                Text('Forms'),
                Text('Map'),
                Text('More'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Academic Status',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: SfRadialGauge(
                    axes: [
                      RadialAxis(
                        minimum: 0,
                        maximum: 13,
                        radiusFactor: 1.2,
                        canScaleToFit: false,
                        startAngle: 90,
                        endAngle: 90,
                        showLabels: false,
                        centerX: 0.2,
                        interval: 1,
                        showTicks: false,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          color: Color.fromARGB(30, 0, 169, 181),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: const [
                          RangePointer(
                            value: 3,
                            width: 0.2,
                            sizeUnit: GaugeSizeUnit.factor,
                            enableAnimation: true,
                            animationDuration: 500,
                            animationType: AnimationType.easeOutBack,
                            color: Color.fromARGB(255, 0, 169, 181),
                          ),
                        ],
                        annotations: const [
                          GaugeAnnotation(
                            verticalAlignment: GaugeAlignment.center,
                            widget: Text(
                              '3 Week',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            positionFactor: 0.1,
                            angle: 90,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Total Week : 13'),
                    Text('Completed Week : 3'),
                    Text('Balance Week : 10'),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

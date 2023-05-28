import 'package:flutter/material.dart';

class staff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal ListView Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Horizontal ListView Demo'),
        ),
        body: Column(
          children: [
            Container(
                height: 150, width: 400, child: Center(child: Text('Manas'))),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                      width: 100,
                      height: 50,
                      margin: EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Box ${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

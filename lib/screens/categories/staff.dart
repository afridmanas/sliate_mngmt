import 'package:flutter/material.dart';

class staff extends StatelessWidget {
  const staff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal ListView Demo',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, // Change the color of the back arrow here
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
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
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Box ${index + 1}',
                          style: const TextStyle(
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

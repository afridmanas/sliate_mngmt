import 'package:flutter/material.dart';

// ignore: camel_case_types
class news_veiw extends StatefulWidget {
  const news_veiw({super.key});

  @override
  State<news_veiw> createState() => _news_veiwState();
}

// ignore: camel_case_types
class _news_veiwState extends State<news_veiw> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: const Color.fromARGB(255, 221, 218, 218),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: IconButton(
                icon: const Icon(Icons.bookmark_outline),
                onPressed: () {
                  // do something
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: const Color.fromARGB(255, 221, 218, 218),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Positioned(
                top: 20,
                left: 30,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: ((context) => const DetailScreen()),
                    //   ),
                    // );
                  },
                  child: Container(
                    height: 250,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/logo/manas.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}

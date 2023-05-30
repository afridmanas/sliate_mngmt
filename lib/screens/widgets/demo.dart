import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridPage extends StatelessWidget {
  const StaggeredGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Add your action code here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 15.0,
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: index.isEven ? 200 : 300,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/logo/manas.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Text('manas'),
              ),
            );
          },
        ),
      ),
    );
  }
}


    // StaggeredGridView.countBuilder(
    //   crossAxisCount: 2,
    //   itemCount: 10,
    //   itemBuilder: (BuildContext context, int index) => Container(
    //     color: Colors.blueGrey,
    //     child: Center(
    //       child: CircleAvatar(
    //         backgroundColor: Colors.white,
    //         child: Text('$index'),
    //       ),
    //     ),
    //   ),
    //   staggeredTileBuilder: (int index) =>
    //       StaggeredTile.count(1, index.isEven ? 2 : 1),
    //   mainAxisSpacing: 4.0,
    //   crossAxisSpacing: 4.0,
    // ),
    //  );


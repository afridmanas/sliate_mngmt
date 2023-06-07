import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Event_tab_bar extends StatefulWidget {
  const Event_tab_bar({super.key});

  @override
  State<Event_tab_bar> createState() => _Event_tab_barState();
}

class _Event_tab_barState extends State<Event_tab_bar> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 7.0,
      crossAxisSpacing: 7.0,
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        final isEvenIndex = index.isEven;

        final containerHeight = isEvenIndex ? 200.0 : 300.0;

        final descriptionHeight = isEvenIndex ? 70.0 : 90.0;

        return GestureDetector(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: FractionallySizedBox(
                    heightFactor: containerHeight / containerHeight,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/logo/manas.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: descriptionHeight,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Short Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

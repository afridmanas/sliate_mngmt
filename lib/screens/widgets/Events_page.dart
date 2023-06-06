import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Events_page extends StatefulWidget {
  const Events_page({Key? key});

  @override
  State<Events_page> createState() => _Events_pageState();
}

class _Events_pageState extends State<Events_page>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: const IconThemeData(
      //     color: Colors.black,
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.home),
      //       onPressed: () {
      //         // Add your action code here
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Events',
                        style: GoogleFonts.mavenPro(
                          textStyle: const TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          color: Colors.white,
                          height: 35,
                          child: Center(
                            child: TextFormField(
                              onChanged: (value) => {},
                              // searchNotes(value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: 'Search Here',
                                prefixIcon: const Icon(
                                  Icons.search_sharp,
                                  color: title_color,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 530,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      indicator:
                          DotTabIndicator(color: Colors.black, radius: 4),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      controller: _tabcontroller,
                      tabs: [
                        Tab(
                          text: 'Latest',
                        ),
                        Tab(
                          text: 'HNDIT',
                        ),
                        Tab(
                          text: 'HNDE',
                        ),
                        Tab(
                          text: 'HNDA',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabcontroller,
                      children: [
                        MasonryGridView.count(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: FractionallySizedBox(
                                        heightFactor:
                                            containerHeight / containerHeight,
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
                        ),
                        MasonryGridView.count(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: FractionallySizedBox(
                                        heightFactor:
                                            containerHeight / containerHeight,
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
                        ),
                        MasonryGridView.count(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: FractionallySizedBox(
                                        heightFactor:
                                            containerHeight / containerHeight,
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
                        ),
                        MasonryGridView.count(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: FractionallySizedBox(
                                        heightFactor:
                                            containerHeight / containerHeight,
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DotTabIndicator extends Decoration {
  final BoxPainter _painter;

  DotTabIndicator({required Color color, required double radius})
      : _painter = _DotPainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _DotPainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _DotPainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final center = offset +
        Offset(configuration.size!.width / 2,
            configuration.size!.height - radius - 2);
    canvas.drawCircle(center, radius, _paint);
  }
}

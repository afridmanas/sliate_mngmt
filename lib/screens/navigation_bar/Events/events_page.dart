import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sliate/screens/navigation_bar/Events/event_tab_bar.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'Events',
                      style: GoogleFonts.mavenPro(
                        textStyle: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
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
                      tabs: const [
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
                      children: const [
                        Event_tab_bar(),
                        Event_tab_bar(),
                        Event_tab_bar(),
                        Event_tab_bar(),
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

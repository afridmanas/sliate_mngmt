import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sliate/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Events extends StatefulWidget {
  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  final PageController _pageController = PageController(initialPage: 0);

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  Container(
                    color: bg_clr,
                    child: TabBar(
                      indicator:
                          DotTabIndicator(color: text_clr, radius: 4),
                      labelColor: text_clr,
                      unselectedLabelColor: widg_clr,
                      tabs: const [
                        Tab(text: 'Latest'),
                        Tab(text: 'HNDIT'),
                        Tab(text: 'HNDE'),
                        Tab(text: 'HNDA'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ContainerList(),
                        ContainerList(),
                        ContainerList(),
                        ContainerList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Events'),
              Text('View All'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Replace with your desired number of items
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(IconlyLight.profile),
                    title: Text('Item $index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerList extends StatefulWidget {
  @override
  State<ContainerList> createState() => _ContainerListState();
}

class _ContainerListState extends State<ContainerList> {
  final PageController pageController = PageController(viewportFraction: 0.85);
  Timer? timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startAutoScroll() {
    timer = Timer.periodic(
      const Duration(seconds: 8),
      (Timer timer) {
        if (currentPage < 4) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeIn,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemCount: 5, // Replace with your desired number of containers
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: widget_clr1,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 300,
                height: 100,
                margin: const EdgeInsets.only(
                    top: 10, left: 10, bottom: 10, right: 10),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 25,
                      left: 25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bottom Text $index',
                            style:  TextStyle(
                              fontSize: 20,
                              color: bg_clr,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Today\'s Date: ${DateFormat.yMd().format(DateTime.now())}',
                            style:  TextStyle(
                              fontSize: 14,
                              color: bg_clr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 5, // Replace with your desired number of containers
                effect:  WormEffect(
                  dotColor: widg_clr,
                  activeDotColor: text_clr,
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 10,
                ),
              ),
            ),
          ),
        ),
      ],
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

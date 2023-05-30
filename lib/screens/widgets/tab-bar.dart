import 'package:flutter/material.dart';

class tab_bar extends StatefulWidget {
  const tab_bar({super.key});

  @override
  State<tab_bar> createState() => _tab_barState();
}

class _tab_barState extends State<tab_bar> with TickerProviderStateMixin {
  TabController? _tabcontroller;

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelColor: Colors.grey,
          controller: _tabcontroller,
          tabs: const [
            Tab(child: Text('All')),
            Tab(child: Text('HNDIT')),
            Tab(child: Text('HNDA')),
            Tab(child: Text('HNDE')),
          ]),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/Notes/note_past.dart';

class notes_hndit extends StatefulWidget {
  const notes_hndit({Key? key}) : super(key: key);

  @override
  State<notes_hndit> createState() => _notes_hnditState();
}

class _notes_hnditState extends State<notes_hndit>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Academic Notes',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Container(
                      height: 200,
                      width: width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/sliate-sam.appspot.com/o/Academic%20Modules%2FHNDIT%2Finformation_technology.jpg?alt=media&token=9e3c89b8-873a-4b07-9211-e1484a1ea950',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              //
              //height: 450,
              //  width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      indicator:
                          DotTabIndicator(color: Colors.black, radius: 4),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      controller: _tabcontroller,
                      tabs: const [
                        Tab(
                          text: '1st Sem',
                        ),
                        Tab(
                          text: '2nd Sem',
                        ),
                        Tab(
                          text: '3rd Sem',
                        ),
                        Tab(
                          text: '4th Sem',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabcontroller,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: _db
                                .collection(
                                    '/lms/departments/hndit/semester1/subject_list')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  var course = snapshot.data!.docs[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => NotesPatPaper(
                                                notes_path:
                                                    course['notes_path'],
                                                past_path: course['past_path'],
                                                title: course['sub_name'],
                                              )),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 80,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: bg_clr,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: bg_clr,
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  course['image_url'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  course['sub_name'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Text(
                                                //   '${course['year']} Year '
                                                //   '${course['semester']} Semester',
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: _db
                                .collection(
                                    '/lms/departments/hndit/semester2/subject_list')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  var course = snapshot.data!.docs[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => NotesPatPaper(
                                                title: course['sub_name'],
                                                notes_path:
                                                    course['notes_path'],
                                                past_path: course['past_path'],
                                              )),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 80,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: bg_clr,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: bg_clr,
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  course['image_url'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  course['sub_name'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Text(
                                                //   '${course['year']} Year '
                                                //   '${course['semester']} Semester',
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: _db
                                .collection(
                                    '/lms/departments/hndit/semester3/subject_list')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  var course = snapshot.data!.docs[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => NotesPatPaper(
                                                notes_path:
                                                    course['notes_path'],
                                                past_path: course['past_path'],
                                                title: course['sub_name'],
                                              )),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 80,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: bg_clr,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: bg_clr,
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  course['image_url'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  course['sub_name'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Text(
                                                //   '${course['year']} Year '
                                                //   '${course['semester']} Semester',
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: _db
                                .collection(
                                    '/lms/departments/hndit/semester4/subject_list')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  var course = snapshot.data!.docs[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) => NotesPatPaper(
                                                notes_path:
                                                    course['notes_path'],
                                                past_path: course['past_path'],
                                                title: course['sub_name'],
                                              )),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 80,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: bg_clr,
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: bg_clr,
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  course['image_url'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  course['sub_name'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // Text(
                                                //   '${course['year']} Year '
                                                //   '${course['semester']} Semester',
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
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

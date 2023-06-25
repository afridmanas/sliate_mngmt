import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskSchedule extends StatefulWidget {
  const TaskSchedule({Key? key}) : super(key: key);

  @override
  State<TaskSchedule> createState() => _TaskScheduleState();
}

class _TaskScheduleState extends State<TaskSchedule> {
  List<Map<String, dynamic>> taskDetails = [];
  String currentUserDepartment = '';
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    fetchingFirebase();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> fetchingFirebase() async {
    await fetchCurrentUserDetails();
    await fetchTaskDetails();
  }

  Future<void> fetchCurrentUserDetails() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('/users/login_form/students')
          .doc(user.uid)
          .get();
      final userData = userSnapshot.data();
      if (userData != null) {
        setState(() {
          currentUserDepartment = userData['department'];
        });
      }
    }
  }

  Future<void> fetchTaskDetails() async {
    final taskSnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('department', isEqualTo: currentUserDepartment)
        .get();

    final taskList = taskSnapshot.docs;

    if (_isMounted) {
      setState(() {
        taskDetails = taskList.map((task) => task.data()).toList();
      });
    }
  }

  Future<void> refreshData() async {
    await fetchTaskDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_clr,
      appBar: AppBar(
        backgroundColor: bg_clr,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Text(
              'Task schedule',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                  inherit: true,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshData,
              child: taskDetails.isNotEmpty
                  ? ListView.builder(
                      itemCount: taskDetails.length,
                      itemBuilder: (context, index) {
                        final task = taskDetails[index];
                        final formattedDate = DateFormat('MMM dd')
                            .format(task['submissionDate'].toDate());
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 15,
                            right: 15,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      task['title'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                task['description'],
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Submission'),
                                  Text(formattedDate),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.all(5),
                      child: const ListTile(
                        title: Text(
                          'Enjoy!,\nYou Have no Task to do, Keep Smile.',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

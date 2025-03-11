import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewExamsPage extends StatelessWidget {
  const ViewExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Exams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Your Gateway\nto Online Exams!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poor Story',
                    fontSize: 40,
                    color: const Color.fromARGB(255, 8, 41, 114),
                  ),
                ),
              ),
            ),
            _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('teacherhomepage', (route) => false);
              },
            ),
            _drawerDivider(),
            _createDrawerItem(
              icon: Icons.assignment,
              text: 'Create Exam',
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("createexam", (route) => false);
              },
            ),
            _drawerDivider(),
            _createDrawerItem(
              icon: Icons.report,
              text: 'View Submissions',
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("submissions", (route) => false);
              },
            ),
            _drawerDivider(),
            _createDrawerItem(
              icon: Icons.visibility,
              text: 'View Exams',
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("viewexams", (route) => false);
              },
            ),
            _drawerDivider(),
            _createDrawerItem(
              icon: Icons.notifications,
              text: 'Notifications',
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("notifications", (route) => false);
              },
            ),
            const Spacer(),
            _drawerDivider(),
            _createDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, const Color.fromARGB(255, 228, 230, 252)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello, ',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sorts Mill Goudy',
                                  color: Color.fromARGB(255, 8, 41, 114)),
                            ),
                            SizedBox(height: 10,),
                            const Text(
                              "\t\tWelcome to",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sorts Mill Goudy',
                                  color: Color.fromARGB(255, 8, 41, 114)),
                            ),
                            SizedBox(height: 10,),
                            const Text(
                              '\t\t\t\tOEMS!',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontFamily: 'Patua One',
                                  color: Color.fromARGB(255, 8, 41, 114)),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/Logo.png',
                        height: 130,
                        width: 130,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Exams')
                        // .where('TeacherID', isEqualTo: user?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No exams found.'));
                      }
                      final exams = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: exams.length,
                        itemBuilder: (context, index) {
                          final exam = exams[index];
                          final data = exam.data() as Map<String, dynamic>?;

                          final title = data != null && data.containsKey('ExamTitle') ? data['ExamTitle'] : 'No Title';
                          final teacherId = data != null && data.containsKey('TeacherID') ? data['TeacherID'] : 'Unknown';

                          return Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text(title),
                              subtitle: Text('Created by: $teacherId'),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  'submissions',
                                  arguments: exam.id,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    GestureTapCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Color.fromARGB(255, 8, 41, 114), size: 28),
        title: Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 8, 41, 114),
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Sorts Mill Goudy',
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _drawerDivider() {
    return Divider(
      color: Color.fromARGB(255, 184, 184, 184),
      thickness: 1,
      height: 40,
    );
  }
}
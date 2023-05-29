import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfoPage extends StatelessWidget {
  final String name = 'John Doe';
  final String image = 'https://via.placeholder.com/150';
  final String about =
      'I am a mobile app developer with 5 years of experience in Flutter. I specialize in building beautiful and functional apps for both Android and iOS platforms.';
  final List<String> projects = [
    'Project 1',
    'Project 2',
    'Project 3',
  ];
  final String githubLink = 'https://github.com/johndoe';
  final String email = 'johndoe@example.com';
  final String phone = '+1 123-456-7890';
  final String linkedinLink = 'https://www.linkedin.com/in/johndoe';
  final String twitterLink = 'https://twitter.com/johndoe';

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(
                      'assets/images/logo/manas.jpg',
                    ),
                    // fit: BoxFit.fitWidth,
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.email),
                              onPressed: () => _launchURL('mailto:$email'),
                            ),
                            IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () => _launchURL('tel:$phone'),
                            ),
                            IconButton(
                              icon: Icon(Icons.link),
                              onPressed: () => _launchURL(githubLink),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    about,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Projects',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(projects[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () => _launchURL(githubLink),
                  ),
                  IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () => _launchURL('mailto:$email'),
                  ),
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () => _launchURL('tel:$phone'),
                  ),
                  IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () => _launchURL(linkedinLink),
                  ),
                  IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () => _launchURL(twitterLink),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

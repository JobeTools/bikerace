import 'dart:ui';
import 'package:bikerace/pages/solo_page/solo_page.dart';
import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import '../../authentication/Auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profilePicture = 'assets/profile/default_profile_picture.png';
  String username = 'GuestUser';
  int trophies = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    if (Auth.isAuthenticated) {
      // Simulating fetching user data from backend or database
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        username = 'BobTheBeast9';
        trophies = 15;
        profilePicture = 'assets/profile/example_profile_picture.jpg';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Image.asset(
                'assets/home/race.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                leading: null,
                actions: [
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: PopupMenuButton(
                      offset: Offset(0, 40),
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onSelected: (value) {
                        if (value == 'Race Log') {
                          // Handle Race Log menu item
                        } else if (value == 'Leaderboard') {
                          // Handle Leaderboard menu item
                        } else if (value == 'Settings') {
                          // Handle Settings menu item
                        } else if (value == 'Help') {
                          // Handle Help menu item
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        buildPopupMenuItem(
                          'Race Log',
                          Icons.list_alt,
                          () {
                            if (Auth.isAuthenticated) {
                              // Handle Race Log menu item
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WelcomePage(),
                                ),
                              );
                            }
                          },
                        ),
                        buildPopupMenuItem(
                          'Leaderboard',
                          Icons.leaderboard,
                          () {
                            // Handle Leaderboard menu item
                          },
                        ),
                        buildPopupMenuItem(
                          'Settings',
                          Icons.settings,
                          () {
                            // Handle Settings menu item
                          },
                        ),
                        buildPopupMenuItem(
                          'Help',
                          Icons.help,
                          () {
                            // Handle Help menu item
                          },
                        ),
                        buildPopupMenuItem(
                          'Account',
                          Icons.person,
                          () {
                            // Handle Account menu item
                            if (Auth.isAuthenticated) {
                              // Handle Race Log menu item
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WelcomePage(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                      color: Colors.white,
                      elevation: 4,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(profilePicture),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.yellow,
                              size: 20,
                            ),
                            SizedBox(width: 4),
                            Text(
                              trophies.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SoloRacePage(),
                              ),
                            );
                          },
                          child: Text(
                            'Solo',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[500],
                            onPrimary: Colors.black,
                            elevation: 0,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            if (Auth.isAuthenticated) {
                              // Handle authenticated action
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WelcomePage(),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Race',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              Navbar(context, 2),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem buildPopupMenuItem(
    String title,
    IconData icon,
    void Function() onTap,
  ) {
    return PopupMenuItem(
      value: title,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Container Navbar(BuildContext context, int activeIndex) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildNavbarIconButton(
              Icons.list_alt,
              activeIndex == 0,
              () {
                // Navigate to "Race Log" page
              },
            ),
            buildNavbarIconButton(
              Icons.leaderboard,
              activeIndex == 1,
              () {
                // Navigate to "Leaderboard" page
              },
            ),
            buildNavbarIconButton(
              Icons.settings,
              activeIndex == 2,
              () {
                // Navigate to "Settings" page
              },
            ),
            buildNavbarIconButton(
              Icons.help,
              activeIndex == 3,
              () {
                // Navigate to "Help" page
              },
            ),
            buildNavbarIconButton(
              Icons.person,
              activeIndex == 4,
              () {
                // Handle Account icon tap
                if (Auth.isAuthenticated) {
                  // Handle authenticated action
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomePage(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  IconButton buildNavbarIconButton(
    IconData icon,
    bool isActive,
    void Function() onPressed,
  ) {
    return IconButton(
      icon: Icon(
        icon,
        size: isActive ? 28 : 24,
        color: isActive ? Colors.black : Colors.black.withOpacity(0.6),
      ),
      onPressed: onPressed,
    );
  }
}

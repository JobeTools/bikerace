import 'dart:ui';
import 'package:bikerace/global%20widgets/navbar_widget.dart';
import 'package:bikerace/pages/popup_menu_pages/Help_page/Help_page.dart';
import 'package:bikerace/pages/popup_menu_pages/Leaderboard_page/Leaderboard_page.dart';
import 'package:bikerace/pages/popup_menu_pages/RaceLog_Page/RaceLog_page.dart';
import 'package:bikerace/pages/popup_menu_pages/Settings_Page/Settings_page.dart';
import 'package:bikerace/pages/solo_page/solo_page.dart';
import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:bikerace/state_management/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../authentication/Auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profilePicture = 'assets/profile/default_profile_picture.png';
  String username = 'GuestUser';
  int trophies = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    if (Auth.isAuthenticated) {
      // Fetch username from the database
      String fetchedUsername = await databaseHelper.getUsername();

      // Update the state with the fetched username
      setState(() {
        username = fetchedUsername;
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
                          if (Auth.isAuthenticated) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: RaceLogPage(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const WelcomePage(),
                              ),
                            );
                          }
                        } else if (value == 'Leaderboard') {
                          // Handle Leaderboard menu item
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: LeaderboardPage(),
                            ),
                          );
                        } else if (value == 'Settings') {
                          // Handle Settings menu item
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: SettingsPage(),
                            ),
                          );
                        } else if (value == 'Help') {
                          // Handle Help menu item
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: HelpPage(),
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        buildPopupMenuItem(
                          'Race Log',
                          Icons.list_alt,
                          () {
                            if (Auth.isAuthenticated) {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: RaceLogPage(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const WelcomePage(),
                                ),
                              );
                            }
                          },
                        ),
                        buildPopupMenuItem(
                          'Leaderboard',
                          Icons.leaderboard,
                          () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: LeaderboardPage(),
                              ),
                            );
                          },
                        ),
                        buildPopupMenuItem(
                          'Settings',
                          Icons.settings,
                          () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: SettingsPage(),
                              ),
                            );
                          },
                        ),
                        buildPopupMenuItem(
                          'Help',
                          Icons.help,
                          () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: HelpPage(),
                              ),
                            );
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
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const WelcomePage(),
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
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: SoloRacePage(),
                              ),
                              (route) =>
                                  false, // Remove all previous routes from the stack
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
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const WelcomePage(),
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
              NavbarWidget(activeIndex: 2),
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
}

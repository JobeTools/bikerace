import 'package:bikerace/authentication/Auth.dart';
import 'package:bikerace/pages/Account/account_page.dart';
import 'package:bikerace/pages/Community/community_page.dart';
import 'package:bikerace/pages/Explore/explore_page.dart';
import 'package:bikerace/pages/Stats/stats_page.dart';
import 'package:bikerace/pages/homePage/home_page.dart';
import 'package:bikerace/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavbarWidget extends StatelessWidget {
  final int activeIndex;

  const NavbarWidget({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
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
                if (activeIndex != 0) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: CommunityPage(),
                    ),
                  );
                }
              },
            ),
            buildNavbarIconButton(
              Icons.leaderboard,
              activeIndex == 1,
              () {
                // Navigate to "Leaderboard" page
                if (activeIndex != 1) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: ExplorePage(),
                    ),
                  );
                }
              },
            ),
            buildNavbarIconButton(
              Icons.settings,
              activeIndex == 2,
              () {
                if (activeIndex != 2) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: HomePage(),
                    ),
                  );
                }
              },
            ),
            buildNavbarIconButton(
              Icons.help,
              activeIndex == 3,
              () {
                // Navigate to "Help" page
                if (activeIndex != 3) {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: StatsPage(),
                    ),
                  );
                }
              },
            ),
            buildNavbarIconButton(
              Icons.person,
              activeIndex == 4,
              () {
                // Handle Account icon tap
                if (activeIndex != 4) {
                  if (Auth.isAuthenticated) {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: AccountPage(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: WelcomePage(),
                      ),
                    );
                  }
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

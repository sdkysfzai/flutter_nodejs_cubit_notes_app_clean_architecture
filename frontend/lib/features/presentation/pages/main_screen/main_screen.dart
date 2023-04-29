import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/add_note_page/add_note_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/favorite_notes_page/favorite_notes_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/home_page/home_page.dart';
import 'package:flutter_nodejs_cubit_notes_app_clean_architecture/features/presentation/pages/main_screen/profile_page/profile_page.dart';
import '../../../utils/consts/color_consts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        backgroundColor: backGroundColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: primaryColor), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, color: primaryColor), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: primaryColor), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, color: primaryColor),
              label: ""),
        ],
        onTap: navigationTapped,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomePage(),
          AddNotePage(),
          FavoriteNotesPage(),
          ProfilePage()
        ],
      ),
    );
  }
}

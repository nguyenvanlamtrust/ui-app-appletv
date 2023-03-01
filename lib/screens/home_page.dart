
import 'package:btl_kiemtra_flutter/bloc/app_bottom_navigation_bar_bloc.dart';
import 'package:btl_kiemtra_flutter/enums/category_type_enum.dart';
import 'package:btl_kiemtra_flutter/extensions/category_type_ext.dart';
import 'package:btl_kiemtra_flutter/extensions/text_style_ext.dart';
import 'package:btl_kiemtra_flutter/screens/category_screen.dart';
import 'package:btl_kiemtra_flutter/screens/dashboard_screen.dart';
import 'package:btl_kiemtra_flutter/screens/like_screen.dart';
import 'package:btl_kiemtra_flutter/screens/playlist_add_screen.dart';
import 'package:btl_kiemtra_flutter/screens/search_screen.dart';
import 'package:btl_kiemtra_flutter/shared/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final AppBottomNavigationBarBloc _appBottomNavigationBarBloc = AppBottomNavigationBarBloc();

  @override
  void dispose() {
    _appBottomNavigationBarBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorPrimary,
        shape: const Border(
          bottom: BorderSide(
            color: colorPrimaryLight,
            width: 1
          )
        ),
        elevation: 0,
        title: Text('AppleTV', style:  const TextStyle().title),
        actions: [
          GestureDetector(
            child: const Icon(Icons.search),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchScreen())
              );
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: _buildBody(),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _appBottomNavigationBarBloc.pageViewController,
      children: const [
        DashboardScreen(),
        CategoryScreen(),
        LikeScreenn(),
        PlaylistAddScreen(),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: colorRed,
            ),
            child: Text('AppleTV App', style: Theme.of(context).textTheme.headlineMedium),
          ),
          ListTile(
            title: Text(CategoryType.channels.getName()),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text(CategoryType.trending.getName()),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff2E2E2E), width: 3))
      ),
      child: StreamBuilder<int>(
        initialData: _appBottomNavigationBarBloc.initTabIndex,
        stream: _appBottomNavigationBarBloc.stream,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            currentIndex: snapshot.data ?? _appBottomNavigationBarBloc.initTabIndex,
            elevation: 1,
            selectedItemColor: colorRed,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: colorPrimaryLight,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 28,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.airplay_sharp), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.thumb_up), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.playlist_add_outlined, size: 40,), label: ''),
            ],
            onTap: (idx) {
              _appBottomNavigationBarBloc.changeTabIndex(idx);
            },
          );
        }
      ),
    );
  }
}
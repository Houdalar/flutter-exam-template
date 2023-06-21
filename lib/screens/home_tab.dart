import 'package:flutter/material.dart';

import '../models/user.dart';
import 'listview.dart';

//with drawer
class HomeTab extends StatelessWidget {
  final User user;

  HomeTab({required this.user});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Grid'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListViewScreen(user: user),
            ListViewScreen(user: user),
            ListViewScreen(user: user),
            // GridViewScreen(),
            // ProfileScreen(),
          ],
        ),
      ),
    );
  }
}

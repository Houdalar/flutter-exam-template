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
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('My Crypto-Currencies'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/currencies');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
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

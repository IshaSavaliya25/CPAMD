import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/screens/color_screen.dart';
import 'package:user_app/screens/services/theme_service.dart';
import 'package:user_app/screens/settingscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text('My User App')),
        drawer: _buildDrawer(context),
        body: TabBarView(
          children: [
            MyWidget(),
            Container(child: Text('Person')),
            Container(child: Text('Settings')),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.person), text: 'Person'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    var themeService = Provider.of<ThemeService>(context);
    return Drawer(
      child: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeService.isDark,
            onChanged: (val) {
              themeService.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:fabdashboard/views/screens/newPost/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

List<SideNavigationBarItem> items = const [
  SideNavigationBarItem(
    icon: Icons.add_outlined,
    label: 'New Post',
  ),
  SideNavigationBarItem(
    icon: Icons.email_outlined,
    label: 'New Notification',
  ),
  SideNavigationBarItem(
    icon: Icons.person_outline,
    label: 'List of Students',
  ),
  SideNavigationBarItem(
    icon: Icons.person,
    label: 'List of Teachers',
  ),
];
List<Widget> screens = const [
  PostsPage(),
  Center(
    child: Text('New Notification'),
  ),
  Center(
    child: Text('List of Students'),
  ),
  Center(
    child: Text('List of Teachers'),
  ),
];

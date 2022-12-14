import 'package:fabdashboard/views/screens/materials/materials_page.dart';
import 'package:fabdashboard/views/screens/messages/sendmessage.dart';
import 'package:fabdashboard/views/screens/posts/posts_page.dart';
import 'package:fabdashboard/views/screens/students/studentspage.dart';
import 'package:fabdashboard/views/screens/teachers/teachers.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:side_navigation/side_navigation.dart';

List<SideNavigationBarItem> items = const [
  SideNavigationBarItem(
    icon: Ionicons.document_text_outline,
    label: 'Posts',
  ),
  SideNavigationBarItem(
    icon: Ionicons.flask_outline,
    label: 'Materials',
  ),
  SideNavigationBarItem(
    icon: Ionicons.send_outline,
    label: 'Messages',
  ),
  SideNavigationBarItem(
    icon: Ionicons.person_outline,
    label: 'Students',
  ),
  SideNavigationBarItem(
    icon: Ionicons.people_outline,
    label: 'Teachers',
  ),
];
List<Widget> screens = const [
  PostsPage(),
  MaterialsPage(),
  SendMessage(),
  StudentsPage(),
  TeachersPage()
];

import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/creator_screen.dart';
import '../screens/content_screen.dart';
import '../screens/setting_screen.dart';
import 'route_manager.dart';

class AppRoutes {
  // 定义路由名称常量
  static const String home = '/';
  static const String creator = '/creator';
  static const String content = '/content';
  static const String setting = '/setting';

  // 页面配置
  static final List<Map<String, dynamic>> pages = [
    {
      'route': home,
      'title': '总览',
      'icon': Icons.dashboard,
      'screen': const HomeScreen(),
    },
    {
      'route': creator,
      'title': '创作者',
      'icon': Icons.person,
      'screen': const CreatorScreen(),
    },
    {
      'route': content,
      'title': '内容',
      'icon': Icons.video_library,
      'screen': const ContentScreen(),
    },
    {
      'route': setting,
      'title': '设置',
      'icon': Icons.settings,
      'screen': const SettingScreen(),
    },
  ];

  // 获取所有导航目标
  static List<NavigationDestination> getNavigationDestinations() {
    return pages.map((page) {
      return NavigationDestination(
        icon: Icon(page['icon'] as IconData),
        label: page['title'] as String,
      );
    }).toList();
  }

  // 获取所有抽屉菜单项
  static List<Widget> getDrawerItems(BuildContext context, RouteManager routeManager) {
    return [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(Icons.monitor, size: 35),
            ),
            SizedBox(height: 10),
            Text(
              'Super Monitor',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
      ...pages.asMap().entries.map((entry) {
        final index = entry.key;
        final page = entry.value;
        return ListTile(
          leading: Icon(page['icon'] as IconData),
          title: Text(page['title'] as String),
          selected: routeManager.currentIndex == index,
          onTap: () {
            routeManager.navigateToIndex(index, context);
            Navigator.pop(context);
          },
        );
      }).toList(),
    ];
  }

  // 获取所有页面组件
  static List<Widget> getScreens() {
    return pages.map((page) => page['screen'] as Widget).toList();
  }

  // 获取页面索引
  static int getPageIndex(String route) {
    return pages.indexWhere((page) => page['route'] == route);
  }

  // 根据索引获取路由
  static String getRouteByIndex(int index) {
    if (index >= 0 && index < pages.length) {
      return pages[index]['route'];
    }
    return home;
  }

  // 获取当前页面标题
  static String getCurrentTitle(int index) {
    return pages[index]['title'] as String;
  }
} 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';
import '../routes/route_manager.dart';
import '../utils/responsive_layout.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteManager>(
      builder: (context, routeManager, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(AppRoutes.getCurrentTitle(routeManager.currentIndex)),
            // 在桌面端不显示抽屉按钮
            leading: ResponsiveLayout.isDesktop(context)
                ? null
                : IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
          ),
          // 在移动端使用抽屉，在桌面端使用永久侧边栏
          drawer: ResponsiveLayout.isDesktop(context)
              ? null
              : Drawer(
                  width: ResponsiveLayout.getDrawerWidth(context),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: AppRoutes.getDrawerItems(context, routeManager),
                  ),
                ),
          body: Row(
            children: [
              // 桌面端的永久侧边栏
              if (ResponsiveLayout.isDesktop(context))
                SizedBox(
                  width: ResponsiveLayout.getSidebarWidth(context),
                  child: Drawer(
                    elevation: 0,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: AppRoutes.getDrawerItems(context, routeManager),
                    ),
                  ),
                ),
              // 主要内容区域
              Expanded(
                child: Padding(
                  padding: ResponsiveLayout.getContentPadding(context),
                  child: IndexedStack(
                    index: routeManager.currentIndex,
                    children: AppRoutes.getScreens(),
                  ),
                ),
              ),
            ],
          ),
          // 在桌面端不显示底部导航栏
          bottomNavigationBar: ResponsiveLayout.isDesktop(context)
              ? null
              : NavigationBar(
                  selectedIndex: routeManager.currentIndex,
                  onDestinationSelected: (index) {
                    routeManager.navigateToIndex(index, context);
                  },
                  destinations: AppRoutes.getNavigationDestinations(),
                ),
        );
      },
    );
  }
} 
import 'package:flutter/material.dart';
import '../components/section_card.dart';
import '../components/platform_badge.dart';
import '../components/stat_item.dart';
import '../components/chart_placeholder.dart';
import '../utils/responsive_layout.dart';

class CreatorScreen extends StatelessWidget {
  const CreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = ResponsiveLayout.isTablet(context) || ResponsiveLayout.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '创作者分析',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: isWide
              ? _buildWideLayout(context)
              : _buildNarrowLayout(context),
        ),
      ],
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左侧面板：创作者信息和增长趋势
        Expanded(
          flex: 2,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildCreatorInfo(),
              const SizedBox(height: 16),
              _buildGrowthTrend(),
            ],
          ),
        ),
        // 右侧面板：互动数据
        Expanded(
          flex: 3,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildEngagementStats(),
              const SizedBox(height: 16),
              _buildPlatformPerformance(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildCreatorInfo(),
        const SizedBox(height: 16),
        _buildGrowthTrend(),
        const SizedBox(height: 16),
        _buildEngagementStats(),
        const SizedBox(height: 16),
        _buildPlatformPerformance(),
      ],
    );
  }

  Widget _buildCreatorInfo() {
    return SectionCard(
      title: '创作者信息',
      padding: const EdgeInsets.all(16.0),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 500;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Creator Name',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@creator_handle',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (isWide)
                        _buildPlatformBadges()
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        const Text(
          '创作者简介和描述信息...',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildPlatformBadges() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PlatformBadge(
          platform: 'YouTube',
          color: Colors.red,
          icon: Icons.play_circle_filled,
        ),
        PlatformBadge(
          platform: 'Instagram',
          color: Colors.pink,
          icon: Icons.camera_alt,
        ),
        PlatformBadge(
          platform: 'Bilibili',
          color: Colors.blue,
          icon: Icons.tv,
        ),
        PlatformBadge(
          platform: 'Pixiv',
          color: Colors.deepPurple,
          icon: Icons.brush,
        ),
      ],
    );
  }

  Widget _buildGrowthTrend() {
    return SectionCard(
      title: '增长趋势',
      padding: const EdgeInsets.all(16.0),
      children: [
        const ChartPlaceholder(label: '增长趋势图表'),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 500;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: isWide ? (constraints.maxWidth - 32) / 3 : (constraints.maxWidth - 16) / 2,
                  child: StatItem(
                    label: '本月新增',
                    value: '+12.5K',
                    color: Colors.green,
                    isLarge: true,
                  ),
                ),
                SizedBox(
                  width: isWide ? (constraints.maxWidth - 32) / 3 : (constraints.maxWidth - 16) / 2,
                  child: StatItem(
                    label: '平均日增',
                    value: '+416',
                    color: Colors.blue,
                    isLarge: true,
                  ),
                ),
                SizedBox(
                  width: isWide ? (constraints.maxWidth - 32) / 3 : (constraints.maxWidth - 16) / 2,
                  child: StatItem(
                    label: '增长率',
                    value: '+2.3%',
                    color: Colors.orange,
                    isLarge: true,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildEngagementStats() {
    return SectionCard(
      title: '互动数据',
      padding: const EdgeInsets.all(16.0),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 500;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: isWide ? (constraints.maxWidth - 32) / 3 : (constraints.maxWidth - 16) / 2,
                  child: StatItem(
                    label: '平均点赞',
                    value: '25.6K',
                    icon: Icons.thumb_up,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: isWide ? (constraints.maxWidth - 32) / 3 : (constraints.maxWidth - 16) / 2,
                  child: StatItem(
                    label: '评论率',
                    value: '3.2%',
                    icon: Icons.comment,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  width: isWide ? (constraints.maxWidth - 32) / 3 : (constraints.maxWidth - 16) / 2,
                  child: StatItem(
                    label: '分享率',
                    value: '1.8%',
                    icon: Icons.share,
                    color: Colors.orange,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPlatformPerformance() {
    return SectionCard(
      title: '平台表现',
      padding: const EdgeInsets.all(16.0),
      children: [
        const ChartPlaceholder(
          label: '平台数据对比图表',
          height: 300,
        ),
      ],
    );
  }
} 
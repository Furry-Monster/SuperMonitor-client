import 'package:flutter/material.dart';
import '../components/section_card.dart';
import '../components/stat_item.dart';
import '../components/platform_badge.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '创作者数据总览',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildPlatformStats(
                platform: 'YouTube',
                icon: Icons.play_circle_filled,
                color: Colors.red,
                stats: {
                  '订阅数': '1.2M',
                  '总观看': '5.6M',
                  '视频数': '128',
                  '最近更新': '2小时前',
                },
              ),
              const SizedBox(height: 16),
              _buildPlatformStats(
                platform: 'Instagram',
                icon: Icons.camera_alt,
                color: Colors.pink,
                stats: {
                  '关注者': '856K',
                  '帖子数': '521',
                  '平均点赞': '25.6K',
                  '最近更新': '6小时前',
                },
              ),
              _buildPlatformStats(
                platform: 'Bilibili',
                icon: Icons.tv,
                color: Colors.blue,
                stats: {
                  '粉丝数': '500K',
                  '播放量': '2.8M',
                  '视频数': '89',
                  '最近更新': '1天前',
                },
              ),
              _buildPlatformStats(
                platform: 'Pixiv',
                icon: Icons.brush,
                color: Colors.deepPurple,
                stats: {
                  '关注者': '12.5K',
                  '作品数': '234',
                  '总收藏': '45.6K',
                  '最近更新': '3天前',
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformStats({
    required String platform,
    required IconData icon,
    required Color color,
    required Map<String, String> stats,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        
        return SectionCard(
          title: platform,
          padding: const EdgeInsets.all(16.0),
          onMoreTap: () {
            // 跳转到详细数据页面
          },
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(width: 12),
                PlatformBadge(
                  platform: platform,
                  color: color,
                  icon: icon,
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isWide ? 4 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isWide ? 2.0 : 2.5,
              children: stats.entries.map((entry) {
                return StatItem(
                  label: entry.key,
                  value: entry.value,
                  color: color,
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
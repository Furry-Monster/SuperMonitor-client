import 'package:flutter/material.dart';
import '../components/section_card.dart';
import '../components/platform_badge.dart';
import '../components/stat_item.dart';
import '../components/chart_placeholder.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPlatform = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '内容分析',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        _buildPlatformFilter(),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '最新内容'),
            Tab(text: '热门内容'),
            Tab(text: '数据分析'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildLatestContent(),
              _buildPopularContent(),
              _buildAnalytics(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlatformFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          _buildFilterChip('全部平台', 'all'),
          _buildFilterChip('YouTube', 'youtube'),
          _buildFilterChip('Instagram', 'instagram'),
          _buildFilterChip('Bilibili', 'bilibili'),
          _buildFilterChip('Pixiv', 'pixiv'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        selected: _selectedPlatform == value,
        label: Text(label),
        onSelected: (bool selected) {
          setState(() {
            _selectedPlatform = value;
          });
        },
      ),
    );
  }

  Widget _buildLatestContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildContentItem(
          title: '内容标题 ${index + 1}',
          platform: 'YouTube',
          type: '视频',
          time: '${index + 1}小时前',
          stats: {
            '观看': '1.2K',
            '点赞': '256',
            '评论': '32',
          },
          color: Colors.red,
        );
      },
    );
  }

  Widget _buildPopularContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildContentItem(
          title: '热门内容 ${index + 1}',
          platform: 'Bilibili',
          type: '视频',
          time: '${index + 1}天前',
          stats: {
            '观看': '12.5K',
            '点赞': '2.3K',
            '评论': '456',
          },
          color: Colors.blue,
          isPopular: true,
        );
      },
    );
  }

  Widget _buildAnalytics() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        SectionCard(
          title: '内容表现',
          padding: const EdgeInsets.all(16.0),
          children: [
            const ChartPlaceholder(label: '内容表现趋势图'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatItem(
                  label: '平均观看时长',
                  value: '4:35',
                  icon: Icons.timer,
                  color: Colors.blue,
                ),
                StatItem(
                  label: '平均互动率',
                  value: '8.2%',
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
                StatItem(
                  label: '完播率',
                  value: '65%',
                  icon: Icons.play_circle,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: '最佳发布时间',
          padding: const EdgeInsets.all(16.0),
          children: [
            const ChartPlaceholder(
              label: '发布时间热力图',
              height: 150,
            ),
          ],
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: '内容分类分析',
          padding: const EdgeInsets.all(16.0),
          children: [
            const ChartPlaceholder(
              label: '内容分类分析图表',
              height: 150,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentItem({
    required String title,
    required String platform,
    required String type,
    required String time,
    required Map<String, String> stats,
    required Color color,
    bool isPopular = false,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        
        return SectionCard(
          title: title,
          padding: const EdgeInsets.all(16.0),
          children: [
            Row(
              children: [
                PlatformBadge(
                  platform: platform,
                  color: color,
                  icon: platform == 'YouTube'
                      ? Icons.play_circle_filled
                      : platform == 'Bilibili'
                          ? Icons.tv
                          : Icons.image,
                ),
                const SizedBox(width: 8),
                Text(type),
                const Spacer(),
                if (isPopular)
                  const Icon(Icons.trending_up, color: Colors.red),
                const SizedBox(width: 8),
                Text(time),
              ],
            ),
            const SizedBox(height: 16),
            isWide
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: stats.entries.map((entry) {
                      return Expanded(
                        child: StatItem(
                          label: entry.key,
                          value: entry.value,
                          color: color,
                        ),
                      );
                    }).toList(),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: stats.entries.map((entry) {
                      return SizedBox(
                        width: (constraints.maxWidth - 24) / 2,
                        child: StatItem(
                          label: entry.key,
                          value: entry.value,
                          color: color,
                        ),
                      );
                    }).toList(),
                  ),
          ],
        );
      },
    );
  }
} 
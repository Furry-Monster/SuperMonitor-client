import 'package:flutter/material.dart';
import '../components/section_card.dart';
import '../components/platform_item.dart';
import '../components/settings_item.dart';
import '../utils/responsive_layout.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';
import '../l10n/language_manager.dart';
import '../l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _autoRefresh = true;
  int _refreshInterval = 30;
  bool _notifications = true;
  String _exportFormat = 'JSON';
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final isWide = ResponsiveLayout.isTablet(context) || ResponsiveLayout.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: ResponsiveLayout.getContentPadding(context),
          child: const Text(
            '设置',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: isWide ? _buildWideLayout() : _buildNarrowLayout(),
        ),
      ],
    );
  }

  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左侧面板：账号和数据设置
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildAccountsSection(),
              const SizedBox(height: 16),
              _buildDataSection(),
              const SizedBox(height: 16),
              _buildExportSection(),
            ],
          ),
        ),
        // 右侧面板：通知、外观和其他设置
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildNotificationSection(),
              const SizedBox(height: 16),
              _buildAppearanceSection(),
              const SizedBox(height: 16),
              _buildAboutSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildAccountsSection(),
        const SizedBox(height: 16),
        _buildDataSection(),
        const SizedBox(height: 16),
        _buildNotificationSection(),
        const SizedBox(height: 16),
        _buildAppearanceSection(),
        const SizedBox(height: 16),
        _buildExportSection(),
        const SizedBox(height: 16),
        _buildAboutSection(),
      ],
    );
  }

  Widget _buildAccountsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return SectionCard(
          title: '账号管理',
          children: [
            if (isWide)
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _buildPlatformItems(),
              )
            else
              Column(
                children: _buildPlatformItems(),
              ),
          ],
        );
      },
    );
  }

  List<Widget> _buildPlatformItems() {
    return [
      PlatformItem(
        name: 'YouTube',
        icon: Icons.play_circle_filled,
        color: Colors.red,
        subtitle: '已连接',
        trailing: TextButton(
          onPressed: () => _handleAccountAction('YouTube', true),
          child: const Text('断开'),
        ),
      ),
      PlatformItem(
        name: 'Instagram',
        icon: Icons.camera_alt,
        color: Colors.pink,
        subtitle: '未连接',
        trailing: TextButton(
          onPressed: () => _handleAccountAction('Instagram', false),
          child: const Text('连接'),
        ),
      ),
      PlatformItem(
        name: 'Bilibili',
        icon: Icons.tv,
        color: Colors.blue,
        subtitle: '已连接',
        trailing: TextButton(
          onPressed: () => _handleAccountAction('Bilibili', true),
          child: const Text('断开'),
        ),
      ),
      PlatformItem(
        name: 'Pixiv',
        icon: Icons.brush,
        color: Colors.deepPurple,
        subtitle: '未连接',
        trailing: TextButton(
          onPressed: () => _handleAccountAction('Pixiv', false),
          child: const Text('连接'),
        ),
      ),
    ];
  }

  Widget _buildDataSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        return SectionCard(
          title: '数据设置',
          children: [
            if (isWide)
              Row(
                children: [
                  Expanded(
                    child: SettingsItem(
                      title: '自动刷新',
                      subtitle: '定期更新数据',
                      leading: const Icon(Icons.refresh),
                      trailing: Switch(
                        value: _autoRefresh,
                        onChanged: (value) {
                          setState(() {
                            _autoRefresh = value;
                          });
                        },
                      ),
                    ),
                  ),
                  if (_autoRefresh)
                    Expanded(
                      child: SettingsItem(
                        title: '刷新间隔',
                        subtitle: '$_refreshInterval 分钟',
                        leading: const Icon(Icons.timer),
                        trailing: SizedBox(
                          width: 120,
                          child: Slider(
                            min: 5,
                            max: 120,
                            divisions: 23,
                            label: '$_refreshInterval 分钟',
                            value: _refreshInterval.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                _refreshInterval = value.round();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              )
            else
              Column(
                children: [
                  SettingsItem(
                    title: '自动刷新',
                    subtitle: '定期更新数据',
                    leading: const Icon(Icons.refresh),
                    trailing: Switch(
                      value: _autoRefresh,
                      onChanged: (value) {
                        setState(() {
                          _autoRefresh = value;
                        });
                      },
                    ),
                  ),
                  if (_autoRefresh)
                    SettingsItem(
                      title: '刷新间隔',
                      subtitle: '$_refreshInterval 分钟',
                      leading: const Icon(Icons.timer),
                      trailing: SizedBox(
                        width: 200,
                        child: Slider(
                          min: 5,
                          max: 120,
                          divisions: 23,
                          label: '$_refreshInterval 分钟',
                          value: _refreshInterval.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              _refreshInterval = value.round();
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
            SettingsItem(
              title: '清除缓存',
              subtitle: '删除本地存储的数据',
              leading: const Icon(Icons.delete_outline),
              onTap: _handleClearCache,
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotificationSection() {
    return SectionCard(
      title: '通知设置',
      children: [
        SettingsItem(
          title: '启用通知',
          subtitle: '接收重要更新提醒',
          leading: const Icon(Icons.notifications),
          trailing: Switch(
            value: _notifications,
            onChanged: (value) {
              setState(() {
                _notifications = value;
              });
            },
          ),
        ),
        if (_notifications) ...[
          SettingsItem(
            title: '新内容提醒',
            leading: const Icon(Icons.new_releases),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _configureNotification('新内容'),
          ),
          SettingsItem(
            title: '数据异常提醒',
            leading: const Icon(Icons.warning),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _configureNotification('数据异常'),
          ),
          SettingsItem(
            title: '重要里程碑',
            leading: const Icon(Icons.emoji_events),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _configureNotification('里程碑'),
          ),
        ],
      ],
    );
  }

  Widget _buildAppearanceSection() {
    return Consumer2<ThemeManager, LanguageManager>(
      builder: (context, themeManager, languageManager, child) {
        return SectionCard(
          title: AppLocalizations.of(context).appearance,
          children: [
            // 主题模式设置
            SettingsItem(
              title: AppLocalizations.of(context).darkMode,
              subtitle: themeManager.isDarkMode 
                  ? AppLocalizations.of(context).enabled 
                  : AppLocalizations.of(context).disabled,
              leading: Icon(
                themeManager.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: themeManager.isDarkMode ? Colors.blue : Colors.orange,
              ),
              trailing: Switch(
                value: themeManager.isDarkMode,
                onChanged: (value) {
                  themeManager.toggleTheme();
                },
              ),
            ),
            // 跟随系统主题设置
            SettingsItem(
              title: AppLocalizations.of(context).followSystem,
              subtitle: AppLocalizations.of(context).systemDefault,
              leading: const Icon(Icons.brightness_auto),
              trailing: Switch(
                value: themeManager.themeMode == ThemeMode.system,
                onChanged: (value) {
                  themeManager.setThemeMode(
                    value ? ThemeMode.system : (themeManager.isDarkMode ? ThemeMode.dark : ThemeMode.light),
                  );
                },
              ),
            ),
            // 主题颜色设置
            SettingsItem(
              title: AppLocalizations.of(context).themeColor,
              subtitle: AppLocalizations.of(context).customTheme,
              leading: const Icon(Icons.color_lens),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showColorPicker(context),
            ),
            // 语言设置
            SettingsItem(
              title: AppLocalizations.of(context).language,
              subtitle: LanguageManager.languageNames[languageManager.locale.languageCode],
              leading: const Icon(Icons.translate),
              trailing: DropdownButton<String>(
                value: languageManager.locale.languageCode,
                underline: const SizedBox(),
                items: [
                  // 跟随系统选项
                  DropdownMenuItem(
                    value: 'system',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.phone_android, size: 18),
                        const SizedBox(width: 8),
                        Text('System'),
                      ],
                    ),
                  ),
                  // 支持的语言选项
                  ...LanguageManager.supportedLocales.map((locale) {
                    return DropdownMenuItem(
                      value: locale.languageCode,
                      child: Text(LanguageManager.languageNames[locale.languageCode]!),
                    );
                  }),
                ],
                onChanged: (value) {
                  if (value == 'system') {
                    languageManager.setFollowSystem(true);
                  } else if (value != null) {
                    languageManager.setLocale(Locale(value));
                  }
                },
              ),
              showDivider: false,
            ),
          ],
        );
      },
    );
  }

  Widget _buildExportSection() {
    return SectionCard(
      title: '数据导出',
      children: [
        SettingsItem(
          title: '导出格式',
          subtitle: _exportFormat,
          leading: const Icon(Icons.file_present),
          trailing: PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _exportFormat = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'JSON',
                child: Text('JSON'),
              ),
              const PopupMenuItem(
                value: 'CSV',
                child: Text('CSV'),
              ),
              const PopupMenuItem(
                value: 'Excel',
                child: Text('Excel'),
              ),
            ],
          ),
        ),
        SettingsItem(
          title: '导出数据',
          subtitle: '导出所有平台数据',
          leading: const Icon(Icons.download),
          onTap: _handleExportData,
          showDivider: false,
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return SectionCard(
      title: '关于',
      children: [
        SettingsItem(
          title: '版本信息',
          subtitle: 'v1.0.0',
          leading: const Icon(Icons.info),
          onTap: _showAboutDialog,
        ),
        SettingsItem(
          title: '帮助与支持',
          leading: const Icon(Icons.help),
          onTap: _showHelpPage,
          showDivider: false,
        ),
      ],
    );
  }

  void _handleAccountAction(String platform, bool isConnected) {
    // 处理账号连接/断开逻辑
  }

  void _handleClearCache() {
    // 处理清除缓存逻辑
  }

  void _configureNotification(String type) {
    // 配置具体的通知类型
  }

  void _handleExportData() {
    // 处理数据导出逻辑
  }

  void _showAboutDialog() {
    // 显示关于对话框
  }

  void _showHelpPage() {
    // 显示帮助页面
  }

  void _showColorPicker(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context, listen: false);
    final List<ColorOption> colors = [
      ColorOption(Colors.blue, '蓝色'),
      ColorOption(Colors.green, '绿色'),
      ColorOption(Colors.purple, '紫色'),
      ColorOption(Colors.orange, '橙色'),
      ColorOption(Colors.red, '红色'),
      ColorOption(Colors.teal, '青色'),
      ColorOption(Colors.pink, '粉色'),
      ColorOption(Colors.indigo, '靛蓝'),
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('选择主题色彩'),
          content: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: colors.map((colorOption) {
              final bool isSelected = themeManager.themeColor.value == colorOption.color.value;
              return InkWell(
                onTap: () {
                  themeManager.setThemeColor(colorOption.color);
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorOption.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? colorOption.color : Colors.grey.withOpacity(0.3),
                      width: isSelected ? 3 : 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
          contentPadding: const EdgeInsets.all(20),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
          ],
        );
      },
    );
  }
}

// 添加一个颜色选项类来管理颜色和名称
class ColorOption {
  final Color color;
  final String name;

  const ColorOption(this.color, this.name);
} 
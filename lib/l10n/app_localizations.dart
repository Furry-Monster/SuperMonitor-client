import 'package:flutter/material.dart';
import 'strings/zh.dart';
import 'strings/en.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': enStrings,
    'zh': zhStrings,
  };

  String get title => _localizedValues[locale.languageCode]?['title'] ?? '';
  String get home => _localizedValues[locale.languageCode]?['home'] ?? '';
  String get content => _localizedValues[locale.languageCode]?['content'] ?? '';
  String get creator => _localizedValues[locale.languageCode]?['creator'] ?? '';
  String get settings => _localizedValues[locale.languageCode]?['settings'] ?? '';

  // 平台相关
  String get youtube => _localizedValues[locale.languageCode]?['youtube'] ?? '';
  String get instagram => _localizedValues[locale.languageCode]?['instagram'] ?? '';
  String get bilibili => _localizedValues[locale.languageCode]?['bilibili'] ?? '';
  String get pixiv => _localizedValues[locale.languageCode]?['pixiv'] ?? '';

  // 统计相关
  String get followers => _localizedValues[locale.languageCode]?['followers'] ?? '';
  String get views => _localizedValues[locale.languageCode]?['views'] ?? '';
  String get likes => _localizedValues[locale.languageCode]?['likes'] ?? '';
  String get comments => _localizedValues[locale.languageCode]?['comments'] ?? '';

  // 设置相关
  String get appearance => _localizedValues[locale.languageCode]?['appearance'] ?? '';
  String get darkMode => _localizedValues[locale.languageCode]?['darkMode'] ?? '';
  String get language => _localizedValues[locale.languageCode]?['language'] ?? '';
  String get about => _localizedValues[locale.languageCode]?['about'] ?? '';

  // 语言相关
  String get followSystem => _localizedValues[locale.languageCode]?['followSystem'] ?? '';
  String get enabled => _localizedValues[locale.languageCode]?['enabled'] ?? '';
  String get disabled => _localizedValues[locale.languageCode]?['disabled'] ?? '';
  String get systemDefault => _localizedValues[locale.languageCode]?['systemDefault'] ?? '';

  // 新增字符串
  String get themeColor => _localizedValues[locale.languageCode]?['themeColor'] ?? '';
  String get customTheme => _localizedValues[locale.languageCode]?['customTheme'] ?? '';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 
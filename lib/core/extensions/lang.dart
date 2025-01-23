enum Languages { ar, en }

extension LangExtension on Languages {
  String get toLanguageKey {
    switch (this) {
      case Languages.ar:
        return 'ar';
      case Languages.en:
        return 'en';
    }
  }

  String get name {
    switch (this) {
      case Languages.ar:
        return 'العربية';
      case Languages.en:
        return 'English';
    }
  }
}


class CommonMethods {
  String? getBaseUrl(String flavor) {
    switch (flavor) {
      case 'dev':
        return 'https://cws.com';
      case 'test':
        return 'https://cws.com';
      case 'uat':
        return 'https://cws.com';
      default:
        return 'https://cws.com';
    }
  }
}

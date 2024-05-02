enum AppRealms {
  none._('none', 'assets/images/realms/none.png'),
  fantasy._('Fantasy Realm', 'assets/images/realms/fantasy.png'),
  greek._('Greek Mythic Realm', 'assets/images/realms/greek.png'),
  cyberpunk._('Cyberpunk Realm', 'assets/images/realms/cyberpunk.png');

  final String label;
  final String image;

  const AppRealms._(this.label, this.image);
}

final List<String> linkTypes = [
  'merch',
  'twitter',
  'reddit',
  'discord',
  'instagram',
  'snapchat',
  'patreon',
  'bandcamp',
  'website',
  'other',
];

final Map<String, String> linkNames = {
  'merch': 'Merch',
  'twitter': 'Twitter',
  'reddit': 'Reddit',
  'discord': 'Discord',
  'instagram': 'Instagram',
  'snapchat': 'Snapchat',
  'patreon': 'Patreon',
  'bandcamp': 'Bandcamp',
  'website': 'Website',
  'other': 'Other',
};

class Link {
  String name;
  String type;
  String url;

  Link(Map map) {
    if (map.containsKey('name')) {
      name = map['name'] as String;
    }
    if (map.containsKey('type')) {
      type = map['type'] as String;
    }
    if (map.containsKey('url')) {
      url = map['url'] as String;
    }
  }

  String get lastUrlPart {
    switch (type) {
      case 'reddit':
        String s = url.split('com')[1];
        if (s.endsWith('/')) {
          return s.substring(1, s.length - 1);
        }
        return s.substring(1);
      case 'twitter':
        String s = url.split('com')[1];
        return s.substring(1);
      default:
        return '';
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'type': type,
        'url': url,
      };
}

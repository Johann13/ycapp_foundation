class AdminUser {
  final String id;
  final String email;
  final bool admin;
  final List<String> creator;
  final List<String> youtube;
  final List<String> twitch;
  final bool _jjSchedule;
  final bool _mainSchedule;
  final bool _canSendNotifications;

  AdminUser._(
    this.id,
    this.email,
    this.admin,
    this.creator,
    this.twitch,
    this.youtube,
    this._jjSchedule,
    this._mainSchedule,
    this._canSendNotifications,
  );

  factory AdminUser(Map<String, dynamic> map) {
    String id = map['id'] as String;
    String email = map['email'] as String;
    bool admin = map['admin'] as bool;
    List<String> creator = [];
    List<String> twitch = [];
    List<String> youtube = [];
    if (map.containsKey('creator')) {
      creator =
          (map['creator'] as List).map((dynamic e) => e as String).toList();
    }
    if (map.containsKey('twitch')) {
      twitch = (map['twitch'] as List).map((dynamic e) => e as String).toList();
    }
    if (map.containsKey('youtube')) {
      youtube =
          (map['youtube'] as List).map((dynamic e) => e as String).toList();
    }

    bool jjSchedule, mainSchedule;
    if (map.containsKey('jjSchedule')) {
      jjSchedule = map['jjSchedule'] as bool;
    } else {
      jjSchedule = false;
    }

    if (map.containsKey('mainSchedule')) {
      mainSchedule = map['mainSchedule'] as bool;
    } else {
      mainSchedule = false;
    }
    bool canSendNotifications;
    if (map.containsKey('canSendNotifications')) {
      canSendNotifications = map['canSendNotifications'] as bool;
    } else {
      canSendNotifications = false;
    }
    return AdminUser._(
      id,
      email,
      admin,
      creator,
      twitch,
      youtube,
      jjSchedule,
      mainSchedule,
      canSendNotifications,
    );
  }

  bool get jjSchedule => _jjSchedule || admin;

  bool get mainSchedule => _mainSchedule || admin;

  bool get canSendNotifications => _canSendNotifications || admin;
}

class Access {
  List<CreatorAccess> creator;

  Access(Map<String, dynamic> map) {}
}

class CreatorAccess {
  String id;
  bool edit;
  bool notification;
}

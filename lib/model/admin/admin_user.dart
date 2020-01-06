class AdminUser {
  final String id;
  final String email;
  final bool admin;
  final List<String> creator;
  final bool _jjSchedule;
  final bool _mainSchedule;
  final bool _canSendNotifications;

  AdminUser._(this.id, this.email, this.admin, this.creator, this._jjSchedule,
      this._mainSchedule, this._canSendNotifications);

  factory AdminUser(Map map) {
    String id = map['id'];
    String email = map['email'];
    bool admin = map['admin'];
    List<String> creator = map['creator'] ?? [];
    bool jjSchedule, mainSchedule;
    if (map.containsKey('jjSchedule')) {
      jjSchedule = map['jjSchedule'];
    } else {
      jjSchedule = false;
    }

    if (map.containsKey('mainSchedule')) {
      mainSchedule = map['mainSchedule'];
    } else {
      mainSchedule = false;
    }
    bool canSendNotifications;
    if (map.containsKey('canSendNotifications')) {
      canSendNotifications = map['canSendNotifications'];
    } else {
      canSendNotifications = false;
    }
    return AdminUser._(
      id,
      email,
      admin,
      creator,
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

  Access(Map map) {}
}

class CreatorAccess {
  String id;
  bool edit;
  bool notification;
}

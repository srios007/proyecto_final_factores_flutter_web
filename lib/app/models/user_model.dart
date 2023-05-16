class User {
  String? id;
  DateTime? created;
  String? enail;
  String? profilePictureUrl;
  String? name;
  String? lastname;

  User({
    this.id,
    this.created,
    this.enail,
    this.profilePictureUrl,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'].toDate();
    enail = json['enail'];
    profilePictureUrl = json['profilePictureUrl'];
    name = json['name'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['enail'] = enail;
    data['profilePictureUrl'] = profilePictureUrl;
    data['name'] = name;
    data['lastname'] = lastname;

    return data;
  }
}

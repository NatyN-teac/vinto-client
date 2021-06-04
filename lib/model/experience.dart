

class Experience {
  String name;
  String description;
  bool archived;
  Null archivedAt;
  String createdAt;
  Null updatedAt;
  String sId;
  CreatedBy createdBy;

  Experience(
      {this.name,
        this.description,
        this.archived,
        this.archivedAt,
        this.createdAt,
        this.updatedAt,
        this.sId,
        this.createdBy});

  Experience.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    archived = json['archived'];
    archivedAt = json['archived_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['archived'] = this.archived;
    data['archived_at'] = this.archivedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_id'] = this.sId;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy.toJson();
    }
    return data;
  }
}

class CreatedBy {
  bool archived;
  Null archivedAt;
  String sId;
  String username;
  String role;
  String internal;
  String lastLogin;

  CreatedBy(
      {this.archived,
        this.archivedAt,
        this.sId,
        this.username,
        this.role,
        this.internal,
        this.lastLogin});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    archived = json['archived'];
    archivedAt = json['archived_at'];
    sId = json['_id'];
    username = json['username'];
    role = json['role'];
    internal = json['internal'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['archived'] = this.archived;
    data['archived_at'] = this.archivedAt;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['role'] = this.role;
    data['internal'] = this.internal;
    data['last_login'] = this.lastLogin;
    return data;
  }
}

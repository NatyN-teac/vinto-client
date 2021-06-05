class UserModel {
  String token;
  User user;

  UserModel({this.token, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  bool archived;
  String archivedAt;
  String sId;
  String email;
  String role;
  Client client;
  String lastLogin;

  User(
      {this.archived,
      this.archivedAt,
      this.sId,
      this.email,
      this.role,
      this.client,
      this.lastLogin});

  User.fromJson(Map<String, dynamic> json) {
    archived = json['archived'];
    archivedAt = json['archived_at'];
    sId = json['_id'];
    email = json['email'];
    role = json['role'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['archived'] = this.archived;
    data['archived_at'] = this.archivedAt;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['role'] = this.role;
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    data['last_login'] = this.lastLogin;
    return data;
  }
}

class Client {
  Location location;
  String picture;
  num longtiude;
  num latitude;
  String firstName;
  String lastName;
  String email;
  String phone;
  String dateOfBirth;
  String ssn;
  String idNumber;
  String carMake;
  String isAvailable;
  String country;
  String userType;
  String updatedAt;
  String sId;
  String createdAt;
  String user;
  String username;

  Client(
      {this.location,
      this.picture,
      this.longtiude,
      this.latitude,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.dateOfBirth,
      this.ssn,
      this.idNumber,
      this.carMake,
      this.isAvailable,
      this.country,
      this.userType,
      this.updatedAt,
      this.sId,
      this.createdAt,
      this.user,
      this.username});

  Client.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    picture = json['picture'];
    longtiude = json['longtiude'];
    latitude = json['latitude'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    ssn = json['ssn'];
    idNumber = json['id_number'];
    carMake = json['car_make'];
    isAvailable = json['is_available'];
    country = json['country'];
    userType = json['user_type'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    createdAt = json['created_at'];
    user = json['user'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['picture'] = this.picture;
    data['longtiude'] = this.longtiude;
    data['latitude'] = this.latitude;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['date_of_birth'] = this.dateOfBirth;
    data['ssn'] = this.ssn;
    data['id_number'] = this.idNumber;
    data['car_make'] = this.carMake;
    data['is_available'] = this.isAvailable;
    data['country'] = this.country;
    data['user_type'] = this.userType;
    data['updated_at'] = this.updatedAt;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    data['user'] = this.user;
    data['username'] = this.username;
    return data;
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

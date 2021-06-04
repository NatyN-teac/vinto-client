import 'package:vinto/model/user.dart';

class Product {
  String name;
  String description;
  num price;
  int rating;
  String image;
  List<PInterest> interest;
  List<PExperience> experience;
  List<PMood> mood;
  List<PTaste> taste;
  bool archived;
  String archivedAt;
  String updatedAt;
  String sId;
  String createdAt;
  CreatedBy createdBy;

  Product(
      {this.name,
        this.description,
        this.price,
        this.rating,
        this.image,
        this.interest,
        this.experience,
        this.mood,
        this.taste,
        this.archived,
        this.archivedAt,
        this.updatedAt,
        this.sId,
        this.createdAt,
        this.createdBy});

  Product.fromJson(Map<String, dynamic> json) {
    print("json value: ${json['price']}");
    name = json['name'];
    description = json['description'];
    price = json['price'];
    rating = json['rating'];
    image = json['image'];
    if (json['interest'] != null) {
      interest = new List<PInterest>();
      json['interest'].forEach((v) {
        interest.add(new PInterest.fromJson(v));
      });
    }
    if (json['experience'] != null) {
      experience = new List<PExperience>();
      json['experience'].forEach((v) {
        experience.add(new PExperience.fromJson(v));
      });
    }
    if (json['mood'] != null) {
      mood = new List<PMood>();
      json['mood'].forEach((v) {
        mood.add(new PMood.fromJson(v));
      });
    }
    if (json['taste'] != null) {
      taste = new List<PTaste>();
      json['taste'].forEach((v) {
        taste.add(new PTaste.fromJson(v));
      });
    }
    archived = json['archived'];
    archivedAt = json['archived_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    createdAt = json['created_at'];
    createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['image'] = this.image;
    if (this.interest != null) {
      data['interest'] = this.interest.map((v) => v.toJson()).toList();
    }
    if (this.experience != null) {
      data['experience'] = this.experience.map((v) => v.toJson()).toList();
    }
    if (this.mood != null) {
      data['mood'] = this.mood.map((v) => v.toJson()).toList();
    }
    if (this.taste != null) {
      data['taste'] = this.taste.map((v) => v.toJson()).toList();
    }
    data['archived'] = this.archived;
    data['archived_at'] = this.archivedAt;
    data['updated_at'] = this.updatedAt;
    data['_id'] = this.sId;
    data['created_at'] = this.createdAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy.toJson();
    }
    return data;
  }
}

class PInterest {
  String name;
  String description;
  bool archived;
  Null archivedAt;
  String createdAt;
  Null updatedAt;
  String sId;
  String picture;
  String createdBy;

  PInterest(
      {this.name,
        this.description,
        this.archived,
        this.archivedAt,
        this.createdAt,
        this.updatedAt,
        this.sId,
        this.picture,
        this.createdBy});

  PInterest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    archived = json['archived'];
    archivedAt = json['archived_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    picture = json['picture'];
    createdBy = json['created_by'];
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
    data['picture'] = this.picture;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class PExperience {
  String name;
  String description;
  bool archived;
  Null archivedAt;
  String createdAt;
  Null updatedAt;
  String sId;
  String createdBy;

  PExperience(
      {this.name,
        this.description,
        this.archived,
        this.archivedAt,
        this.createdAt,
        this.updatedAt,
        this.sId,
        this.createdBy});

  PExperience.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    archived = json['archived'];
    archivedAt = json['archived_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    createdBy = json['created_by'];
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
    data['created_by'] = this.createdBy;
    return data;
  }
}
class PMood {
  String name;
  String description;
  bool archived;
  String archivedAt;
  String createdAt;
  String updatedAt;
  String sId;
  String createdBy;

  PMood(
      {this.name,
        this.description,
        this.archived,
        this.archivedAt,
        this.createdAt,
        this.updatedAt,
        this.sId,
        this.createdBy});

  PMood.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    archived = json['archived'];
    archivedAt = json['archived_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    createdBy = json['created_by'];
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
      data['created_by'] = this.createdBy;
    }
    return data;
  }
}

class PTaste {
  String name;
  String description;
  bool archived;
  Null archivedAt;
  String createdAt;
  Null updatedAt;
  String sId;
  String createdBy;

  PTaste(
      {this.name,
        this.description,
        this.archived,
        this.archivedAt,
        this.createdAt,
        this.updatedAt,
        this.sId,
        this.createdBy});

  PTaste.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    archived = json['archived'];
    archivedAt = json['archived_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    createdBy = json['created_by'] ;
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
      data['created_by'] = this.createdBy;
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
  Client client;
  String lastLogin;

  CreatedBy(
      {this.archived,
        this.archivedAt,
        this.sId,
        this.username,
        this.role,
        this.client,
        this.lastLogin});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    archived = json['archived'];
    archivedAt = json['archived_at'];
    sId = json['_id'];
    username = json['username'];
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
    data['username'] = this.username;
    data['role'] = this.role;
    if (this.client != null) {
      data['client'] = this.client.toJson();
    }
    data['last_login'] = this.lastLogin;
    return data;
  }
}

// class Client {
//   Location location;
//   String picture;
//   num longtiude;
//   num latitude;
//   String place;
//   String firstName;
//   String lastName;
//   String email;
//   String phone;
//   String dateOfBirth;
//   String ssn;
//   String idNumber;
//   String carMake;
//   String isAvailable;
//   String country;
//   String userType;
//   String updatedAt;
//   String sId;
//   String createdAt;
//   String user;
//
//   Client(
//       {this.location,
//         this.picture,
//         this.longtiude,
//         this.latitude,
//         this.place,
//         this.firstName,
//         this.lastName,
//         this.email,
//         this.phone,
//         this.dateOfBirth,
//         this.ssn,
//         this.idNumber,
//         this.carMake,
//         this.isAvailable,
//         this.country,
//         this.userType,
//         this.updatedAt,
//         this.sId,
//         this.createdAt,
//         this.user});
//
//   Client.fromJson(Map<String, dynamic> json) {
//     location = json['location'] != null
//         ? new Location.fromJson(json['location'])
//         : null;
//     picture = json['picture'];
//     longtiude = json['longtiude'];
//     latitude = json['latitude'];
//     place = json['place'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     phone = json['phone'];
//     dateOfBirth = json['date_of_birth'];
//     ssn = json['ssn'];
//     idNumber = json['id_number'];
//     carMake = json['car_make'];
//     isAvailable = json['is_available'];
//     country = json['country'];
//     userType = json['user_type'];
//     updatedAt = json['updated_at'];
//     sId = json['_id'];
//     createdAt = json['created_at'];
//     user = json['user'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.location != null) {
//       data['location'] = this.location.toJson();
//     }
//     data['picture'] = this.picture;
//     data['longtiude'] = this.longtiude;
//     data['latitude'] = this.latitude;
//     data['place'] = this.place;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['ssn'] = this.ssn;
//     data['id_number'] = this.idNumber;
//     data['car_make'] = this.carMake;
//     data['is_available'] = this.isAvailable;
//     data['country'] = this.country;
//     data['user_type'] = this.userType;
//     data['updated_at'] = this.updatedAt;
//     data['_id'] = this.sId;
//     data['created_at'] = this.createdAt;
//     data['user'] = this.user;
//     return data;
//   }
// }

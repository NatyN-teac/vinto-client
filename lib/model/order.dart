import 'package:vinto/model/product.dart';

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class Order {
  String productOwner;
  AssignedFor assignedFor;
  bool isAccepted;
  Null archivedAt;
  Null updatedAt;
  String sId;
  AssignedFor orderBy;
  Product product;
  String createdAt;
  CreatedBy createdBy;

  Order(
      {this.productOwner,
      this.assignedFor,
      this.isAccepted,
      this.archivedAt,
      this.updatedAt,
      this.sId,
      this.orderBy,
      this.product,
      this.createdAt,
      this.createdBy});

  Order.fromJson(Map<String, dynamic> json) {
    productOwner = json['product_owner'];
    assignedFor = json['assigned_for'] != null
        ? new AssignedFor.fromJson(json['assigned_for'])
        : null;
    isAccepted = json['is_accepted'];
    archivedAt = json['archived_at'];
    updatedAt = json['updated_at'];
    sId = json['_id'];
    orderBy = json['order_by'] != null
        ? new AssignedFor.fromJson(json['order_by'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    createdAt = json['created_at'];
    createdBy = createdBy = json['created_by'] != null
        ? new CreatedBy.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_owner'] = this.productOwner;
    if (this.assignedFor != null) {
      data['assigned_for'] = this.assignedFor.toJson();
    }
    data['is_accepted'] = this.isAccepted;
    data['archived_at'] = this.archivedAt;
    data['updated_at'] = this.updatedAt;
    data['_id'] = this.sId;
    if (this.orderBy != null) {
      data['order_by'] = this.orderBy.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['created_at'] = this.createdAt;
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy.toJson();
    }

    return data;
  }
}

class AssignedFor {
  Location location;
  String picture;
  num longtiude;
  num latitude;
  String place;
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
  String firstName;
  String lastName;
  String createdAt;
  String user;
  String username;

  AssignedFor(
      {this.location,
      this.picture,
      this.longtiude,
      this.latitude,
      this.place,
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
      this.firstName,
      this.lastName,
      this.createdAt,
      this.username,
      this.user});

  AssignedFor.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    picture = json['picture'];
    longtiude = json['longtiude'];
    latitude = json['latitude'];
    place = json['place'];
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
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    data['place'] = this.place;
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
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
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

class Product {
  String name;
  String description;
  double price;
  int rating;
  String image;
  List<PInterest> interest;
  List<PExperience> experience;
  List<PMood> mood;
  List<PTaste> taste;
  bool archived;
  Null archivedAt;
  Null updatedAt;
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

class CreatedBy {
  bool archived;
  Null archivedAt;
  String sId;
  String password;
  String username;
  String role;
  String client;
  String lastLogin;

  CreatedBy(
      {this.archived,
      this.archivedAt,
      this.sId,
      this.password,
      this.username,
      this.role,
      this.client,
      this.lastLogin});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    archived = json['archived'];
    archivedAt = json['archived_at'];
    sId = json['_id'];
    password = json['password'];
    username = json['username'];
    role = json['role'];
    client = json['client'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['archived'] = this.archived;
    data['archived_at'] = this.archivedAt;
    data['_id'] = this.sId;
    data['password'] = this.password;
    data['username'] = this.username;
    data['role'] = this.role;
    data['client'] = this.client;
    data['last_login'] = this.lastLogin;
    return data;
  }
}

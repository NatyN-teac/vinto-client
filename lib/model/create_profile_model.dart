// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: deprecated_member_use

class InterestItem {
  var isSelected = false;
  final image;
  final data; //Data of the user
  InterestItem({this.isSelected, this.image, this.data});
}

List<InterestItem> Interest = [
  InterestItem(isSelected: false, image: "assets/logo/1.png", data: "Art"),
  InterestItem(isSelected: false, image: "assets/2.png", data: "Culture"),
  InterestItem(isSelected: false, image: "assets/3.png", data: 'Nature'),
  InterestItem(isSelected: false, image: "assets/4.png", data: 'Landscape'),
  InterestItem(isSelected: false, image: "assets/5.png", data: 'Tech'),
  InterestItem(isSelected: false, image: "assets/6.png", data: 'Sports'),
  InterestItem(isSelected: false, image: "assets/7.png", data: 'Gaming'),
  InterestItem(isSelected: false, image: "assets/8.png", data: 'Wellness'),
];

List<InterestItem> get GetInterest => Interest;

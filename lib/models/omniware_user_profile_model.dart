// ignore_for_file: public_member_api_docs, sort_constructors_first
class OmniwareUserProfile {
  String name;
  String phoneNumber;
  String email;
  String? uid;
  String city;
  String state;
  String country;
  String zipcode;
  String? addressline_1;
  String? addressline_2;
  OmniwareUserProfile({
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.uid,
    required this.city,
    required this.state,
    required this.country,
    required this.zipcode,
    this.addressline_1,
    this.addressline_2,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'uid': uid,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'addressline_1': addressline_1,
      'addressline_2': addressline_2,
    };
  }
}

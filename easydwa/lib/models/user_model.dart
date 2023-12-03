class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String mobile;

  const UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.address,
    required this.mobile,
  });

  toJson() {
    return {
      "Name": name,
      "Email": email,
      "Password": password,
      "Address": address,
      "Mobile": mobile,
    };
  }
}

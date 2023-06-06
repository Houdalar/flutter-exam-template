class User {
  final String id;
  final String username;
  final String identifier;
  final double balance;

  User({
    required this.id,
    required this.username,
    required this.identifier,
    required this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      identifier: json['identifier'],
      balance: json['balance'].toDouble(),
    );
  }
}

class User {
  String idUser;
  String nome;
  String apelido;
  String email;
  String username;
  String userTipo;

  User({
    required this.idUser,
    required this.nome,
    required this.apelido,
    required this.email,
    required this.username,
    required this.userTipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID_User': idUser,
      'Nome': nome,
      'Apelido': apelido,
      'Email': email,
      'Username': username,
      'User_Tipo': userTipo,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    print("Convertendo mapa para usuário: $map");
    return User(
      idUser: map['ID_User'] ?? '',
      nome: map['Nome'] ?? '',
      apelido: map['Apelido'] ?? '',
      email: map['Email'] ?? '',
      username: map['Username'] ?? '',
      userTipo: map['User_Tipo'] ?? '',
    );
  }

  User copyWith({
    String? idUser,
    String? nome,
    String? apelido,
    String? email,
    String? username,
    String? userTipo,
  }) {
    return User(
      idUser: idUser ?? this.idUser,
      nome: nome ?? this.nome,
      apelido: apelido ?? this.apelido,
      email: email ?? this.email,
      username: username ?? this.username,
      userTipo: userTipo ?? this.userTipo,
    );
  }
}

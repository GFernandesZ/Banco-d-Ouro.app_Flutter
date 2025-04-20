import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;
  String? accountType;

  Account({
    required this.id, 
    required this.name, 
    required this.lastName, 
    required this.balance,
    required this.accountType,
  });

  factory Account.fromMap(Map<String, dynamic> map){
    return Account(
      id: map["id"] as String, 
      name: map["name"] as String, 
      lastName: map["lastName"] as String, 
      balance: map["balance"] as double,
      accountType: (map['accountType'] != null) ? map["accountType"] as String : null,
      );
  }
  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id" : id,
      "name": name,
      "lastName": lastName,
      "balance": balance,
      "accountType": accountType,
    };
  }
  //Converte um objeto(Account) em um mapa

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source) as Map<String, dynamic>);
  //cria instancias de classes a partir de mapas ou strings JSON

  String toJson() => json.encode(toMap());
  //Converte o mapa em um Json

  Account copyWith({ 
    String? id,
    String? name, 
    String? lastName, 
    double? balance,
    String? accountType,
  }) {
    return Account(
      id: id ?? this.id, 
      name: name ?? this.name, 
      lastName: lastName ?? this.lastName, 
      balance: balance ?? this.balance,
      accountType: accountType ?? this.accountType,
    );
  }
  //Util para modificar um ou mais atributos de um objeto existente sem afetar o otiginal

  @override
  String toString() {
    return '\nConta: $id\nNome: $name $lastName\nSaldo: $balance\n';
  }
  //Representação textual do objeto, para debugging.
  
  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;

    return other.id == id &&
          other.name == name &&
          other.lastName == lastName &&
          other.balance == balance;
  }
  //Explicação abaixo

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ balance.hashCode;
  }
  //O == e hashCode são importantes para comparação de objetos. O Dart os usa para determinar se duas instâncias de uma classe são iguais.
}
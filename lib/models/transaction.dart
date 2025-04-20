import 'dart:convert';

class Transaction {
  String id;
  String senderAccountId;
  String receiverAccountId;
  DateTime date;
  double amount;
  double taxes;

  Transaction({
    required this.id,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.date,
    required this.amount,
    required this.taxes,
  });

  factory Transaction.fromMap(Map<String, dynamic> map){
    return Transaction(
      id: map['id'] as String,
      senderAccountId: map['senderAccountId'] as String,
      receiverAccountId: map['receiverAccountId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      amount: map['amount'] as double,
      taxes: map['taxes'] as double,
    );
  }

  factory Transaction.fromJson(String source) =>
    Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

//inicializar objetos, como o fromMap e fromJson

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'id' : id,
      'senderAccountId' : senderAccountId,
      'receiverAccountId' : receiverAccountId,
      'date' : date,
      'amount' : amount,
      'taxes' : taxes,
    };
  }

  String toJson()=> json.encode(toMap());
//converte o objeto Account em um mapa que pode ser facilmente convertido em JSON através do método toJson.

  Transaction copyWith
  ({
    String? id,
    String? senderAccountId,
    String? receiverAccountId,
    DateTime? date,
    double? amount,
    double? taxes,
  }) {
    return Transaction(
      id: id ?? this.id,
      senderAccountId: senderAccountId ?? this.senderAccountId,
      receiverAccountId: receiverAccountId ?? this.receiverAccountId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      taxes: taxes ?? this.taxes,
    );
  }

//copyWith, facilita a criação de uma cópia de um objeto com algumas alterações. Esse método é particularmente útil quando você deseja modificar um ou mais atributos de um objeto existente sem afetar o original.

@override
  String toString() {
    return '\\nTransação $id\\n Enviado por$senderAccountId\\nRecebido por: $receiverAccountId\\nHora: $date\\nQuantidade: $amount\\nTaxas: $taxes';
  }
  //O método toString fornece uma representação textual de um objeto, útil para debugging.
@override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.senderAccountId == senderAccountId &&
        other.receiverAccountId == receiverAccountId &&
        other.date == date &&
        other.amount == amount &&
        other.taxes == taxes;
  }

  @override
  int get hashCode {
    return id.hashCode ^ senderAccountId.hashCode ^ receiverAccountId.hashCode ^ date.hashCode ^ amount.hashCode ^ taxes.hashCode;
  }
  //O operador == e o método hashCode são fundamentais para a comparação de objetos. O Dart os usa para determinar se duas instâncias de uma classe são iguais.
}
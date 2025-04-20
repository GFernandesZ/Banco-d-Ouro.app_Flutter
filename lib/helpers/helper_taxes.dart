import '../models/accounts.dart';

double calculateTaxesByAccount({
  required Account sender,
  required double amount
}) {
  if(amount < 5000) return 0;

  if (sender.accountType != null){
    if(sender.accountType!.toUpperCase() == "AMBROSIA"){
      return amount * 0.005;
    }
    else if (sender.accountType!.toUpperCase() == "CANJICA") {
      return amount * 0.0033;
    }
    else if (sender.accountType!.toUpperCase() == "PUDIM") {
      return amount * 0.0025;
    }
    else {
      return amount * 0.001;
    }
  } else {
    return 0.1;
  }
}

// class Transaction {

//   String id;
//   String senderAccountId;
//   String receiverAccountId;
//   DateTime date;
//   double amount;
//   double taxes;

//   Transaction({
//     required this.id,
//     required this.senderAccountId,
//     required this.receiverAccountId,
//     required this.date,
//     required this.amount,
//     required this.taxes,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'senderAccountId': senderAccountId,
//       'receiverAccountId': receiverAccountId,
//       'date': date.millisecondsSinceEpoch,
//       'amount': amount,
//       'taxes': taxes,
//     };
//   }

//   factory Transaction.fromMap(Map<String, dynamic> map) {
//     return Transaction(
//       id: map['id'] as String,
//       senderAccountId: map['senderAccountId'] as String,
//       receiverAccountId: map['receiverAccountId'] as String,
//       date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
//       amount: map['amount'] as double,
//       taxes: map['taxes'] as double,
//     );  
//   }

//   Transaction copyWith({
//     String? id,
//     String? senderAccountId,
//     String? receiverAccountId,
//     DateTime? date,
//     double? amount,
//     double? taxes,
//   }) {
//     return Transaction(
//       id: id ?? this.id,
//       senderAccountId: senderAccountId ?? this.senderAccountId,
//       receiverAccountId: receiverAccountId ?? this.receiverAccountId,
//       date: date ?? this.date,
//       amount: amount ?? this.amount,
//       taxes: taxes ?? this.taxes,
//     );
//   }
  
//   @override
//   String toString() {
//     return '\\nTransação $id\\n Enviado por$senderAccountId\\nRecebido por: $receiverAccountId\\nHora: $date\\nQuantidade: $amount\\nTaxas: $taxes';
//   }

//   //O método toString fornece uma representação textual de um objeto, útil para debugging.
//   @override
//   bool operator ==(covariant Transaction other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.senderAccountId == senderAccountId &&
//         other.receiverAccountId == receiverAccountId &&
//         other.date == date &&
//         other.amount == amount &&
//         other.taxes == taxes;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         senderAccountId.hashCode ^
//         receiverAccountId.hashCode ^
//         date.hashCode ^
//         amount.hashCode ^
//         taxes.hashCode;
//   }
//   //O operador == e o método hashCode são fundamentais para a comparação de objetos. O Dart os usa para determinar se duas instâncias de uma classe são iguais.
// }
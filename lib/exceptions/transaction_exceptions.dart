import '../models/accounts.dart';

class SenderNotExistException implements Exception{
  final String message;

  SenderNotExistException({this.message = "Remetente não existe."});
}

class ReceiverNotExistsException implements Exception {
  final String message;
  ReceiverNotExistsException({this.message = "Destinatário não existe."});
}

class InsufficientFundsException implements Exception {
  String message; //Mensagem amigavel
  Account cause;  //Objeto causador da exceção
  double amount;  //Informações especificas
  double taxes;  //Informações especificas

  InsufficientFundsException({
    this.message = "Saldo insuficiente",
    required this.cause,
    required this.amount,
    required this.taxes,
  });
}
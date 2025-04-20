import 'dart:async';

import 'package:http/http.dart';
import 'dart:convert';

import '../models/accounts.dart';
import 'api_key.dart';

//Aqui vamos trazer tudo que é comunicação com API para essa classe, retirando da main.
class AccountService {
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  //Para dar acesso à stream, criamos um getter.

  String url = "https://api.github.com/gists/817123940af787eb17a6d4d6160a8858";

  Future<List<Account>> getAll() async {

      Response response = await get(Uri.parse(url));
      _streamController.add("${DateTime.now()} | Requisição de leitura.");
      
      Map<String, dynamic> mapResponse = json.decode(response.body);
      //O decode é capaz de transformar, em um objeto que corresponde ao que chegou da nossa resposta. Antes, estava chegando uma lista, pois nosso arquivo era um JSON formatado como uma lista. Segundo a documentação, agora chegará um Map,então usamos um map.
      
      List<dynamic> listDynamic = 
        json.decode(mapResponse["files"]["accounts.json"]["content"]);
      //Nosso mapResponse virá como string, então convertemos ele para uma lista
      
      List<Account> listAccount = [];
      //Convertemos nossa lista de dynamic para accounts
      
      for (dynamic dyn in listDynamic){
        Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
        //Percorremos a listDynamic que veio mapResponse, para cada conta será gerado um dynamic chamado dyn
      
        Account account = Account.fromMap(mapAccount);
        listAccount.add(account);
        //Nele convertemos o dyn em um Map<String, dynamic> e depois para um Account.
      }
      
      return listAccount;
  }

  addAccount(Account account) async {
    List<Account> listAccounts = await getAll();
    //Mudamos para account pois nosso getAll vai retonar uma conta e não um dynamic.
    listAccounts.add(account);
    save(listAccounts, accountName: account.name);
  }

  save(List<Account> listAccounts, {String accountName = ""}) async {
    List<Map<String, dynamic>> listContent = [];
    for (Account account in listAccounts) {
      listContent.add(account.toMap());
    }

    String content = json.encode(listContent);

    Response response = await post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "description": "account.json",
        "public": true,
        "files": {
          "accounts.json": {
            "content": content,
          }
        }
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
          "${DateTime.now()} | Requisição adição bem sucedida ($accountName).");
    } else {
      _streamController
          .add("${DateTime.now()} | Requisição falhou ($accountName).");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/ui/home_screen.dart';
import 'package:flutter_banco_douro/ui/login_screen.dart';

//Tudo q vemos na tela são widgets
void main() {
  runApp(const BancoDouroApp()); //passamos nosso app como parametro
}

class BancoDouroApp extends StatelessWidget {
  //Final app no nome da classe é um sufixo // Usamos o extends  Stateless (widgets)
  const BancoDouroApp({super.key}); //

  @override //metodo para construi tudo (como tela)
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login": (context) => const LoginScreen(),
        "home": (context) =>  HomeScreen(),
      },
      initialRoute: "login",
    );
  }
}

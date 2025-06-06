import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/accounts.dart';
import 'package:flutter_banco_douro/services/account_service.dart';
import 'package:flutter_banco_douro/ui/styles/colors.dart';
import 'package:flutter_banco_douro/ui/widgets/account_widget.dart';
import 'package:flutter_banco_douro/ui/widgets/add_accounts_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Account>> _futureGetAll = AccountService().getAll();

  Future<void> refreshGetAll() async {
    setState(() {
      _futureGetAll = AccountService().getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.lightGrey,
        title: const Text("Sistema de Vendas"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "login");
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return AddAccountsModal();
              },
            );
          },
          backgroundColor: AppColor.orange,
          child: Icon(
            Icons.add,
            color: Colors.blue,
          )),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            onRefresh: refreshGetAll,
            child: FutureBuilder(
              future: _futureGetAll,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    {
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text("Nenhuma informação recebida"));
                      } else {
                        List<Account> listAccounts = snapshot.data!;
                        return ListView.builder(
                          itemCount: listAccounts.length,
                          itemBuilder: (context, index) {
                            Account account = listAccounts[index];
                            return AccountWidget(
                              account: account,
                            );
                          },
                        );
                      }
                    }
                }
              },
            ),
          )),
    );
  }
}

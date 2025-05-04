import 'package:flutter/material.dart';
import 'package:flutter_banco_douro/models/accounts.dart';
import 'package:flutter_banco_douro/services/account_service.dart';
import 'package:uuid/uuid.dart';

class AddAccountsModal extends StatefulWidget {
  const AddAccountsModal({super.key});

  @override
  State<AddAccountsModal> createState() => _AddAccountsModalState();
}

class _AddAccountsModalState extends State<AddAccountsModal> {
  String _accountType = "AMBROSIA";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
        top: 32,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Image.asset(
                "assets/images/icon_add_account.png",
                width: 64,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "Adicionar nova conta",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Preencha os dadods abaixo:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text("Nome")),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(label: Text("Último nome")),
            ),
            const SizedBox(height: 16),
            const Text("Tipo da conta"),
            DropdownButton<String>(
              value: _accountType,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: "AMBROSIA",
                  child: Text("Ambrosia"),
                ),
                DropdownMenuItem(
                  value: "CANJICA",
                  child: Text("Canjica"),
                ),
                DropdownMenuItem(
                  value: "PUDIM",
                  child: Text("Pudim"),
                ),
                DropdownMenuItem(
                  value: "BRIGADEIRO",
                  child: Text("Brigadeiro"),
                ),
              ],
              onChanged: (valor) {
                setState(() {
                  if (valor == null) {
                    _accountType = valor!;
                  }
                });
              },
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (isLoading)
                        ? null
                        : () {
                            onButtoCancelClicked();
                          },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onButtonSendClicked();
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.orange),
                    ),
                    child: (isLoading)
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
                            "Adcionar",
                            style: TextStyle(color: Colors.black),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  onButtoCancelClicked() {
    if (!isLoading) {
      Navigator.pop(context);
    }
  }

  onButtonSendClicked() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      String name = _nameController.text;
      String lastName = _lastNameController.text;

      Account account = Account(
        id: const Uuid().v1(),
        name: name,
        lastName: lastName,
        balance: 0,
        accountType: _accountType,
      );
      await AccountService().addAccount(account);

      closeModal();
    }
  }

  closeModal() {
    Navigator.pop(context);
  }
}

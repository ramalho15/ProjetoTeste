import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserController _userController = UserController();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<User> users = await _userController.listUsers();
    print("Usuários carregados: ${users.length}");
    setState(() {
      _users = users;
    });
  }

  Future<void> _showUserForm({User? user}) async {
    // Usando os novos campos do modelo User
    TextEditingController nomeController = TextEditingController(text: user?.nome ?? '');
    TextEditingController apelidoController = TextEditingController(text: user?.apelido ?? '');
    TextEditingController emailController = TextEditingController(text: user?.email ?? '');
    TextEditingController usernameController = TextEditingController(text: user?.username ?? '');
    TextEditingController userTipoController = TextEditingController(text: user?.userTipo ?? '');

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user == null ? 'Adicionar Utilizador' : 'Editar Utilizador'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: nomeController, decoration: InputDecoration(labelText: 'Nome')),
                TextField(controller: apelidoController, decoration: InputDecoration(labelText: 'Apelido')),
                TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
                TextField(controller: usernameController, decoration: InputDecoration(labelText: 'Username')),
                TextField(controller: userTipoController, decoration: InputDecoration(labelText: 'Tipo de Utilizador')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nomeController.text.isNotEmpty && emailController.text.isNotEmpty) {
                  if (user == null) {
                    // Criando novo usuário com os novos campos
                    await _userController.createUser(
                      User(
                        idUser: UniqueKey().toString(),
                        nome: nomeController.text,
                        apelido: apelidoController.text,
                        email: emailController.text,
                        username: usernameController.text,
                        userTipo: userTipoController.text,
                      ),
                    );
                  } else {
                    // Atualizando os dados do usuário
                    await _userController.updateUser(
                      user.copyWith(
                        nome: nomeController.text,
                        apelido: apelidoController.text,
                        email: emailController.text,
                        username: usernameController.text,
                        userTipo: userTipoController.text,
                      ),
                    );
                  }
                  Navigator.pop(context);
                  _loadUsers();
                }
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Utilizadores'),
      ),
      body: _users.isEmpty
          ? Center(child: Text('Nenhum utilizador encontrado.'))
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                User user = _users[index];
                return ListTile(
                  title: Text('${user.nome} ${user.apelido}'),
                  subtitle: Text('Email: ${user.email}, Username: ${user.username}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showUserForm(user: user),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          // Removendo usuário com idUser
                          await _userController.deleteUser(user.idUser);
                          _loadUsers();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}

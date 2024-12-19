import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    try {
      // Substituindo user.id por user.idUser
      await _firestore.collection('user').doc(user.idUser).set(user.toMap());
      print("Usuário adicionado com sucesso!");
    } catch (e) {
      print("Erro ao adicionar usuário: $e");
    }
  }

  Future<List<User>> listUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('user').get();
      print("Documentos recuperados: ${querySnapshot.docs.length}");

      if (querySnapshot.docs.isEmpty) {
        print("Nenhum documento encontrado.");
      }

      return querySnapshot.docs.map((doc) {
        print("Dados do Documento: ${doc.data()}");
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Erro ao listar usuários: $e");
      return [];
    }
  }

  Future<void> updateUser(User user) async {
    try {
      // Substituindo user.id por user.idUser
      await _firestore.collection('user').doc(user.idUser).update(user.toMap());
      print("Usuário atualizado com sucesso!");
    } catch (e) {
      print("Erro ao atualizar usuário: $e");
    }
  }

  Future<void> deleteUser(String idUser) async {
    try {
      // Usando idUser em vez de id
      await _firestore.collection('user').doc(idUser).delete();
      print("Usuário removido com sucesso!");
    } catch (e) {
      print("Erro ao remover usuário: $e");
    }
  }
}

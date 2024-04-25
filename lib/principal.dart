import 'package:flutter/material.dart';
import 'package:flutter_sqlite2/database/bd.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}): super(key: key);

  @override
    _PrincipalState createState() => _PrincipalState ();
}

  class _PrincipalState extends State<Principal> {
    //Todos os diários
    List<Map<String, dynamic>> _lista = [];

    bool _isLoading = true;
    //Esta função é usada para buscar todos os dados do banco de dados
    void _refreshTutorial() async {
    final data = await SqlDb.buscarTodos();


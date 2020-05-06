import 'dart:async';
import  'dart:convert';
import 'package:appmodule/Classes/Contacts.dart';
import 'package:flutter/cupertino.dart';

class BlocPessoa{

     // Criando a funcao com os dados
     List<Pessoa> Mylista = [] ;
     BlocPessoa(BuildContext context){
        _loadingList(context);
     }
     // criando funcao

     StreamController _controller  =  new StreamController<List<Pessoa>>.broadcast();
     Stream<List<Pessoa>>  getOutPessoa ()=>_controller.stream;


     Future<List<Pessoa>> _loadingList(BuildContext  context) async{
      // carrengando os dados;
       DefaultAssetBundle.of(context).loadString("assets/service.json").then((Valores){
           var response =  json.decode(Valores);
           for(var p  in response["pessoa"])this.Mylista.add(Pessoa.fromMap(p));
           this._controller.sink.add(this.Mylista);
      });
      //fim do processo
     }



}
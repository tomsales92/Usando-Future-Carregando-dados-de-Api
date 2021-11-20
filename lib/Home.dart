import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
 
import 'Post.dart';
 
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
 
class _HomeState extends State<Home> {
 
   Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  
  Future<List<Post>> _recuperarPostagens() async {
   http.Response response = await http.get(url);
   var dadosJson = json.decode( response.body );
 
    List<Post> postagens = [];
    for( var post in dadosJson ){
      
      print("post: " + post["title"] );
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add( p );
    
    }
    return postagens;
    //print( postagens.toString() );
    
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço avançado"),
      ),
      body: FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder: (context, snapshot){
          var retorno;
 
          switch( snapshot.connectionState ){
            case ConnectionState.none :
            case ConnectionState.waiting :
              retorno =  Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active :
            case ConnectionState.done :
              if( snapshot.hasError ){
                print("lista: Erro ao carregar ");
              }else {
 
                print("lista: carregou!! ");
                retorno =  ListView.builder(
                  itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
 
                      List<Post>? lista = snapshot.data;
                      Post post = lista![index];
 
                      return ListTile(
                        title: Text( post.title ),
                        subtitle: Text( post.id.toString() ),
                      );
                    
                    }
                );
 
              }
              break;
          }
 
          return retorno;
 
        },
      ),
    );
  }
}
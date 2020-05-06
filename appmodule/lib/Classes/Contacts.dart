class Pessoa{
   String nome ;
   String email;
   String telefone ;

   Pessoa({this.nome , this.email ,this.telefone});

   Map<String, dynamic> toMap() {
     return {
       'nome': this.nome,
       'email': this.email,
       'telefone': this.telefone,
     };
   }

   factory Pessoa.fromMap(Map<String, dynamic> map) {
     return Pessoa(
       nome: map['nome'] as String,
       email: map['email'] as String,
       telefone: map['telefone'] as String,
     );
   }

}
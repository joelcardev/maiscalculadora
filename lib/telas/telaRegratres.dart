import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maiscalculadora/blocs/blocRegra.dart';
import 'package:maiscalculadora/telas/telaHome.dart';

class telaRegratres extends StatefulWidget {
  @override
  _telaRegratresState createState() => _telaRegratresState();
}

class _telaRegratresState extends State<telaRegratres> {
  final _formKey = GlobalKey<FormState>();
  blocRegra bloc = new blocRegra();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 10),
                  icon: Icon(Icons.info_outline), tooltip: 'Como usar', onPressed: (){
                showAlertDialog1(context);


              })
            ],
          leading: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                    // Chame o Navigator aqui para voltar a rota precedente
                    Navigator.pop(context)
                  }),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Colors.redAccent, Colors.red],
              ),
            ),
          ),
          elevation: 10.0,
        ),
        body: SingleChildScrollView(

          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.white, Colors.orangeAccent])),
                child: juntarCampos()),
          ),
        ));
  }

  Widget escolher() {
    return Container(
      child: Column(
        children: [
          Text("Inverter Proporção",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red)),
          Switch(
            value: bloc.isInver,
            onChanged: (value) {

              ///bloco de codigo que inverte a proporção fazendo ele ficar true, e assim fazer a inversão dos valores.
              setState(() {
                bloc.mensagemValidar = "";
                bloc.setInvertido(value);
              });
            },
            activeColor: Colors.green,
          )
        ],
      ),
    );
  }

  Widget juntarCampos() {
    return Center(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icons(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          campos("x"),
                          Container(
                            child: Icon(Icons.arrow_downward_rounded),
                          ),
                          campos("y")
                        ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        campos("X"),
                        Container(
                            child: StreamBuilder<String>(
                          stream: bloc.escolharStream,
                          builder: (BuildContext context, AsyncSnapshot snap) {
                            return Icon(
                                bloc.isInver == false
                                    ? Icons.arrow_downward_rounded
                                    : Icons.arrow_upward_rounded,
                                color: bloc.isInver == false
                                    ? Colors.black
                                    : Colors.green);
                          },
                        )),
                        campos("Y")
                      ],
                    )
                  ],
                ),
                Container(
                  height: 30,
                ),
                escolher(),
                botao(),
                Container(
                  height: 30,
                ),
                resultado()
              ],
            )));
  }

  Widget resultado() {
    return Container(
        child: StreamBuilder<dynamic>(
            stream: bloc.resultadoStream,
            builder: (BuildContext context, AsyncSnapshot snap) {
              return snap.hasError
                  ? Container(child: Text("ERROR"))
                  : Container(
                      child: StreamBuilder<int>(
                          stream: bloc.validarStream, //stream do tipo int
                          builder:
                              (BuildContext context, AsyncSnapshot<int> snap2) {
                            return bloc.validar() == true
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snap.data["title"] + " = ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 25.0,
                                              color: Colors.black)),
                                      Text(snap.data["result"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0,
                                              color: Colors.green))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              left: 25, right: 25),
                                          child: Text(bloc.mensagemValidar,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: Colors.redAccent))),
                                    ],
                                  );


                          }));
            }));
  }

  campos(String nome) {
    return Container(
        width: 110,
        margin: EdgeInsets.all(10.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {


            ///if que serve para acumular o contador e fazer a validação, se estiver vazio automaticamente o value vira 0.
            if (value.isNotEmpty) {
              bloc.contar();
            } else {
              value = "0";
            }

            bloc.setarValores(nome, value);

            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            labelText: nome,
          ),
        ));
  }

  Widget botao() {
    return Container(
        width: 300,
        child: FlatButton(
          padding: EdgeInsets.all(20.0),
          child: const Text('Calcular agora',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white)),
          color: Colors.redAccent,
          splashColor: Colors.red,
          onPressed: () {
            bloc.contador = 0;

            ///serve para zerar o contador, e isso serve para o validador,
            /// pois se aperta varias vezes se acumula e ultrapassa a 3, assim nunca chegando o resultado.

            if (_formKey.currentState.validate()) {
              bloc.calcular();
            }
          }

          // faz alguma coisa
          ,
        ));
  }

  Widget icons() {
    return Center(
        child: Container(
      alignment: Alignment.center,
      child: Image.asset("imagens/logoRegra.png"),
      width: 350,
      height: 175,
    ));
  }





  showAlertDialog1(BuildContext context)
  {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();

      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("O que é regra de Três?", textAlign:TextAlign.center,),
      content: Text("Regra de três simples é um processo prático para resolver problemas que envolvam quatro valores dos quais conhecemos três deles.\nDevemos, portanto, determinar um valor a partir dos três já conhecidos.", textAlign: TextAlign.start,),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void dispose() {
    bloc.fecharStream();
    super.dispose();
  }
}

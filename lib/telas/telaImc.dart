import 'package:flutter/material.dart';
import 'package:maiscalculadora/blocs/blocImc.dart';

import 'package:maiscalculadora/telas/telaHome.dart';

class telaImc extends StatefulWidget {
  @override
  _telaImcState createState() => _telaImcState();
}

class _telaImcState extends State<telaImc> {
  final _formKey = GlobalKey<FormState>();///formkey que controla os campos da tela imc, ele pega e valida seus valores.
  blocImc bloc = new blocImc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Colors.redAccent,
                Colors.red,
              ],
            ),
          ),
        ),
        elevation: 10.0,
        leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)}),
      ),
      body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.orangeAccent])),
        alignment: Alignment.topCenter,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imc(),
                icons(),
                campos("Peso"),
                campos("Altura"),
                botao()
              ],
            )),
      )),
    );
  }

  showAlertDialog1(BuildContext context) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Center(
          child: StreamBuilder<dynamic>(
              stream: bloc.dadosStream,
              builder: (BuildContext context, AsyncSnapshot snap) {
                return Text(snap.hasData ? '${snap.data['titulo']}' : "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black));
              })),
      content: new Container(
          child: StreamBuilder<dynamic>(
              stream: bloc.dadosStream,
              builder: (BuildContext context, AsyncSnapshot snap) {
                return new ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    textoInformacao(
                        "Classificação",
                        snap.hasData ? '${snap.data['classificacao']}' : "",
                        20,
                        Alignment.center),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textoInformacao(
                            "Peso",
                            snap.hasData ? '${snap.data['peso']}' : "",
                            20,
                            Alignment.center),
                        Container(
                          width: 20,
                        ),
                        textoInformacao(
                            "Altura ",
                            snap.hasData ? '${snap.data['altura']}' : "",
                            20,
                            Alignment.center)
                      ],
                    ),
                    textoInformacao(
                        "Seu IMC é ",
                        snap.hasData ? '${snap.data['seuImc']}' + " kg/m2" : "",
                        20,
                        Alignment.center),
                    Container(
                      height: 8,
                    ),
                    textoInformacao(
                        "Doenças relacionadas: ",
                        snap.hasData ? '${snap.data['doencas']}' : "",
                        20,
                        Alignment.center),
                    Container(
                      height: 8,
                    ),
                    textoInformacao(
                        "Recomedações: ",
                        snap.hasData ? '${snap.data['recomedacao']}' : "",
                        20,
                        Alignment.center),
                    Container(
                      height: 8,
                    ),
                    textoInformacao(
                        "Grupos excluidos do IMC: ",
                        snap.hasData ? '${snap.data["desconsiderar"]}' : "",
                        20,
                        Alignment.center),
                  ],
                );
              })),
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

  Widget imc() {
    return Container(
        child: Text("+ IMC",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.redAccent)));
  }

  Widget botao() {
    return Container(
        width: 300,
        child: FlatButton(
          padding: EdgeInsets.all(20.0),
          child: const Text('Calcular IMC',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white)),
          color: Colors.redAccent,
          splashColor: Colors.red,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              showAlertDialog1(context);
              bloc.Iniciar();
              bloc.definirIndice();
            }

            // faz alguma coisa
          },
        ));
  }

  Widget textoInformacao(
      String nome, String infor, double tamanho, Alignment ali) {

    ///ESSE BLOCO SERVE PARA FAZER UMA ESCOLHA DE WIDGET,
    /// SE O VARIAVEL NOME FOR IGUAL AS VARIAVEIS DA OPERATIONS ABAIXO,
    /// ENTÃO FAÇA UM TIPO DE CONTAINER SE NÃO FAÇA O DEBAIXO.
    const operations = const [
      'Doenças relacionadas: ',
      'Recomedações: ',
      'Grupos excluidos do IMC: ',
      "desconsiderar"
    ];
    return operations.contains(nome)
        ? Container(
            alignment: ali,
            child: Card(
              shadowColor: Colors.red,
                child: ExpansionTile(
              collapsedBackgroundColor: Colors.white30,
              title: Text(nome,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: tamanho,
                      color: Colors.black)),
              children: <Widget>[
                Container(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child:Text(infor,

                    style: TextStyle(

                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        color: Colors.black)) ),
                Container(
                  height: 15,
                )
              ],
            )))
        : Container(
            alignment: ali,
            child: Column(
              children: [
                Divider(
                  height: 15,
                ),
                Text(nome,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tamanho,
                        color: Colors.black)),
                Container(
                  height: 10,
                ),
                Text(infor,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black)),
                Container(
                  height: 10,
                )
              ],
            ));
  }

  icons() {
    return Container(
      child: Image.asset("imagens/balanca.png"),
      width: 80,
      height: 100,
    );
  }

  campos(String nome) {
    return Container(
        margin: EdgeInsets.only(left: 30.0, right: 30, bottom: 20, top: 10),
        child: TextFormField(
          inputFormatters: [nome == "Altura"?bloc.maskFormatter1:bloc.maskFormatter2],///ESCOLHA DAS MASCARAS
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty) {
              return 'Por favor, digite algum valor';
            } else {
              nome == "Peso" ? bloc.setPeso(value) : bloc.setAltura(value);
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: nome == "Peso" ? "Seu Peso (KG)" : "Sua Altura",
          ),
        ));
  }

  void dispose() {
    bloc.fecharStream();
    super.dispose();
  }
}

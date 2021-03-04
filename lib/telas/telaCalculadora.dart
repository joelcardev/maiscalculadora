import 'package:flutter/material.dart';
import 'package:maiscalculadora/blocs/blocCalc.dart';
import 'package:maiscalculadora/telas/telaHome.dart';

// ignore: camel_case_types
class telaCalculadora extends StatefulWidget {
  @override
  _telaCalculadoraState createState() => _telaCalculadoraState();
}

class _telaCalculadoraState extends State<telaCalculadora> {
  blocCalc bloc = new blocCalc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                colors: <Color>[Colors.red, Colors.red],
              ),
            ),
          ),
          elevation: 10.0,
          title: Container(
              margin: EdgeInsets.only(right: 30),
              child: Center(
                  child: Text("Calculadora",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white))))),
      body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, Colors.orangeAccent])),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                campo1(),
                campo2(),
                Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, bottom: 40),
                    child: tecladoCalc())
              ],
            ),
          )),
    );
  }

  Widget campo1() {
    return Container(
        height: 90,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerRight,
        margin: EdgeInsets.fromLTRB(30, 0, 25, 0),
        child: StreamBuilder<String>(
            stream: bloc.tela1Stream,
            builder: (BuildContext context, AsyncSnapshot snap) {
              return Text(
                  bloc.getTamanhoDigitos() > 55
                      ? "Quantidade de números excedidos."
                      : snap.hasData
                          ? '${snap.data}'
                          : "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: bloc.getTamanhoDigitos() < 55 ? 25.0 : 20,
                      color: Colors.green));
            }));
  }

  Widget campo2() {
    return Container(
        height: 50,
        alignment: Alignment.centerRight,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(30, 0, 30, 20),
        child: StreamBuilder<String>(
            stream: bloc.tela2Stream,
            builder: (BuildContext context, AsyncSnapshot snap) {
              return snap.hasError
                  ? Text("Error. Verifique o formato da expressão.")
                  : Text(snap.hasData ? '${snap.data}' : "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: bloc.getTamanhoDigitos() < 10 ? 40.0 : 30,
                          color: Colors.green));
            }));
  }

  Widget campos() {
    return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
        height: 100,
        width: 400,
        child: Column(children: <Widget>[campo1(), campo2()]));
  }

  Widget tecladoCalc() {
    return Center(
        child: Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        icone("(", Colors.red[200]),
        icone(")", Colors.red[200]),
        icone("%", Colors.red[200]),
        icone("/", Colors.red[200])
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        icone("7", Colors.redAccent),
        icone("8", Colors.redAccent),
        icone("9", Colors.redAccent),
        icone("+", Colors.red[200])
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        icone("4", Colors.redAccent),
        icone("5", Colors.redAccent),
        icone("6", Colors.redAccent),
        icone("-", Colors.red[200])
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        icone("1", Colors.redAccent),
        icone("2", Colors.redAccent),
        icone("3", Colors.redAccent),
        icone("x", Colors.red[200])
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        icone("0", Colors.redAccent),
        icone(".", Colors.redAccent),
        icone("AC", Colors.redAccent),
        iconeIgual("=", Colors.red[200])
      ])
    ]));
  }

  Widget iconeIgual(String bt, Color cor) {
    return GestureDetector(
        child: Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(9, 3, 5, 0),
                width: 77.0,
                height: 77.0,
                child: PhysicalModel(
                  color: cor,
                  shape: BoxShape.circle,
                  elevation: 10.0,
                  child: MaterialButton(
                      onPressed: () {
                        bloc.applyCommand(bt);
                      },
                      child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(bt,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white))
                            ]),
                        height: 100.0,
                      )),
                ))));
  }

  Widget icone(String bt, Color cor) {
    return GestureDetector(
        child: Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(9, 3, 5, 0),
                width: 77.0,
                height: 77.0,
                child: PhysicalModel(
                  color: cor,
                  shape: BoxShape.circle,
                  elevation: 10.0,
                  child: MaterialButton(
                      onPressed: () {
                        bloc.applyCommand(bt);
                      },
                      child: Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(bt,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white))
                            ]),
                        height: 100.0,
                      )),
                ))));
  }

  void dispose() {
    bloc.fecharStream();
    super.dispose();
  }
}

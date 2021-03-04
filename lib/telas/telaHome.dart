import 'package:flutter/material.dart';
import 'package:maiscalculadora/telas/telaCalculadora.dart';
import 'package:maiscalculadora/telas/telaImc.dart';
import 'package:maiscalculadora/telas/telaRegratres.dart';


class telaHome extends StatefulWidget {
  @override
  _telaHomeState createState() => _telaHomeState();
}

iconesDosServicos(String imagem, BuildContext context) {
  return Container(
      margin: EdgeInsets.all(20.0),
      width: 280,
      child: GestureDetector(
        child: PhysicalModel(
          child: MaterialButton(
              onPressed: () {
                if (imagem == "imagens/calculadora.png") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => telaCalculadora()),
                  );
                } else if (imagem == "imagens/logoImc.png") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => telaImc()),
                  );
                } else if (imagem == "imagens/logoRegra.png") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => telaRegratres()),
                  );
                }
              },
              child: box(imagem)),
          color: Colors.white,
          shape: BoxShape.rectangle,
          elevation: 20.0,
          shadowColor: Colors.black,
        ),
        onTap: () {},
      ));
}

box(String imagem) {
  return Container(
    width: 150,
    height: 150,
    child: Image.asset(imagem),
  );
}

class _telaHomeState extends State<telaHome> {
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
          title: Container(
              child: Center(
            child: Text(
              "+ Calculadora",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ))),
      body: SingleChildScrollView(
          physics:NeverScrollableScrollPhysics(),///FUNÇÃO QUE IMPEDE DE MEXER PARA BAIXO A TELA.
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, Colors.orangeAccent])),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                iconesDosServicos("imagens/calculadora.png", context),
                iconesDosServicos("imagens/logoImc.png", context),
                iconesDosServicos("imagens/logoRegra.png", context)
              ],
            ),
          )),
    );
  }

  
}

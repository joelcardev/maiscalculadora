import 'package:bloc_pattern/bloc_pattern.dart';

import 'dart:async';

import 'package:math_expressions/math_expressions.dart';

class blocRegra extends BlocBase {
  int contador = 0;
  String mensagemValidar = "";

  bool isValidar = true;
  double x;
  double y;
  double x2;
  double y2;
  bool isInver = false;
  Map<dynamic, dynamic> resultado = Map();

  ///metodo que inverte o variavel que é usado para verificar se é para inversamente ou não.
  void setInvertido(bool i) {
    isInver = i;
  }

  ///função que é chamada para validar os 4 campos do programa.
  bool validar() {
    if (contador == 3) {
      ///se 3 campos tiverem preenchidos, sera efetivado e o programa dará o resultado.

      contador = 0;
      return true;
    } else if (contador > 0 && contador != 3) {
      ///mensagem que dará um mensagem se não tiver 3 campos preenchidos.

      mensagemValidar = "Preencha 3 campos com valores acima de 0";

      return false;
    }
  }

  ///função que seta valores as repectivas variaveis
  void setarValores(dynamic nome, dynamic valor) {
    print(nome + "" + valor + " " + contador.toString());

    switch (nome) {
      case "x":
        setX(double.parse(valor));
        break;
      case "y":
        setY(double.parse(valor));
        break;
      case "X":
        setX2(double.parse(valor));
        break;
      case "Y":
        setY2(double.parse(valor));
        break;
      default:
        break;
    }
  }

  void contar() {
    contador++;

    _blocValidar.sink.add(contador);
  }

  ///Metedo para calcular valores proporcionais ou inversamente proporcionais.
  void calcular() {
    if (isInver == false) {
      if (y > 0 && x2 > 0 && y2 > 0) {
        x = (y * x2) / y2;
        resultado["resultado"] = {
          "title": "x",
          "result": x.toStringAsPrecision(2).toString()
        };

        _blocController1.sink.add(resultado["resultado"]);
      } else if (x > 0 && y2 > 0 && x2 > 0) {
        y = (x * y2) / x2;
        resultado["resultado"] = {
          "title": "y",
          "result": y.toStringAsPrecision(2).toString()
        };

        _blocController1.sink.add(resultado["resultado"]);
      } else if (x > 0 && y2 > 0 && y > 0) {
        x2 = (x * y2) / y;

        resultado["resultado"] = {
          "title": "X",
          "result": x2.toStringAsPrecision(2).toString()
        };
        _blocController1.sink.add(resultado["resultado"]);
      } else if (x2 > 0 && y > 0 && x > 0) {
        y2 = (x2 * y) / x;

        resultado["resultado"] = {
          "title": "Y",
          "result": y2.toStringAsPrecision(2).toString()
        };
        _blocController1.sink.add(resultado["resultado"]);
      }
    } else {
      if (y > 0 && x2 > 0 && y2 > 0) {
        x = (y * y2) / x2;
        resultado["resultado"] = {
          "title": "x",
          "result": x.toStringAsPrecision(2).toString()
        };

        _blocController1.sink.add(resultado["resultado"]);
        print(x);
      } else if (x > 0 && y2 > 0 && x2 > 0) {
        y = (x * x2) / y2;
        resultado["resultado"] = {
          "title": "y",
          "result": y.toStringAsPrecision(2).toString()
        };

        _blocController1.sink.add(resultado["resultado"]);
        print(x);
      } else if (x > 0 && y2 > 0 && y > 0) {
        x2 = (y * y2) / x;
        resultado["resultado"] = {
          "title": "X",
          "result": x2.toStringAsPrecision(2).toString()
        };
        _blocController1.sink.add(resultado["resultado"]);
        print(x2);
      } else if (x2 > 0 && y > 0 && x > 0) {
        y2 = (x * x2) / y;
        resultado["resultado"] = {
          "title": "Y",
          "result": y2.toStringAsPrecision(2).toString()
        };
        _blocController1.sink.add(resultado["resultado"]);
        print(y2);
      }
    }
  }

  ///ISSO AQUI NÃO PRECISO EXPLICAR NÉ MEU FI, KKKKK
  void setX(double x) {
    this.x = x;
  }

  void setY(double y) {
    this.y = y;
  }

  void setX2(double x) {
    this.x2 = x;
  }

  void setY2(double y) {
    this.y2 = y;
  }

  /// bloc que faz controle do resultado dos calculos.
  final _blocController1 = StreamController<dynamic>();
  Stream<dynamic> get resultadoStream => _blocController1.stream;

  ///bloc que faz controle da inversão dos calculos.
  final _blocController2 = StreamController<String>();
  Stream<String> get escolharStream => _blocController2.stream;

  ///forma que achei para fazer a validação,
  /// porque o stream faz atualização imediata de uma ação,
  /// servindo assim para atualizar a validação depois de uma ação.
  final _blocValidar = StreamController<int>();
  Stream<int> get validarStream => _blocValidar.stream;

  fecharStream() {
    _blocController1.close();
    _blocController2.close();
    _blocValidar.close();
  }
}

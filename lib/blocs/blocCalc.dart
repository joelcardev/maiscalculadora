import 'package:bloc_pattern/bloc_pattern.dart';

import 'dart:async';

import 'package:math_expressions/math_expressions.dart';
import 'package:rxdart/rxdart.dart';

class blocCalc extends BlocBase {
  static const operations = const ['√', '%', '/', '+', '-', 'x', '='];

  String _tela1 = "";///tela que aparece os numeros digitados.
  String _tela2;/// tela que aparece o resultado da expressão.
  int posV = 0;


  ///BLOCS QUE FAZEM O CONTROLE, UM DOS DIGITOS DA EXPRESSÃO E OUTRO DO RESULTADO DA MESMA.
  final _blocController1 = new BehaviorSubject<String>();

  final _blocController2 = new BehaviorSubject<String>();

  Stream<String> get tela1Stream => _blocController1.stream;
  Stream<String> get tela2Stream => _blocController2.stream;

  ///FUNÇÃO QUE QUANDO ACIONADA PEGA O NOME DO BOTÃO "COMMAND" E ACIONA OUTRAS FUNÇÕES.
  void applyCommand(String command) {
    if (command == 'AC') {
      deleteEndDigit();
    } else if (command == 'DEL') {
      _tela1 = "";
      _blocController1.sink.add(_tela1);
    } else if (command == "=") {
      calcular();
    } else {
      addDigit(command);
    }
  }

  ///Deleta o ultimo digito da tela.
  void deleteEndDigit() {
    int ct = 0;
    _tela1 = _tela1.length > 1 ? _tela1.substring(0, _tela1.length - 1) : '';

    _blocController1.sink.add(_tela1);
  }

  ///função principal que calcula a expressão da variavel tela1;
  void calcular() {
    /// catch que pega qualquer erro de expressão digitada, qualquer expressão que não é calculada será ERROR.
    if (_tela1.isNotEmpty) {
      try {
        String res = _tela1;

        res = res.replaceAll("x", "*");
        res = res.replaceAll("%", "/100");

        Parser p = Parser();
        Expression exp = p.parse(res);
        ContextModel cm = ContextModel();
        double vl = exp.evaluate(EvaluationType.REAL, cm);

        _tela2 = vl.toStringAsFixed(1).toString();

        _blocController2.sink.add(_tela2);
      } catch (e) {
        _blocController2.sink.add("Error...");
      }
    }
  }

  ///FUNÇAO QUE ADICIONA DIGITOS NA VARIAVEL TELA1

  void addDigit(String bt) {
    if (operations.contains(bt)) {

      ///TRES IFS QUE IMPEDEM ERROS, EXEMPLO: SE ALGUEM COLOCAR PRIMEIRO * SEM UMA INTERVENÇÃO, PODE PROVOCAR ERRO, ENTÃO SE COLOCA 0 * O ERRO É IMPEDIDO.
      if (_tela1 == "" && bt == "x") {
        _tela1 = "0x";
        _blocController1.sink.add(_tela1);
      }
      if (_tela1 == "" && bt == "/") {
        _tela1 = "0/";
        _blocController1.sink.add(_tela1);
      }
      if (_tela1 == "" && bt == "-") {
        _tela1 = "-";
        _blocController1.sink.add(_tela1);
      }


      ///
      if (bt == _tela1[_tela1.length - 1]) {
        _tela1 = _tela1;
        _blocController1.sink.add(_tela1);
      } else
        _tela1 = _tela1 + "" + bt;
      _blocController1.sink.add(_tela1);
    } else
      _tela1 = _tela1 + "" + bt;
    _blocController1.sink.add(_tela1);
  }

  int getTamanhoDigitos() {
    return _tela1.length;
  }

  int getTamanhoResultadoDigitos() {
    return _tela2.length;
  }

  fecharStream() {
    _blocController1.close();
    _blocController2.close();
  }
}

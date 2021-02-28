import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'dart:async';

import 'package:rxdart/rxdart.dart';

class blocImc extends BlocBase {
  Map<String, dynamic> dados = Map();
  Map<String, dynamic> mostrarDados = Map();
  var maskFormatter1 = new MaskTextInputFormatter(mask: '#.## m)', filter: { "#": RegExp(r'[0-9]') }); /// MASCARA PARA O CAMPO DE ALTURA.
  var maskFormatter2 = new MaskTextInputFormatter(mask: '', filter: { "#": RegExp(r'[0-9]') });/// MASCARA PARA CAMPO DO PESO.
  double meuimc = 0.0;
  double minhaAltura = 0.0;
  double meuPeso = 0.0;

  blocImc() {
    Iniciar();
  }

  double calcularImc() {
    meuimc = meuPeso / (minhaAltura * minhaAltura);
    double imc = double.parse(meuimc.toStringAsFixed(2));
    return imc;
  }

  void setPeso(String peso) {
    meuPeso = double.parse(peso);
  }

  void setAltura(String altura) {
    minhaAltura = double.parse(altura);
  }

  void definirIndice() {
    meuimc = calcularImc();

    if (meuimc < 18.59) {
      _blocController1.sink.add(dados['nivel1']);
    } else if (meuimc > 17 && meuimc < 18.49) {
      _blocController1.sink.add(dados['nivel2']);
    } else if (meuimc > 18.5 && meuimc < 24.99) {
      _blocController1.sink.add(dados['nivel3']);
    } else if (meuimc > 25 && meuimc < 29.99) {
      _blocController1.sink.add(dados['nivel4']);
    } else if (meuimc > 30 && meuimc < 34.99) {
      _blocController1.sink.add(dados['nivel5']);
    } else if (meuimc > 35 && meuimc < 39.99) {
      _blocController1.sink.add(dados['nivel6']);
    } else if (meuimc > 40.0) {
      _blocController1.sink.add(dados['nivel7']);
    }
  }



  void dates() {
    var nive1 = {
      "titulo": "IMC",
      "classificacao": "Muito abaixo do peso",
      "seuImc": calcularImc(),
      "altura": minhaAltura,
      "peso": meuPeso,
      "doencas": "Queda de cabelo, infertilidade, ausência menstrual",
      "recomedacao":
          "Se o resultado do IMC estiver abaixo do ideal, o que se deve fazer é aumentar a ingestão de alimentos ricos em vitaminas e minerais de boa qualidade, mas sem cair no erro de comer alimentos processados e ricos em gordura trans. \n\n Pizzas, frituras, cachorro quente e hambúrguer não são os melhores alimentos para quem precisa aumentar o peso de forma saudável, porque este tipo de gordura pode se acumular no interior das artérias, aumentando o risco de doença cardíaca.",
      "desconsiderar":
          "Atletas e pessoas muito musculosas: porque não leva em consideração o peso dos músculos. Nesse caso a medida do pescoço é uma melhor opção.\n\n idosos: porque não leva em consideração a redução natural dos músculos nessas idade. \n\n Durante a gravidez: porque não leva em consideração o crescimento do bebê"
    };
    var nive2 = {
      "titulo": "IMC",
      "classificacao": "Abaixo do peso",
      "seuImc": calcularImc(),
      "altura": minhaAltura,
      "peso": meuPeso,
      "doencas": "Fadiga, stress, ansiedade",
      "recomedacao":
          "Se o resultado do IMC estiver abaixo do ideal, o que se deve fazer é aumentar a ingestão de alimentos ricos em vitaminas e minerais de boa qualidade, mas sem cair no erro de comer alimentos processados e ricos em gordura trans. \n\n Pizzas, frituras, cachorro quente e hambúrguer não são os melhores alimentos para quem precisa aumentar o peso de forma saudável, porque este tipo de gordura pode se acumular no interior das artérias, aumentando o risco de doença cardíaca. ",
      "desconsiderar":
          "Atletas e pessoas muito musculosas: porque não leva em consideração o peso dos músculos. Nesse caso a medida do pescoço é uma melhor opção.\n\n idosos: porque não leva em consideração a redução natural dos músculos nessas idade. \n\n Durante a gravidez: porque não leva em consideração o crescimento do bebê",
    };
    var nive3 = {
      "titulo": "IMC",
      "classificacao": "Peso normal",
      "seuImc": calcularImc(),
      "altura": minhaAltura,
      "peso": meuPeso,
      "doencas": "Menor risco de doenças cardíacas e vasculares",
    "recomedacao":"Mantenha um vida sempre saudavel.",
      "desconsiderar":
          "Atletas e pessoas muito musculosas: porque não leva em consideração o peso dos músculos. Nesse caso a medida do pescoço é uma melhor opção. \n\n idosos: porque não leva em consideração a redução natural dos músculos nessas idade \n\n Durante a gravidez: porque não leva em consideração o crescimento do bebê",
    };
    var nive4 = {
      "titulo": "IMC",
      "classificacao": "Acima do peso	",
      "seuImc": calcularImc(),
      "altura": minhaAltura,
      "peso": meuPeso,
      "doencas": "Fadiga, má circulação, varizes",
      "recomedacao":
          "Se o resultado do IMC estiver acima do ideal e a pessoa não for muito musculosa, nem atleta, pode indicar que é preciso emagrecer, eliminando o acúmulo de gordura, que contribui para o peso alto.\n\n  Para isso deve-se comer somente alimentos ricos em vitaminas e minerais, tendo o cuidado de diminuir o consumo de alimentos industrializados e ricos em gordura, como massa folheada, bolos, biscoitos recheados e salgadinhos, por exemplo para que os resultados sejam alcançados ainda mais rápido é aconselhado fazer exercícios para aumentar o gasto calórico e aumentar o metabolismo. \n\n  Recorrer a chás e suplementos naturais pode ser um estímulo para ajudar a emagrecer de forma mais rápida e saudável, sem ter que passar fome. \n\n  Alguns exemplos são o chá de hibisco ou o chá de gengibre com canela, mas um nutricionista poderá indicar outros que sejam mais adequados às necessidades de cada pessoa. ",
      "desconsiderar":
          "Atletas e pessoas muito musculosas: porque não leva em consideração o peso dos músculos. Nesse caso a medida do pescoço é uma melhor opção. \n \n idosos: porque não leva em consideração a redução natural dos músculos nessas idade. \n\n Durante a gravidez: porque não leva em consideração o crescimento do bebê",
    };
    var nive5 = {
      "titulo": "IMC",
      "classificacao": "Obesidade Grau I",
      "seuImc": meuimc,
      "altura": minhaAltura,
      "peso": meuPeso,
      "doencas": "Diabetes, angina, infarto, aterosclerose",
      "recomedacao":
          "Se o resultado do IMC estiver acima do ideal e a pessoa não for muito musculosa, nem atleta, pode indicar que é preciso emagrecer, eliminando o acúmulo de gordura, que contribui para o peso alto.\n\n Para isso deve-se comer somente alimentos ricos em vitaminas e minerais, tendo o cuidado de diminuir o consumo de alimentos industrializados e ricos em gordura, como massa folheada, bolos, biscoitos recheados e salgadinhos, por exemplo para que os resultados sejam alcançados ainda mais rápido é aconselhado fazer exercícios para aumentar o gasto calórico e aumentar o metabolismo. Recorrer a chás e suplementos naturais pode ser um estímulo para ajudar a emagrecer de forma mais rápida e saudável, sem ter que passar fome. Alguns exemplos são o chá de hibisco ou o chá de gengibre com canela, mas um nutricionista poderá indicar outros que sejam mais adequados às necessidades de cada pessoa",
      "desconsiderar":
          "Atletas e pessoas muito musculosas: porque não leva em consideração o peso dos músculos. Nesse caso a medida do pescoço é uma melhor opção. \n\n idosos: porque não leva em consideração a redução natural dos músculos nessas idade \n\n Durante a gravidez: porque não leva em consideração o crescimento do bebê",
    };
    var nive6 = {
      "titulo": "IMC",
      "classificacao": "Obesidade Grau II",
      "seuImc": meuimc,
      "altura": minhaAltura,
      "peso": meuPeso,
      "doencas": "Apneia do sono, falta de ar",
      "doencas":
          "Refluxo, dificuldade para se mover, escaras, diabetes, infarto, AVC",
      "recomedacao":
          "Se o resultado do IMC estiver acima do ideal e a pessoa não for muito musculosa, nem atleta, pode indicar que é preciso emagrecer, eliminando o acúmulo de gordura, que contribui para o peso alto. Para isso deve-se comer somente alimentos ricos em vitaminas e minerais, tendo o cuidado de diminuir o consumo de alimentos industrializados e ricos em gordura, como massa folheada, bolos, biscoitos recheados e salgadinhos, por exemplo para que os resultados sejam alcançados ainda mais rápido é aconselhado fazer exercícios para aumentar o gasto calórico e aumentar o metabolismo. Recorrer a chás e suplementos naturais pode ser um estímulo para ajudar a emagrecer de forma mais rápida e saudável, sem ter que passar fome. Alguns exemplos são o chá de hibisco ou o chá de gengibre com canela, mas um nutricionista poderá indicar outros que sejam mais adequados às necessidades de cada pessoa",
      "desconsiderar":
          "Atletas e pessoas muito musculosas: porque não leva em consideração o peso dos músculos. Nesse caso a medida do pescoço é uma melhor opção. \n \n  idosos: porque não leva em consideração a redução natural dos músculos nessas idade Durante a gravidez: porque não leva em consideração o crescimento do bebê",
    };
    var nive7 = {
      "titulo": "IMC",
      "classificacao": "Obesidade Grau III",
      "seuImc": meuimc,
      "altura": minhaAltura,
      "peso": meuPeso,
      "doencas":
          "Refluxo, dificuldade para se mover, escaras, diabetes, infarto, AVC",
      "recomedacao":
          "Se o resultado do IMC estiver acima do ideal e a pessoa não for muito musculosa, nem atleta, pode indicar que é preciso emagrecer, eliminando o acúmulo de gordura, que contribui para o peso alto. \n Para isso deve-se comer somente alimentos ricos em vitaminas e minerais, tendo o cuidado de diminuir o consumo de alimentos industrializados e ricos em gordura, como massa folheada, bolos, biscoitos recheados e salgadinhos, por exemplo para que os resultados sejam alcançados ainda mais rápido é aconselhado fazer exercícios para aumentar o gasto calórico e aumentar o metabolismo. \n Recorrer a chás e suplementos naturais pode ser um estímulo para ajudar a emagrecer de forma mais rápida e saudável, sem ter que passar fome. Alguns exemplos são o chá de hibisco ou o chá de gengibre com canela, mas um nutricionista poderá indicar outros que sejam mais adequados às necessidades de cada pessoa",
      "desconsiderar":
          "Atletas e pessoas muito musculosas: porque não leva em consideração o peso dos músculos. Nesse caso a medida do pescoço é uma melhor opção. \n \n idosos: porque não leva em consideração a redução natural dos músculos nessas idade. \n\n Durante a gravidez: porque não leva em consideração o crescimento do bebê",
    };

    dados['nivel1'] = nive1;
    dados['nivel2'] = nive2;
    dados['nivel3'] = nive3;
    dados['nivel4'] = nive4;
    dados['nivel5'] = nive5;
    dados['nivel6'] = nive6;
    dados['nivel7'] = nive7;
  }

  void Iniciar() {
    meuimc.toStringAsPrecision(1);
    mostrarDados = {};
    _blocController1.sink.add(dados);
    dates();
  }

  final _blocController1 = new BehaviorSubject<dynamic>();

  Stream<dynamic> get dadosStream => _blocController1.stream;

  fecharStream() {
    _blocController1.close();
  }
}

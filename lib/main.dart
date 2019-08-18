import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Color _defaultColor = Colors.indigoAccent;

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String _infoText = "Informe seus dados!!!";

  void _resetCalculo() {
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _formKey = GlobalKey<FormState>();
      _infoText = "Informe seus dados!!!";
    });
  }

  void _calcularIMC() {
    setState(() {
      double altura = double.parse(alturaController.text) / 100;
      double peso = double.parse(pesoController.text);

      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        backgroundColor: _defaultColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetCalculo();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 120.0,
                color: _defaultColor,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: pesoController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso!";
                  }
                  double e = double.tryParse(value);
                  if (e == null) {
                    return 'coloque apenas numeros!';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    errorStyle: TextStyle(fontSize: 15.0),
                    labelStyle: TextStyle(color: _defaultColor)),
                style: TextStyle(fontSize: 25.0, color: _defaultColor),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: alturaController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura!";
                  }
                  double e = double.tryParse(value);
                  if (e == null) {
                    return 'coloque apenas numeros!';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    errorStyle: TextStyle(fontSize: 15.0),
                    labelStyle: TextStyle(color: _defaultColor)),
                style: TextStyle(fontSize: 25.0, color: _defaultColor),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        color: _defaultColor,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calcularIMC();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        }),
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _defaultColor, fontSize: 25.0),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

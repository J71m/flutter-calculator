import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String output = "0";

  clearScreen(){
    setState(() {
      output = "0"; 
    });
  }

  String _output = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText){
    if(buttonText == "CLEAR"){
         _output = "0";
         num1 = 0.0;
         num2 = 0.0;
         operand = "";
         clearScreen();
    } else if(buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "x") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if(buttonText == ".") {
      if(!(_output.contains("."))){
        _output =_output + buttonText;
      }
    } else if(buttonText == "="){
      num2 = double.parse(output);

      try {
        switch(operand) {
          case "+": { _output = (num1 + num2).toString(); }
          break;

          case "-": { _output = (num1 - num2).toString(); }
          break;

          case "x": { _output = (num1 * num2).toString(); }
          break;

          case "/": { _output = (num1 / num2).toString(); }
          break;

          default: { _output = "INVALID"; }
          break; 
        }

        var outputLength = _output.length;
        String lastChars = _output[outputLength-2] + _output[outputLength-1];
        if(lastChars==".0"){
          setState(() {
            print(_output);
            print(_output.substring(0, outputLength - 2));
            output = _output.substring(0, outputLength - 2);
          });
        } else {
          setState(() {
            output = double.parse(_output).toStringAsFixed(5); 
          });
        }

      } catch (e) {
        print(e);
        _output = "ERROR";
      }

      num1 = 0.0;
      num2 = 0.0;
    } else {
      if(_output == "0"){
        _output = buttonText;
      } else {
      _output = _output + buttonText;
      }
      setState(() {
        output = _output.toString(); 
      });
    }


  }

  Widget buildButton(String buttonText){
    return new Expanded(
        child: new OutlineButton(
          padding: new EdgeInsets.all(25.0),
          child: new Text(buttonText, style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400
          ),),
          onPressed: () => 
            buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        
        
        title: Text(widget.title),
      ),
      body: new Container(
        child: new Column(children: <Widget>[
          new Container(
            alignment: Alignment.centerRight,
            padding: new EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0
            ),
            child: new Text(output, style: new TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.bold
              ),
            ),
          ),

          new Container(
            alignment: Alignment.centerRight,
            padding: new EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0
            ),
            child: new Text(output, style: new TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w500
              ),
            ),
          ),

          new Expanded(
            child: new Divider(),
          ),
          new Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ]
          ),
          new Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("x"),
                ]
          ),
          new Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ]
          ),
          new Row(
                children: [
                  buildButton("."),
                  buildButton("0"),
                  buildButton("000"),
                  buildButton("+"),
                ]
          ),
          new Row(
                children: [
                  buildButton("CLEAR"),
                  buildButton("="),
                ]
          )
        ],)

      )
    );
  }
}

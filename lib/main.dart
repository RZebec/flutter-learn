import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Trip Cost Calculator',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  final _currencies = ['Dollars', 'Euro', 'Pounds'];

  final double _formDistance = 5.0;

  String _currency = 'Dollars';
  String result = '';

  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'e.g. 124',
                    labelStyle: textStyle,
                    labelText: 'Distance',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: distanceController,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'e.g. 17',
                    labelStyle: textStyle,
                    labelText: 'Distance per Unit',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: avgController,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'e.g. 1.65',
                          labelStyle: textStyle,
                          labelText: 'Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: priceController,
                      ),
                    ),
                    Container(width: _formDistance * 5),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies
                            .map(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        value: _currency,
                        onChanged: (String value) => _onDropdownChanged(value),
                      ),
                    ),
                  ],
                ),
              ),
              Text('Hello ' + result + '!'),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text('Submit', textScaleFactor: 1.5),
                      onPressed: () {
                        setState(() => result = _calculate());
                      },
                    ),
                  ),
                  Container(width: _formDistance * 5),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text('Reset', textScaleFactor: 1.5),
                      onPressed: () {
                        setState(() => _reset());
                      },
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  _onDropdownChanged(String value) {
    setState(() => this._currency = value);
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);

    double _totalCost = _distance / _consumption * _fuelCost;

    return 'The total cost of your trip is ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';

    setState(() => this.result = '');
  }
}

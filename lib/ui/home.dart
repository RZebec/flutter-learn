import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 30.0, left: 10.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Margherita',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 30.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Tomato, Mozarella, Basil',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Marinara',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 30.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Tomato, Garlic',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          PineconeImageWidget(),
          OrderButton(),
        ],
      ),
    );
  }
}

class PineconeImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String assetName = 'images/Pinecone.svg';
    Widget svg = SvgPicture.asset(assetName,
        color: Colors.deepOrangeAccent, width: 300.0, height: 300.0);

    return Container(child: svg, padding: EdgeInsets.all(30.0));
  }
}

class OrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      child: RaisedButton(
        child: Text('Order your Pizza'),
        color: Colors.lightGreen,
        elevation: 5.0,
        onPressed: () {
          order(context);
        },
      ),
    );
  }

  void order(BuildContext context) {
    var alert = AlertDialog(
      title: Text('Order completed'),
      content: Text('Thanks for your order'),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

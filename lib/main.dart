import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

void main() {
  //pass the keys sent by safaricom
  //the customer key
  //the customer secret
  //The keys are of type string
  MpesaFlutterPlugin.setConsumerKey('6sMH0TZrAb3ZI4GAbolXeU2BSZgzHKpx');
  MpesaFlutterPlugin.setConsumerSecret('navsNjXNciez38ed');

  runApp(MpesaIntergrationFlutter());
}

class MpesaIntergrationFlutter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DarajaAPIintergration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MpesaDaraja'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //instance of mpesa app
  //the instance is dynamic
  Future<void> lipanaMpesa() async {
    ///asynchronous process
    ///create an mpesa instance
    dynamic mpesaTransactionInstance;
    try {
      mpesaTransactionInstance =
          //this is a stk push
          //will open the mpesa stk app
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: 1.0,
        partyA: '254798071510',
        //THIS IS THE TILL NUMBER 
        partyB: "174379",
        callBackURL: Uri(
            scheme: "https",
            host: "mpesa-requestbin.herokuapp.com",
            path: "/16lzush1"),
        accountReference: 'flaviansshop',
        phoneNumber: '254798071510',
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: 'purchase',
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
      );
      //print the transaction reciept 
      print(mpesaTransactionInstance.toString());
      return mpesaTransactionInstance;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //lipana mpesa all
            //asynchronous call
            //makes an stk push o make thetransaction
            setState(() {
              //call the funct
              lipanaMpesa();
            });
          },
          tooltip: 'lipa na mpesa',
          child: Text(
              'lipa na mpesa')), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ignore_for_file: deprecated_member_use


import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/service/api_client.dart';

import './models/currencySign.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';
import './widgets/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'widgets/drop_down.dart';







void main(){ 
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown]);
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme:ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme:ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontWeight:FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Quicksand' ),
            button:TextStyle(color: Colors.white),
            
            ),
        appBarTheme: AppBarTheme(
          textTheme:ThemeData.light().textTheme.copyWith(
            headline6:TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
            )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiClient client=ApiClient();
  
  List<String> currencies;
  String from;
  String to;
  double rate;
  String result="";











List<Transaction1> _userTransactions=[];
int i=0;

List<Transaction1> get _recentTransactions {
  //   return _userTransactions.where((tx){
  //     return tx.date.isAfter(
  //       DateTime.now().subtract(
  //         Duration(days:7),
  //       ),
  //    );
  //   }
  // ).toList();      // run a default function, only days younger than 7 days are returned
  
    
  
   Firestore.instance.collection('expenses').orderBy('date').getDocuments().then((snapshot) { 
     
    //  print('fetching data...');
      _userTransactions=[];
     if(snapshot.documents.length>_userTransactions.length){
       
      snapshot.documents.forEach((document) {
       final Timestamp timestamp =document.data['date'];
       final DateTime dateToStore = timestamp.toDate();
       
       
       Transaction1 tx= Transaction1(
         id:document.documentID,
        title:document.data['title'],
        amount:document.data['amount'],
        date: dateToStore);
        setState(() {
            _userTransactions.add(tx);
          });
          
        
        
       
     });
     }
   });
   
   


    print(i++);
     
   
     for(var i=0;i<_userTransactions.length;i++){
          print(_userTransactions[i].date);
          print(_userTransactions[i].title);
          print(_userTransactions[i].amount);
          
        }
    

    

   
      return _userTransactions;
   
   
      
 
     


}






  void _addNewTransaction(String title, double amount, DateTime chosenDate){
    // final newTx=Transaction1(
    //   title: title,
    //   amount:amount,
    //   date:chosenDate,
     
    //   );
    DateTime dt=chosenDate;
    Timestamp ttp=Timestamp.fromDate(dt);



    setState(() {
 
      
    Firestore.instance.collection('expenses').add({
        
        'title': title,
        'amount': amount,
        'date': ttp
      });
    print('new record added');

      // _userTransactions.add(newTx);
    });  
  }







  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_){
        return NewTransaction(_addNewTransaction);
        // GestureDetector(
        //   onTap:(){},
        //   child: NewTransaction(_addNewTransaction),
        //   // behavior: HitTestBehavior.opaque,
        //   );
      });
  }

void _deleteTransaction(String id){
  // setState((){
  //   _userTransactions.removeWhere((tx)=>tx.title==id);
  // });
  setState(() {
    
  print('delete'+id);
  Firestore.instance.collection('expenses').document(id).delete();
  print('the record is deleted');
   });
  }

  // dropdow list
  String selectedValue = "USA";
List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("USA"),value: "USA"),
    DropdownMenuItem(child: Text("China"),value: "China"),
    DropdownMenuItem(child: Text("Ireland"),value: "Ireland"),
    DropdownMenuItem(child: Text("England"),value: "England"),
  ];
  return menuItems;
}
List<currencySign> _currencySign=[
  currencySign(countryName: 'Ireland', sign: '€'),
  currencySign(countryName: 'China', sign: '¥'),
  currencySign(countryName: 'USA', sign: '\$'),
  currencySign(countryName: 'England', sign: '￡')
];
 
 
 String get getSign {
   for(int i=0;i<_currencySign.length;i++){
     if(_currencySign[i].countryName==selectedValue)
     return _currencySign[i].sign;
   }
}



@override
void initState(){
  super.initState();
  (() async {
    List<String> list= await client.getCurrencies();
    setState((){
      currencies=list;
    });
  })();
}
   

  @override
  Widget build(BuildContext context) {
    
    final appBar=AppBar(
        title: Text('Personal Expenses',),
        actions: <Widget>[ 
          IconButton(onPressed: ()=>_startAddNewTransaction(context), 
          icon: Icon(Icons.add)),
          Container(
            child: DropdownButton(
              
              value: selectedValue, 
              onChanged: (String newValue){
                setState(() {
                  selectedValue = newValue;
                  });},
              items:dropdownItems
              ),
          )
        ],
      );
    
    
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: 
            //   <Widget>[ 
            //   Text('Show Chart'),
            //   Switch(value: true,),
            // ],

            // ),
            Container(
              height: (
                MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                child: Chart(_recentTransactions,getSign),
            ),
            Container(
              height:(MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
              child: TransactionList(_recentTransactions,_deleteTransaction,getSign)),
              Row(
                children: [
                  customDropDown(currencies, from, (val){
                    setState(() {
                      from=val;
                    });
                  })
                ],
              ),
          ],

        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed: ()=>_startAddNewTransaction(context),
      ),
      
      
      
    );
  }
}

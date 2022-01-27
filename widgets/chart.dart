import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {

  final List<Transaction1> recentTransactions;
  String sign;
  Chart(this.recentTransactions,this.sign);
 




  List<Map<String,Object>> get groupTransactionValues{
    return List.generate(7,(index){ 
      final weekDay=DateTime.now().subtract(
        Duration(days:index),
        );  //get the previous 7 days.
      double totalSum=0.0;

      for(var i=0;i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day==weekDay.day && 
        recentTransactions[i].date.month==weekDay.month &&
        recentTransactions[i].date.year==weekDay.year)
        {
          totalSum += recentTransactions[i].amount;
        }
      }
      


      return {'day':DateFormat.E().format(weekDay),'amount':totalSum};
    }).reversed.toList();
  }

  double get totalSpending{
    return groupTransactionValues.fold(0.0,(sum,item){
      return sum+item['amount'];
    });
  }
 

  @override
  Widget build(BuildContext context) {
    
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child:Container(
          padding:EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:groupTransactionValues.map((data){
              return Flexible(
            
                fit:FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  // in case the totalSpending is 0. the result will be NaN
                  totalSpending == 0 ? 0 : (data["amount"] as double) / totalSpending,
                  sign),
                 
              );
              }).toList(),

            
          ),
        ),
        );
  }
}
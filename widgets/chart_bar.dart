import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  String sign;

  ChartBar(this.label,this.spendingAmount,this.spendingPctOfTotal,this.sign);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(children:<Widget>[
      Container(
        height:constraints.maxHeight*0.15, // to keep the amount aligned
        child: FittedBox(
          child: Text('${sign}${spendingAmount.toStringAsFixed(0)}') // limit the space and shrink the number
          ),
      ),
      SizedBox(height:constraints.maxHeight*0.05,),
      Container(  
        height: constraints.maxHeight*0.6,
        width:10,
        child:Stack(  //overlapping other widgets
          children:<Widget>[ 
            Container(
              decoration: BoxDecoration( 
                border: Border.all(color: Colors.grey,width:1.0),
                color:Colors.purple,//Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(300),
              ),
            ),
            FractionallySizedBox(
              
              heightFactor: 1-spendingPctOfTotal,
              child:Container(
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(10),
                  color: Colors.grey,//Theme.of(context).primaryColor,
                 ),
            )
            ),
          ]
        ), 
      ),
      SizedBox(height:constraints.maxHeight*0.05),
      Container(
        height: constraints.maxHeight*0.15,
        child: FittedBox(child: Text(label))),
    ]);

    },); 
  }
}
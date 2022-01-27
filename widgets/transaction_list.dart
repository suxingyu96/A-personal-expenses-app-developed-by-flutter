
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction1> transactions;
  final Function deleteTx;

  final String sign;

  TransactionList(
    this.transactions,
    this.deleteTx,
    this.sign,
  );

   

  @override
  Widget build(BuildContext context) {
    print('call chart list');
    return transactions.isEmpty
        ? Column(
          children: <Widget>[ 
            Text(
              'No transactions added yet!',
              style:Theme.of(context).textTheme.headline6,),
            SizedBox(
              height: 10,),
            Container(
              height: 200,
              child: Image.asset('assets/images/waiting.png',fit:BoxFit.cover,)),

          ],
          // ListView.builder is useful if you don't know how long the list is and for long list
        ) :ListView.builder(
          itemBuilder: (ctx,index){ 
            return Card(
              elevation: 5,
              margin:EdgeInsets.symmetric(vertical: 8,horizontal: 5,),

              child: ListTile(
                leading:CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(child: Text('${sign}${transactions[index].amount}')),
                      // child: Text('\€${transactions[index].amount}')),
                    ),
                    ),
                    title:Text(
                      transactions[index].title,
                      style:Theme.of(context).textTheme.headline6,
                      ),
                    subtitle:Text(DateFormat.yMMMEd().format(transactions[index].date),
                    ),
                    trailing:IconButton(
                      onPressed: ()=>deleteTx(transactions[index].id), 
                      icon: Icon(Icons.delete),
                      color:Theme.of(context).errorColor,),
                    ),
            );
                  },
                  itemCount: transactions.length,
                  );
                  }
                  }

class FirebaseFirestore {
}
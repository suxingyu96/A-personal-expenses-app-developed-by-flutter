// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();

  final _amountController=TextEditingController();

  DateTime _selectDate;

  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }

    final enteredTitle=_titleController.text;
    final enteredAmount=double.parse(_amountController.text);
    
    if(enteredTitle.isEmpty || enteredAmount<=0 || _selectDate==null){
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectDate,
    );
      

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022), 
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if(pickedDate==null){
        return;
      }
      setState(() {
        _selectDate=pickedDate;    // use setState() to tell flutter the statefulwedget updated and 'built' should run
      });
      
      
    } );


    


  }





  @override
  Widget build(BuildContext context) {
    
    return Card(
            elevation: 5,
            child:Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:<Widget>[
                TextField(
                  decoration: InputDecoration(labelText:'Title'),
                  controller: _titleController,
                  onSubmitted: (_)=>_submitData(), // (_) argument is not used
                ),
                
                TextField(decoration: InputDecoration(labelText:'Amount'),

              
                controller: _amountController,
                // limit the keyboard, only the numbers can be typed in 
                keyboardType: TextInputType.numberWithOptions(decimal: true),  
                onSubmitted: (_)=>_submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    
                    children: <Widget>[ 
                      Expanded(      // it will take space as big as possible so the flatButton will be set at the very left
                        child: Text(_selectDate==null?
                        'No Date Chosen!':
                        'Picked Date: ${DateFormat.yMd().format(_selectDate)}'),
                      ), //use .format to take the date.
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _presentDatePicker, 
                        child: Text(
                          'Choose Date',
                          style:TextStyle(fontWeight: FontWeight.bold))
                        ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: _submitData, 
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                )
              ],

              ),
            ),
          );
  }
}
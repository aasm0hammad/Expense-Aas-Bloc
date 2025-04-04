import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/domain/app_constants.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_bloc.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class AddExpense extends StatefulWidget {
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  int selectedCatIndex= -1;
  List<String> mExpenseType= ['Debit','Credit'];
  String selectedType='Debit';
  DateTime?  selectedDateTime;
  DateFormat df= DateFormat.yMMMEd();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              expense("Enter title "),
              SizedBox(
                height: 11,
              ),
              expense("Enter Desc "),
              SizedBox(
                height: 11,
              ),
              expense("Enter Amount "),
              SizedBox(
                height: 11,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                                  itemCount: AppConstants.mCat.length,
                                  itemBuilder: (_, index) {

                                    return InkWell(
                                      onTap: (){
                                        selectedCatIndex=index;
                                        Navigator.pop(context);
                                        setState(() {

                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 11),
                                        child: Column(
                                          children: [
                                            Image.asset(AppConstants.mCat[index].imgPath,width: 50,height: 40,),
                                            Text(AppConstants.mCat[index].name),

                                          ],
                                        ),
                                      ),
                                    );





                                  }),
                            );
                          });
                    },
                    child:selectedCatIndex>0 ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Image.asset(AppConstants.mCat[selectedCatIndex].imgPath,width: 40,height: 40,),
                      SizedBox(width: 11,),
                      Text(AppConstants.mCat[selectedCatIndex].name),
                    ],): Text("Choose Category"),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder())),
              ),

              SizedBox(height: 11,),

             DropdownMenu(
               width: double.infinity,
                 initialSelection: selectedType,
                dropdownMenuEntries: mExpenseType.map((element){
                  return DropdownMenuEntry(value: element, label: element);
                }).toList(),),
              SizedBox(height: 11,),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(

                  onPressed: ()async{
                  await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 31)),
                      lastDate: DateTime.now());
                }, style:OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
                    child: Text(df.format(selectedDateTime?? DateTime.now()) ,
                ),),
              ),


              SizedBox(height: 11,),
              ElevatedButton(onPressed: (){
                context.read<ExpenseBloc>().add(
                  AddExpenseEvent(newExp: ExpenseModel(
                      eTitle: "eTitle",
                      eDesc: "eDesc",
                      eAmt: 45,
                      eBal: 78,
                      eCreatedAt: "eCreatedAt", eType: "eType", eCatId: 1)));


              }, child: Text("Add Expense"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,

                  minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )

              ),)


              /* DropdownButton(
                  value: selectedType,
                  items: mExpenseType.map((element){


                return DropdownMenuItem(
                    value: selectedType,
                    child: Text(element));
              }).toList(), onChanged: (value){
                selectedType=value!;
                setState(() {

                });

              })*/
            ],
          )),
    );
  }

  Widget expense(String hintText) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}

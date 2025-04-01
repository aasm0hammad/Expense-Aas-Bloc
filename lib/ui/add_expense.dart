import 'package:ass_expense/domain/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddExpense extends StatefulWidget {
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  int selectedCatIndex= -1;
  List<String> mExpenseType= ['Debit','Credit'];
  String selectedType='Debit';
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

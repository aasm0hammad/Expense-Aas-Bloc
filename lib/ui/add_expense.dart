import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/domain/app_constants.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_bloc.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_event.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_state.dart';
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
  var titleController=TextEditingController();
  var descController=TextEditingController();
  var amtController=TextEditingController();

  int selectedCatIndex= -1;
  List<String> mExpenseType= ['Debit','Credit'];
  String selectedType='Debit';
  DateTime?  selectedDateTime;
  DateFormat df= DateFormat.yMMMEd();
  final formKey=GlobalKey<FormState>();

  bool isLoading =false;



  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Expense"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                expense("Enter title ",titleController ,validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter  Title";

                  }else{
                    return null;
                  }
                }),
                SizedBox(
                  height: 11,
                ),
                expense("Enter Desc ",descController,validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Desc";

                  }else{
                    return null;
                  }
                }),
                SizedBox(
                  height: 11,
                ),
                expense("Enter Amount ",amtController,validator: (value){
                  if(value!.isEmpty){
                    return "Please Enter Amount";

                  }else{
                    return null;
                  }
                }),
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
                      child:selectedCatIndex>-1 ? Row(
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
                BlocListener<ExpenseBloc,ExpenseState>(
                  listener: (context,state){

                    if(state is ExpenseSuccessState){
                      isLoading=false;
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Expense Successful Add!")));
                      setState(() {

                      });

                    }

                  },
                  child: ElevatedButton(onPressed: (){
                    if(formKey.currentState!.validate()){
                    if(selectedCatIndex!=-1) {
                      context.read<ExpenseBloc>().add(
                          AddExpenseEvent(newExp: ExpenseModel(

                              eTitle: titleController.text,
                              eDesc: descController.text,

                              eAmt: double.parse(amtController.text),
                              eBal: 0,
                              eCreatedAt: (selectedDateTime ?? DateTime.now())
                                  .microsecondsSinceEpoch.toString(),
                              eType: selectedType,
                              eCatId: AppConstants.mCat[selectedCatIndex].id
                                  .toString())));
                    }
                    }


                  }, child: Text("Add Expense"),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,

                      minimumSize: Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )

                  ),),
                )


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
      ),
    );
  }

  Widget expense(String hintText,controller,
      {String? Function(String?)? validator}) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}

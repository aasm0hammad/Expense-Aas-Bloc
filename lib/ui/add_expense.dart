import 'package:ass_expense/domain/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AddExpense extends StatelessWidget {
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
                                    
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 11),
                                      child: Column(
                                        children: [
                                          Image.asset(AppConstants.mCat[index].imgPath,width: 50,height: 40,),
                                          Text(AppConstants.mCat[index].name),

                                        ],
                                      ),
                                    );

                                    



                                  }),
                            );
                          });
                    },
                    child: Text("Choose Category"),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder())),
              ),
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

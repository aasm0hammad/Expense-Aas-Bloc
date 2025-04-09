import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/DataBase/model/filter_expense_model.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_bloc.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_event.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NavHomePage extends StatefulWidget {
  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {

  List<FilterExpenseModel> allFilteredExpenses = [];
  DateFormat df = DateFormat.yMMMd();

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(GetInitialExpenseEvent());
  }

  /*final List<Map<String, dynamic>> mData = [
    {
      'date': 'Tuesday, 14',
      'total': "-\$1380",
      'items': [
        {
          'title': 'Shop',
          'subTitle': 'Buy new clothes',
          'amount': "-\$90",
          'icon': FontAwesomeIcons.cartShopping,
        },
        {
          'title': 'Electronic',
          'subTitle': 'Buy new iphone 14',
          'amount': "-\$1290",
          'icon': Icons.devices,
        },
      ]
    },
    {
      'date': 'Monday, 13',
      'total': "-\$60",
      'items': [
        {
          'title': 'Transportation',
          'subTitle': 'Trip to Malang',
          'amount': "-\$60",
          'icon': FontAwesomeIcons.car,
        },
      ]
    }
  ];*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              if (state is ExpenseLoadingState) {
                return Center(child: CircularProgressIndicator(),);
              }
              if (state is ExpenseFailureState) {
                return Center(
                  child: Text("${state.errorMsg}"),
                );
              }


              if (state is ExpenseSuccessState) {
                /// Filter data here
                filterExpenseByType(allExpenses: state.allExpense);


                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/logo_monety.png'),
                                Text(
                                  'Monety',
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "Poppins"),
                                )
                              ],
                            ),
                            Icon(Icons.search),
                          ],
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                    height: 40,
                                    width: 40,
                                  ),

                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Aas WebTech", style: TextStyle(
                                        color: Colors.grey, fontSize: 11),),
                                    Text("Flutter Developer", style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            ),

                            Container(
                              height: 20,
                              width: 100,
                              color: Colors.grey,
                            )
                          ],
                        ),

                        SizedBox(
                          height: 16,
                        ),

                        Container(


                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Color(0xff6674D3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Expense Total", style: TextStyle(
                                        color: Colors.white, fontSize: 10),),
                                    Text("\$3,734", style: TextStyle(
                                        fontSize: 25, color: Colors.white),),
                                    Row(
                                      children: [
                                        Text('+\$240', style: TextStyle(
                                            backgroundColor: Colors.red,
                                            color: Colors.white),),
                                        SizedBox(width: 8,),
                                        Text("than last Months",
                                          style: TextStyle(
                                              color: Colors.white),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ClipRRect(

                                child: Image.asset("assets/images/img.png",),
                                borderRadius: BorderRadius.circular(11),
                              )

                            ],
                          ),
                        ),
                        SizedBox(height: 11,),

                        Text("Expense List", style: TextStyle(color: Colors
                            .black, fontSize: 18, fontWeight: FontWeight
                            .bold),),
                        SizedBox(height: 16,),

                        Column(
                          children: allFilteredExpenses.map((filterData) {

                            return Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(filterData.type,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
                                      Text(
                                        '\$${filterData.totalAmt
                                            .toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 1),

                                  // Expense Items List



                                  Column(
                                    children: filterData.mExpenses.map((ex){
                                     return ListTile(
                                        leading: Text(ex.eCatId),


                                        title: Text(ex.eTitle,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(ex.eDesc),
                                        trailing: Text("${ex.eAmt}"
                                          ,

                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,),
                                        ),
                                      );

                                    }).toList(),
                                  ),

                                ],
                              ),
                            );
                          }).toList(),
                        )


                      ],
                    ),
                  ),
                );
              }

              return Container();
            }
        ),
      ),
    );
  }

  void filterExpenseByType({required List<ExpenseModel> allExpenses}) {
    allFilteredExpenses.clear();
    List<String> uniqueDates = [];

    ///data wise
    for (ExpenseModel eachExp in allExpenses) {
      String date = df.format(
          DateTime.fromMicrosecondsSinceEpoch(int.parse(eachExp.eCreatedAt)));
      if (!uniqueDates.contains(date)) {
        uniqueDates.add(date);
      }
    }
    print(uniqueDates);
    for (String eachDate in uniqueDates) {
      num eachDateTotalAmt = 0.0;
      List<ExpenseModel> eachDateExpenses = [];
      for (ExpenseModel eachExp in allExpenses) {
        String date = df.format(
            DateTime.fromMicrosecondsSinceEpoch(int.parse(eachExp.eCreatedAt)));


        if (eachDate == date) {
          eachDateExpenses.add(eachExp);
          if (eachExp.eType == 'Debit') {
            eachDateTotalAmt -= eachExp.eAmt;
          } else {
            eachDateTotalAmt += eachExp.eAmt;
          }
        }
      }

      allFilteredExpenses.add(FilterExpenseModel(
          type: eachDate,
          totalAmt: eachDateTotalAmt,
          mExpenses: eachDateExpenses));
    }

    print(allFilteredExpenses[0].mExpenses[0].eAmt);
  }
}

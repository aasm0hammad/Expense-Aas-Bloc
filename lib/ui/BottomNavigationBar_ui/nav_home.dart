import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/DataBase/model/filter_expense_model.dart';
import 'package:ass_expense/domain/app_constants.dart';
import 'package:ass_expense/routes/app_routes.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_bloc.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_event.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavHomePage extends StatefulWidget {
  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  TextEditingController totalBal = TextEditingController();
  List<FilterExpenseModel> allFilteredExpenses = [];
  List<String> mFilterCat = ['Day', 'Date', 'Month', 'Year'];
  String selectedItem = 'Date';
  DateFormat df = DateFormat.yMMMEd();

  bool isLoading = false;
  bool isLoaded = false;

  num bal = 0.0;

  @override
  void initState() {
    super.initState();
    getBalanceFromPrefs();
    context.read<ExpenseBloc>().add(GetInitialExpenseEvent());
  }

  Future<void> getBalanceFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bal = prefs.getDouble("bal") ?? 0.0;
    setState(() {

    });
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
            /*buildWhen: (p ,context){
              return !isLoading;
            },*/
            builder: (context, state) {
          if (state is ExpenseLoadingState) {
            isLoading = true;
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is ExpenseFailureState) {
            return Center(
              child: Text("${state.errorMsg}"),
            );
          }

          if (state is ExpenseSuccessState) {
            /// Filter data here
            allFilteredExpenses = state.allExpense.reversed.toList();

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
                        InkWell(
                            onTap: ()async{
                              SharedPreferences pref=await SharedPreferences.getInstance();
                              await pref.setInt('key',0);
                              Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_LOGIN);

                            },
                            child: Icon(Icons.logout)),
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
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aas WebTech",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                                Text(
                                  "Flutter Developer",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F7FA),
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownMenu(
                                initialSelection: selectedItem,
                                onSelected: (value) {
                                  if (value == "Day") {
                                    context
                                        .read<ExpenseBloc>()
                                        .add(GetInitialExpenseEvent(type: 1));
                                  } else if (value == "Date") {
                                    context
                                        .read<ExpenseBloc>()
                                        .add(GetInitialExpenseEvent(type: 2));
                                  } else if (value == "Month") {
                                    context
                                        .read<ExpenseBloc>()
                                        .add(GetInitialExpenseEvent(type: 3));
                                  } else {
                                    context
                                        .read<ExpenseBloc>()
                                        .add(GetInitialExpenseEvent(type: 4));
                                  }
                                },
                                dropdownMenuEntries: mFilterCat.map((element) {
                                  return DropdownMenuEntry(
                                      value: element, label: element);
                                }).toList()),
                          ),
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
                        color: bal>0?  Color(0xff6674D3):Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expense Total",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext c) {
                                        return Container(
                                          padding: EdgeInsets.all(16),
                                          height: 150,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: totalBal,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      "Enter New Balance",
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              ElevatedButton.icon(
                                                icon: Icon(Icons.done),
                                                label: Text("Save Balance"),
                                                onPressed: () async {
                                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                                  await pref.setDouble("bal", double.parse(totalBal.text));
                                                  setState(() {
                                                    bal = double.parse(totalBal.text);
                                                  });
                                                  //totalBal.clear();
                                                  Navigator.pop(context);// Close bottom sheet

                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );

                                    /* Row(
                                        children: [
                                          TextField(

                                            controller: totalBal,


                                          ),
                                          IconButton.outlined(onPressed: ()async{
                                            SharedPreferences pref=await SharedPreferences.getInstance();
                                            pref.setDouble("bal", double.parse(totalBal.text));

                                          }, icon: Icon(Icons.done,color: Colors.black,))
                                        ],
                                      );*/
                                  },
                                  child: Text(
                                    "\$${bal}",
                                    style: TextStyle(
                                        fontSize: 25, color:  Colors.white),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '+\$240',
                                      style: TextStyle(
                                          backgroundColor: Colors.red,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "than last Months",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/img.png",
                            ),
                            borderRadius: BorderRadius.circular(11),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Expense List",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allFilteredExpenses.length,
                          itemBuilder: (context, index) {
                            var filterData = allFilteredExpenses[index];
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        filterData.type,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
                                      Text(
                                        '\$${filterData.totalAmt.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ],
                                  ),
                                  Divider(thickness: 1),
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: filterData.mExpenses.length,
                                      itemBuilder: (context, childIndex) {
                                        var eachExp =
                                            filterData.mExpenses[childIndex];

                                        return ListTile(
                                          leading: Image.asset(AppConstants.mCat
                                              .where((eachCat) {
                                                return eachCat.id ==
                                                    int.parse(eachExp.eCatId);
                                              })
                                              .toList()[0]
                                              .imgPath),
                                          title: Text(
                                            eachExp.eTitle,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(eachExp.eDesc),
                                          trailing: Text(
                                            "${eachExp.eType == 'Debit' ? '-' : '+'} ₹${eachExp.eAmt}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: eachExp.eType == 'Debit'
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    )

                    /*  children: allFilteredExpenses.map((filterData) {

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
                          }).toList(),*/
                  ],
                ),
              ),
            );
          }

          return Container();
        }),
      ),
    );
  }

/* void filterExpenseByType({required List<ExpenseModel> allExpenses}) {
    allFilteredExpenses.clear();


    print(allFilteredExpenses[0].mExpenses[0].eCatId);
    print(allFilteredExpenses);
  }
*/
}

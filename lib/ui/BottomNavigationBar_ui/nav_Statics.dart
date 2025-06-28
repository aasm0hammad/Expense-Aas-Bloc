import 'package:ass_expense/DataBase/model/category_model.dart';
import 'package:ass_expense/DataBase/model/expense_model.dart';
import 'package:ass_expense/DataBase/model/filter_expense_model.dart';
import 'package:ass_expense/domain/app_constants.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_bloc.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_event.dart';
import 'package:ass_expense/ui/login_signup/expense/expense_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavStaticsPage extends StatefulWidget {
  @override
  State<NavStaticsPage> createState() => _NavStaticsPageState();
}

class _NavStaticsPageState extends State<NavStaticsPage> {
  double spent = 0;
  double budget = 900;

  TextEditingController totalBal = TextEditingController();

  List<String> mFilterCat = ['Day', 'Date', 'Month', 'Year'];
  String selectedItem = 'Day';

  bool isLoading = false;
  List<Map<String, dynamic>> myData = [
    {"title": "Mon"},
    {"title": "Tue"},
    {"title": "Wed"},
    {"title": "Thu"},
    {"title": "Fri"},
    {"title": "Sat"},
    {"title": "Sun"},
  ];

  List<Map<String, dynamic>> gData = [
    {'x': 1, 'y': 150.0},
    {'x': 2, 'y': 50.0},
    {'x': 3, 'y': 160.0},
    {'x': 4, 'y': 10.0},
    {'x': 5, 'y': 146.0},
    {'x': 6, 'y': 122.0},
    {'x': 7, 'y': 46.0},
  ];

  @override
  void initState() {
    super.initState();
    getPerMonthBal();
    context.read<ExpenseBloc>().add(GetInitialExpenseEvent(type: 1));
  }

  Future<void> getPerMonthBal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    spent = await preferences.getDouble("bal") ?? 0.0;
    budget = await preferences.getDouble("mbal") ?? 0.0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int xCount = 0;

    /*double highestValue=0;
    int highestValueX=0;
    double lowestValue=1000;
    int lowestValueX=0;

    gData.forEach((element){
      if(element['y']>highestValue){
        highestValue=element['y'];
        highestValueX=element['x'];
      }
      if(element['y']<lowestValue){
        lowestValue=element['y'];
        lowestValueX=element['x'];
      }
    });*/

    //final percent = (budget > 0) ? (spent / budget).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Statistics",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
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
                BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (context, state) {
                  if (state is ExpenseLoadingState) {
                    isLoading = true;
                    CircularProgressIndicator(
                      color: Colors.black,
                    );
                  }
                  if (state is ExpenseFailureState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                  if (state is ExpenseSuccessState) {
                    isLoading = false;
                    List<FilterExpenseModel> mData = state.allExpense;


                    List<ExpenseModel> allExpenses =
                        state.allExpense.expand((e) => e.mExpenses).toList();

                    Map<String, num> catTotals =
                        AppConstants.calculateCategoryTotals(allExpenses);
                    List<Map<String, dynamic>> catPercentages =
                        AppConstants.getCategoryPercentageData(catTotals);

                    return Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Color(0xFF5A62F6),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total expense",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
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
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  ElevatedButton.icon(
                                                    icon: Icon(Icons.done),
                                                    label: Text("Save Balance"),
                                                    onPressed: () async {
                                                      SharedPreferences pref =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await pref.setDouble(
                                                          "mbal",
                                                          double.parse(
                                                              totalBal.text));
                                                      setState(() {
                                                        // bal = double.parse(totalBal.text);
                                                      });
                                                      totalBal.clear();
                                                      Navigator.pop(
                                                          context); // Close bottom sheet
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "\$${-1 * spent.toInt()}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            " / \$${budget.toStringAsFixed(0)} per month",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value:
                                        ((-1 * spent) / budget).clamp(0.0, 1.0),
                                    minHeight: 6,
                                    backgroundColor: Colors.white24,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFFFC107)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 300,
                          child: BarChart(
                              duration: Duration(seconds: 3),
                              curve: Curves.bounceInOut,
                              BarChartData(
                                backgroundColor: Colors.transparent,
                                borderData: FlBorderData(show: false),
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(
                                    topTitles: AxisTitles(),
                                    bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              int index = value.toInt();

                                              dynamic title = '';
                                              if (index >= 0 &&
                                                  index < mData.length) {
                                                title = mData[index].type;
                                              }

                                              return SideTitleWidget(
                                                  space: 8,
                                                  child: Text(
                                                    title,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  meta: meta);
                                            })),
                                    rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            reservedSize: 50,
                                            showTitles: false)),

                                    leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            // maxIncluded: true,
                                            interval: 10000,
                                            reservedSize: 50,
                                            showTitles: true)),),
                                extraLinesData:
                                    ExtraLinesData(horizontalLines: [
                                  HorizontalLine(
                                      y: 100000,
                                      color: Colors.red,
                                      strokeWidth: 2,
                                      label: HorizontalLineLabel(
                                          show: true,
                                          alignment: Alignment.topLeft,
                                          direction: LabelDirection.horizontal,
                                          labelResolver: (_) {
                                            return '2000 Limit';
                                          }))
                                ]),
                                barGroups: mData.asMap().entries.map((entry) {
                                  FilterExpenseModel element = entry.value;
                                  int index = entry.key;
                                  return BarChartGroupData(x: index, barRods: [
                                    BarChartRodData(
                                        toY: element.totalAmt < 0
                                            ? element.totalAmt.toDouble() * -1
                                            : element.totalAmt.toDouble(),
                                        color: Colors.green,
                                        width: 20,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(3))),
                                  ]);
                                }).toList(),
                                /* BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 185.0),]),
                          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY:

                          @override
                          void debugFillProperties(DiagnosticPropertiesBuilder properties) {
                            super.debugFillProperties(properties);
                            properties.add(DoubleProperty('budget', budget));
                          }75.0),]),
                          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 110.0),]),*/
                              )),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Spending Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(
                                "Your expenses are divided into ${catPercentages.length} categories"),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: catPercentages.map((e) {
                                return Expanded(
                                  flex: int.parse(e['percentage']),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: double.infinity,
                                        color: e['color'],
                                      ),
                                      Text("${e['percentage']}%",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),

                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: catTotals.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 3 / 2,
                          ),
                          itemBuilder: (context, index) {
                            String catId = catTotals.keys.toList()[index];
                            num total = catTotals[catId]!;

                            var catModel = AppConstants.mCat.firstWhere(
                              (cat) => cat.id.toString() == catId,
                              orElse: () => CategoryModel(
                                  id: 0, name: 'Unknown', imgPath: ''),
                            );

                            return Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(catModel.imgPath,
                                      width: 40, height: 40),
                                  SizedBox(height: 6),
                                  Text(catModel.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text(
                                    "${total < 0 ? "-" : "+"} ₹${total.abs().toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color:
                                          total < 0 ? Colors.red : Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

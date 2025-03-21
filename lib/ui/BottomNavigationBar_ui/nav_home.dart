import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> mData=[
    {
      'date': 'Tuesday, 14',
      'total': "-\$1380",
      'items':[
        {
          'title':'Shop',
          'subTitle': 'Buy new clothes',
          'amount':"-\$90",
          'icon': FontAwesomeIcons.cartShopping,

        },
        {
          'title':'Electronic',
          'subTitle': 'Buy new iphone 14',
          'amount':"-\$1290",
          'icon': Icons.devices,

        },
      ]
    },
    {
      'date': 'Monday, 13',
      'total': "-\$60",
      'items':[
        {
          'title':'Transportation',
          'subTitle': 'Trip to Malang',
          'amount':"-\$60",
          'icon': FontAwesomeIcons.car,

        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 25,left: 8,right: 8),
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
                    style: TextStyle( fontSize: 16,fontFamily:"Poppins" ),
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
                      Text("Aas WebTech",style: TextStyle(color: Colors.grey,fontSize: 11),),
                      Text("Flutter Developer",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)
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


            height:100 ,
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
                      Text("Expense Total",style: TextStyle(color: Colors.white,fontSize: 10),),
                      Text("\$3,734",style: TextStyle(fontSize: 25,color: Colors.white),),
                      Row(
                        children: [
                          Text('+\$240',style: TextStyle(backgroundColor: Colors.red,color: Colors.white),),
                          SizedBox(width: 8,),
                          Text("than last Months",style: TextStyle(color: Colors.white),),
                        ],
                      )
                    ],
                  ),
                ),
                ClipRRect(
                  
                  child:Image.asset("assets/images/img.png",) ,
                  borderRadius: BorderRadius.circular(11),
                )

              ],
            ),
          ),
          SizedBox(height: 11,),

          Text("Expense List",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 16,),

          Column(
            children: mData.map((data) {
              return Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data['date'],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Poppins'),
                        ),
                        Text(
                          data['total'],
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
                      children: List.generate(data['items'].length, (index) {
                        var item = data['items'][index];
                        return ListTile(
                          leading: Icon(
                            item['icon'],
                            color: Colors.blue,
                          ),
                          title: Text(
                            item['title'],
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['subTitle']),
                          trailing: Text(
                            item['amount'],

                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold,),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }).toList(),
          )


        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:money_management_app/models/transaction.dart';
import 'package:money_management_app/providers/transactions_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Map transactionLogoMap = {
      'SalaryColor': Colors.green[100],
      'SalaryIcon': Icon(Icons.attach_money, color: Colors.green, size:30),
      'ShoppingColor': Colors.red[100],
      'ShoppingIcon': Icon(Icons.shopping_bag_outlined, color: Colors.red[400], size:30),
      'FoodColor': Colors.green[100],
      'FoodIcon': Icon(Icons.bakery_dining, color: Colors.green[800], size:30)
    };

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _name;


  @override
  void initState() {
    super.initState();
    _name = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('name') ?? "User";
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Welcome text and settings button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello,",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  FutureBuilder<String>(
                      future: _name,
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                snapshot.data.toString(),
                                style: TextStyle(color: Colors.grey, fontSize: 20),
                              );
                            }
                        }
                      })
                ],
              ),
              IconButton(onPressed: () {/*Navigator.pushNamed(context, '/settings');*/settingsModalBottomSheet(context);}, icon: Icon(Icons.settings)),
            ],
          ),
          // Balance card
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.all(
              12.0,
            ),
            child: Ink(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.purple,
                    Colors.blueAccent,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      24.0,
                    ),
                  ),
                  // color: Static.PrimaryColor,
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 8.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'Total Balance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22.0,
                        // fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      context.watch<TransactionProvider>().getFullBalance().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardIncome(
                            context.watch<TransactionProvider>().getIncome().toString()
                          ),
                          cardExpense(
                            context.watch<TransactionProvider>().getExpense().toString()
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Recent transactions
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: const Text("Recent transactions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          //buildTransactionCard(),
          Container(
            child: Consumer<TransactionProvider>(
              builder: (BuildContext context, TransactionProvider bloc, _) => 
                ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: bloc.length,
                  itemBuilder: 
                    (BuildContext context, int index) => buildTransactionCard(bloc.transactions[index]),
              ),
              
            ),
          ),
        ],
      ),
    );
  }


  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_downward,
            size: 28.0,
            color: Colors.green[700],
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Income",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: EdgeInsets.all(
            6.0,
          ),
          child: Icon(
            Icons.arrow_upward,
            size: 28.0,
            color: Colors.red[700],
          ),
          margin: EdgeInsets.only(
            right: 8.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expense",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTransactionCard(Transaction value) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 50, 
            height: 50,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: transactionLogoMap[value.category + "Color"] ?? Colors.amber[200],
            ), 
            child: transactionLogoMap[value.category + "Icon"] ?? Icon(Icons.question_mark, color: Colors.amber[700], size:30),
          ),
          Expanded(
            child: Container(
              //color: Colors.blue,
              alignment: Alignment.centerLeft,
              height: 50,
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value.description, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),overflow: TextOverflow.ellipsis,),
                  Text(value.category, style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
          ),
          Container(
              //color: Colors.blue,
              alignment: Alignment.centerRight,
              height: 50,
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value.amount.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  Text(value.date.toString(), style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
        ],
      ),
    );
  }

}

void settingsModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(),
    builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            //Handle
            FractionallySizedBox(
              widthFactor: 0.25,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                child: Container(
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                  ),
                ),
              ),
            ),

            // Name textfield
            Container(
              decoration: BoxDecoration( borderRadius: BorderRadius.circular(30), color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Name:"),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
                  ]),
              ),
            ),

          ],
          
        ),
      );
    });
}

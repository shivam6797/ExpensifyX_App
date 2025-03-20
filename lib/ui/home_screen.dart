import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Map<String, dynamic>> expenses = [
    {
      'date': 'Tuesday, 14',
      'total': '-\$1380',
      'items': [
        {
          'title': 'Shop',
          'subtitle': 'Buy new clothes',
          'amount': '-\$90',
          'icon': FontAwesomeIcons.cartShopping,
          'color': Color(0xff6674d3)
        },
        {
          'title': 'Electronic',
          'subtitle': 'Buy new iPhone 14',
          'amount': '-\$1290',
          'icon': Icons.devices,
          'color': Colors.orangeAccent
        },
      ]
    },
    {
      'date': 'Monday, 13',
      'total': '-\$60',
      'items': [
        {
          'title': 'Transportation',
          'subtitle': 'Trip to Malang',
          'amount': '-\$60',
          'icon': FontAwesomeIcons.bus,
          'color': Color(0xffe78bbc)
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 200,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 10),
              child: Image.asset(
                'assets/images/monety_logo.png',
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Monety",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              FontAwesomeIcons.search,
              color: Colors.black,
              size: 18,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildExpenseCard(),
              const SizedBox(height: 20),
              Text('Expense List',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins")),
              const SizedBox(height: 15),
              _buildExpenseList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/boy_latest.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Morning',
                    style:
                        TextStyle(color: Colors.grey, fontFamily: "Poppins")),
                Text('Błaszczykowski',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins")),
              ],
            ),
          ],
        ),
        IntrinsicWidth(
          child: Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            decoration: BoxDecoration(
              color: Color(0xfff0f3ff),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: "This month",
                icon: SizedBox.shrink(),
                dropdownColor: Colors.white,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: "Poppins"),
                onChanged: (String? newValue) {},
                items: ["This month", "Last month", "Custom"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Text(value),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(FontAwesomeIcons.chevronDown,
                            size: 10, color: Colors.black)
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildExpenseCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xff6674d3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expense total',
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Poppins")),
                SizedBox(height: 2),
                Text('\$3,734',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        color: Colors.white)),
                SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xffdd6565),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text('+\$240',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(width: 5),
                    Text('than last month',
                        style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            fontFamily: "Poppins")),
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Transform.scale(
              scale: 2,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Image.asset(
                  'assets/images/home_image.png',
                  height: 90,
                  width: 200,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseList() {
    return Column(
      children:
          expenses.map((expense) => _buildExpenseCategory(expense)).toList(),
    );
  }

  Widget _buildExpenseCategory(Map<String, dynamic> expense) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(expense['date'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins")),
                Text(expense['total'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: "Poppins")),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
          Column(
            children: (expense['items'] as List)
                .map((item) => _buildExpenseItem(item))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        dense: true,
        leading: CircleAvatar(
          backgroundColor: item['color'].withOpacity(0.1),
          child: Icon(
            item['icon'],
            color: item['color'],
            size: 15,
          ),
        ),
        title: Text(item['title'],
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                color: Colors.black)),
        subtitle: Text(item['subtitle'],
            style: TextStyle(
                fontSize: 12,
                fontFamily: "Poppins",
                color: Colors.black.withOpacity(0.6))),
        trailing: Text(item['amount'],
            style: TextStyle(
                color: Color(0xffe78bbc),
                fontSize: 14,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  String selectedPeriod = "Week";
  final List<String> periods = ["Month", "Week", "Days"];
  String selectedTime = "This month";
  final List<String> time = ["This week", "This month", "This days"];
  int selectedIndex = 3;
  final List<double> expenses = [640, 850, 622, 960, 732];
  final double limit = 900;
  final List<Color> colors = [
    Color(0xff6273d3),
    Color(0xffe78bba),
    Color(0xffe9c490),
    Color(0xff68c1de),
    Color(0xffdc6666),
    Color(0xff6dd698),
  ];
  final List<double> percentages = [40, 25, 15, 10, 5, 5];
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Shop",
      "expense": -1190,
      "icon": Icons.shopping_cart,
      "color": Colors.blue
    },
    {
      "title": "Transport",
      "expense": -867,
      "icon": Icons.directions_car,
      "color": Colors.red
    },
    {
      "title": "Food",
      "expense": -450,
      "icon": Icons.restaurant,
      "color": Colors.orange
    },
    {
      "title": "Entertainment",
      "expense": -320,
      "icon": Icons.movie,
      "color": Colors.purple
    },
    {
      "title": "Health",
      "expense": -290,
      "icon": Icons.health_and_safety,
      "color": Colors.green
    },
    {
      "title": "Education",
      "expense": -610,
      "icon": Icons.school,
      "color": Colors.yellow.shade700
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        title: Text("Statistic",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                color: Colors.black)),
        actions: [
          IntrinsicWidth(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              decoration: BoxDecoration(
                color: Color(0xfff0f3ff),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedTime,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      FontAwesomeIcons.chevronDown,
                      size: 10,
                      color: Colors.black,
                    ),
                  ),
                  dropdownColor: Colors.white,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: "Poppins"),
                  onChanged: (newValue) {
                    setState(() {
                      selectedTime = newValue!;
                    });
                  },
                  items: time.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTotalExpenseCard(),
            SizedBox(height: 20),
            _buildRowTitleExpense(),
            const SizedBox(height: 10),
            _buildBarGraph(),
            const SizedBox(height: 20),
            _buildTitleProgressLine(),
            const SizedBox(height: 15),
            _buildProgressLine(),
            SizedBox(
              height: 20,
            ),
            _buildGridView(),
          ],
        ),
      ),
    );
  }

  Widget _buildRowTitleExpense() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Expense Breakdown",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins")),
            Text("Limit \$900 /Week",
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins")),
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
                value: selectedPeriod,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    FontAwesomeIcons.chevronDown,
                    size: 10,
                    color: Colors.black,
                  ),
                ),
                dropdownColor: Colors.white,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: "Poppins"),
                onChanged: (newValue) {
                  setState(() {
                    selectedPeriod = newValue!;
                  });
                },
                items: periods.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600),
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

  Widget _buildTotalExpenseCard() {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xff6674d3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total expense",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontFamily: "Poppins")),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  FontAwesomeIcons.ellipsis,
                  color: Colors.white,
                  size: 15,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("\$3,734",
                  style: TextStyle(
                      height: 1.3,
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 5),
              Text("/ \$4000 per month",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),

          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 3334 / 4000,
              minHeight: 5,
              backgroundColor: Colors.transparent.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffe7c78d)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarGraph() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 8),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("\$${limit.toInt()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 5),
              Expanded(
                child: Divider(
                  color: Colors.red,
                  thickness: 2,
                ),
              ),
            ],
          ),
        ),

        AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              barGroups: _buildBarGroups(),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: false,
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 300,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text("\$${value.toInt()}",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold));
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      List<String> weeks = ["W1", "W2", "W3", "W4", "W5"];
                      return Text(weeks[value.toInt()],
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold));
                    },
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(expenses.length, (index) {
      bool isOverLimit = expenses[index] > limit;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: expenses[index],
            color: isOverLimit ? Colors.red : Colors.blue,
            width: 28,
            borderRadius: BorderRadius.circular(6),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 1200,
              color: Colors.white,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTitleProgressLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Spending Details",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins")),
        Text("Your expenses are divided into 6 categories",
            style: TextStyle(
                fontSize: 14, color: Color(0xff71717d), fontFamily: "Poppins")),
      ],
    );
  }

  Widget _buildProgressLine() {
    return Column(
      children: [
        Row(
          children: List.generate(percentages.length, (index) {
            return Expanded(
              flex:
                  percentages[index].toInt(),
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.only(
                    topLeft: index == 0 ? Radius.circular(8) : Radius.zero,
                    bottomLeft: index == 0 ? Radius.circular(8) : Radius.zero,
                    topRight: index == percentages.length - 1
                        ? Radius.circular(8)
                        : Radius.zero,
                    bottomRight: index == percentages.length - 1
                        ? Radius.circular(8)
                        : Radius.zero,
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(percentages.length, (index) {
            return Expanded(
              flex: percentages[index].toInt(),
              child: Align(
                alignment:
                    Alignment.center,
                child: Text(
                  "${percentages[index].toInt()}%",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildGridView() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          childAspectRatio: 2.5,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal:2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: category['color'].withOpacity(0.2),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Icon(
                  category['icon'],
                  color: category['color'],
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category['title'],
                    overflow:
                        TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    "\$${category['expense'].abs()}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffe78bba),
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

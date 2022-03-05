import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';

class ProductSales extends StatelessWidget {
  const ProductSales({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Card(
            elevation: 5,
            shadowColor: Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 15.0),
                  child: Text(
                    "Yearly Product Sales",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                /* YearSalesChart() */
              ],
            ),
          ),
        ),
      ],
    );
  }
}
//
// class YearSalesChart extends StatefulWidget {
//   const YearSalesChart({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<YearSalesChart> createState() => _YearSalesChartState();
// }
//
// class _YearSalesChartState extends State<YearSalesChart> {
//   late TooltipBehavior _tooltipBehavior;
//
//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SfCartesianChart(
//         primaryXAxis: CategoryAxis(),
//         legend: Legend(isVisible: false),
//         tooltipBehavior: _tooltipBehavior,
//         series: <LineSeries<YearSalesData, String>>[
//           LineSeries<YearSalesData, String>(
//             dataSource: <YearSalesData>[
//               YearSalesData('Jan', 35),
//               YearSalesData('Feb', 28),
//               YearSalesData('Mar', 34),
//               YearSalesData('Apr', 32),
//               YearSalesData('May', 40),
//               YearSalesData('June', 22),
//               YearSalesData('July', 33),
//               YearSalesData('August', 51),
//               YearSalesData('September', 34),
//               YearSalesData('October', 23),
//               YearSalesData('November', 31),
//               YearSalesData('December', 60),
//             ],
//             xValueMapper: (YearSalesData sales, _) => sales.year,
//             yValueMapper: (YearSalesData sales, _) => sales.sales,
//             // Enable data label
//             dataLabelSettings: const DataLabelSettings(isVisible: true),
//           ),
//         ]);
//   }
// }
//
// class YearSalesData {
//   YearSalesData(this.year, this.sales);
//   final String year;
//   final double sales;
// }

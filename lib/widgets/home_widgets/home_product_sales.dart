import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsms_mobileapp_swd/blocs/receipt_detail/receipt_detail_bloc.dart';
import 'package:gsms_mobileapp_swd/services/api_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductSales extends StatefulWidget {
  const ProductSales({Key? key}) : super(key: key);

  @override
  State<ProductSales> createState() => _ProductSalesState();
}

class _ProductSalesState extends State<ProductSales> {
  final apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
      child: SizedBox(
        height: 300,
        width: 215,
        child: Card(
          elevation: 5,
          shadowColor: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 15.0),
                child: Text(
                  "Top product sales of the month",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.w400),
                ),
              ),
              BlocProvider(
                  create: (_) => ReceiptDetailBloc(apiProvider: apiProvider)
                    ..add(GetAllEvent()),
                  child: const SalesChart()),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesChart extends StatefulWidget {
  const SalesChart({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesChart> createState() => _SalesChartState();
}

class _SalesChartState extends State<SalesChart> {
  List<LineData> chartData = [];
  final TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptDetailBloc, ReceiptDetailState>(
        listener: (context, state) {
      if (state is Loaded) {
        chartData = state.chartData;
      }
    }, builder: (context, state) {
      if (state is Initial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is Loaded) {
        return Expanded(
          child: SfCartesianChart(
              legend: Legend(isVisible: false),
              tooltipBehavior: _tooltipBehavior,
              primaryXAxis: CategoryAxis(),
              series: <BarSeries<LineData, String>>[
                BarSeries<LineData, String>(
                    dataSource: chartData,
                    xValueMapper: (LineData data, _) => data.xData!.replaceRange(10, data.xData!.length, '...'),
                    yValueMapper: (LineData data, _) => data.yData,
                    dataLabelMapper: (LineData data, _) => data.yData.toString(),
                    dataLabelSettings: const DataLabelSettings(isVisible: true)),
              ]),
        );
      } else {
        return Container();
      }
    });
  }
}

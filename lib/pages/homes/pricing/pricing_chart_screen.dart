import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widgets/images.dart';


class PricingChartScreen extends StatefulWidget {
  PricingChartScreen({Key? key}) : super(key: key);

  @override
  _PricingChartScreenState createState() => _PricingChartScreenState();
}

class _PricingChartScreenState extends State<PricingChartScreen> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(height: 320, child: _buildDefaultRangeColumnChart()),
    );
  }

  SfCartesianChart _buildDefaultRangeColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text: 'Price range of Soya Beans in 6 selected districts is averagely 600 - 1500UGX per KG as displayed in graph below.',
          textStyle: FxTextStyle.caption()),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          interval: 5,
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 8, color: Colors.transparent)),
      series: _getDefaultRangeColumnSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<RangeColumnSeries<ChartSampleData, String>>
  _getDefaultRangeColumnSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jinja', y: 1000, yValue: 1300),
      ChartSampleData(x: 'Busia', y: 1200, yValue: 1500),
      ChartSampleData(x: 'Kasese', y: 800, yValue: 1300),
      ChartSampleData(x: 'Mbale', y: 700, yValue: 1000),
      ChartSampleData(x: 'Gulu', y: 900, yValue: 1500),
      ChartSampleData(x: 'Arua', y: 600, yValue: 1200),
    ];
    return <RangeColumnSeries<ChartSampleData, String>>[
      RangeColumnSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        lowValueMapper: (ChartSampleData sales, _) => sales.y,
        highValueMapper: (ChartSampleData sales, _) => sales.yValue,
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }
}

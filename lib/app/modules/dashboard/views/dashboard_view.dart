import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../routes/app_pages.dart';
import '../../../style/app_color.dart';
import '../../../widgets/custom_appbar.dart';
import '../controllers/Dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40)
    ];

    final List<ChartData> chartData = [
      ChartData('USA', 10, '50%'),
      ChartData('China', 11, '50%'),
      ChartData('Russia', 9, '50%'),
      ChartData('Germany', 10, '50%')
    ];

    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };
    DashboardController _dashboardController = DashboardController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: AppColor.secondary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColor.blackColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColor.secondaryExtraSoft,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: CustomeAppbar(
        title: 'Employee Management',
        backButton: true,
        backRout: () => Get.toNamed(Routes.HOME),
        mainWidget: (

            // customChart2(data: data),
            //customChart(chartData: chartData),
            //Padding(
            // padding: const EdgeInsets.all(8.0),
            //child: customChart(chartData: chartData),
            //),

            Stack(
          children: [
            Positioned(
              top: 0,
              left: 50,
              height: 200,
              width: 400,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    Text(
                      "Total Requests",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class customChart2 extends StatelessWidget {
  const customChart2({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<_SalesData> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
        //  width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Half yearly sales analysis'),
          // Enable legend
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<_SalesData, String>>[
            LineSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ],
        ),
      ),
    );
  }
}

class customChart extends StatelessWidget {
  const customChart({
    Key? key,
    required this.chartData,
  }) : super(key: key);

  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
      //  width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SizedBox(
        height: 250,
        width: 250,
        child: SfCircularChart(
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                // Radius for each segment from data source
                pointRadiusMapper: (ChartData data, _) => data.size)
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, this.size);
  final String x;
  final double y;
  final String size;
}




// SizedBox(
//         child: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Container(
//             padding: EdgeInsets.fromLTRB(15, 24, 24, 16),
//             //  width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//             ),

//             child: PieChart(
//               PieChartData(
//                 centerSpaceRadius: 5,
//                 borderData: FlBorderData(show: false),
//                 sectionsSpace: 2,
//                 sections: [
//                   PieChartSectionData(
//                       value: 35, color: Colors.purple, radius: 100),
//                   PieChartSectionData(
//                       value: 40, color: Colors.amber, radius: 100),
//                   PieChartSectionData(
//                       value: 55, color: Colors.green, radius: 100),
//                   PieChartSectionData(
//                       value: 70, color: Colors.orange, radius: 100),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),

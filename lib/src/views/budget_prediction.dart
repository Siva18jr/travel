import 'dart:math';

import 'package:flutter/material.dart';
import 'package:levitate/src/model/provider_state/budget_prediction_provider.dart';
import 'package:levitate/src/res/components/widgets/custom_widgets.dart';
import 'package:levitate/src/utils/utils.dart';
import 'package:provider/provider.dart';

class BudgetPrediction extends StatefulWidget {

  final String distance;
  final String hotelCount;
  final String hotel;

  const BudgetPrediction({super.key, required this.distance, required this.hotelCount, required this.hotel});

  @override
  State<BudgetPrediction> createState() => _BudgetPredictionState();
}

class _BudgetPredictionState extends State<BudgetPrediction> {

  final CustomWidgets _widgets = CustomWidgets();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = Utils.getActivityScreenWidth(context);
    int min = 800, max = 1200;
    int randomNumber = int.parse((min + Random().nextInt(max - min)).toString());

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<BudgetPredictionProvider>(
        builder: (context, value, _){

          value.setDistanceAmount(double.parse(widget.distance).toStringAsFixed(2));
          value.setTotalBudget(double.parse(widget.hotel), double.parse(randomNumber.toString()));

          return Column(
              children: [
                _widgets.budgetTotalCountTile(
                    title: 'Distance',
                    count: value.distanceAmount.toStringAsFixed(2),
                    screenWidth: screenWidth
                ),
                _widgets.budgetTotalCountTile(
                    title: 'Hotel',
                    count: '${widget.hotelCount} X ${widget.hotel}',
                    screenWidth: screenWidth
                ),
                _widgets.budgetTotalCountTile(
                    title: 'Others',
                    count: randomNumber.toString(),
                    screenWidth: screenWidth
                ),
                _widgets.budgetTotalCountTile(
                    title: 'Total',
                    count: double.parse(value.totalBudget.toString()).toStringAsFixed(2),
                    screenWidth: screenWidth
                )
              ]
          );

        }
      )
    );

  }

}
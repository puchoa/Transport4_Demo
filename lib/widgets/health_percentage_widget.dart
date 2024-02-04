import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:transport4_demo_app/models/recipe_model.dart';

class HealthPercentage extends StatefulWidget {
  final List<Digest> digest;
  const HealthPercentage({super.key, required this.digest});

  @override
  State<HealthPercentage> createState() => _HealthPercentageState();
}

class _HealthPercentageState extends State<HealthPercentage> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            digestBox(context, index: 0, backgroundColor: Colors.blue.shade300),
            const SizedBox(
              width: 10,
            ),
            digestBox(context,
                index: 1, backgroundColor: Colors.green.shade300),
            const SizedBox(
              width: 10,
            ),
            digestBox(context, index: 2, backgroundColor: Colors.red.shade300),
          ],
        ),
      ),
    );
  }

  Container digestBox(BuildContext context,
      {required int index, required Color backgroundColor}) {
    bool indexCheck = widget.digest.isEmpty;
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 150,
      decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              indexCheck
                  ? index == 0
                      ? Label.FAT.name
                      : index == 1
                          ? Label.CARBS.name
                          : Label.PROTEIN.name
                  : widget.digest[index].label.name,
              style: TextStyle(
                  color: Colors.grey.shade700, fontWeight: FontWeight.w400),
            ),
            Text(
              indexCheck
                  ? "0g"
                  : "${widget.digest[index].total.ceil().toString()}g",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 5.0,
                percent: indexCheck
                    ? 0
                    : widget.digest[index].total.ceil() * 0.01 > 1
                        ? 1
                        : widget.digest[index].total.ceil() * 0.01,
                center: Text(
                  indexCheck
                      ? "0%"
                      : "${widget.digest[index].total.ceil().toString()}%",
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                progressColor: backgroundColor),
          ],
        ),
      ),
    );
  }
}

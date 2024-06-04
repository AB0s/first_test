import 'package:flutter/material.dart';

class StressLevelSlider extends StatelessWidget {
  final double stressLevel;
  final ValueChanged<double> onChanged;
  final Size size;

  const StressLevelSlider({
    required this.stressLevel,
    required this.onChanged,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Уровень стресса',
            style: TextStyle(fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
          ),
          Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            child: Column(
              children: [
                Slider(
                  value: stressLevel,
                  onChanged: onChanged,
                  min: 0,
                  max: 1,
                  divisions: 10,
                  label: '${(stressLevel * 10).round()}',
                  activeColor: Color(0xFFFF8702),
                  inactiveColor: Colors.grey[300],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Низкий', style: TextStyle(fontSize: size.width * 0.035)),
                    Text('Высокий', style: TextStyle(fontSize: size.width * 0.035)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

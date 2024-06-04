import 'package:flutter/material.dart';

class AdditionalContent extends StatelessWidget {
  final String emotion;
  final Set<String> selectedItems;
  final void Function(String) toggleSelection;
  final Size size;

  const AdditionalContent({
    required this.emotion,
    required this.selectedItems,
    required this.toggleSelection,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    List<String> additionalItems = [];

    switch (emotion) {
      case 'Радость':
        additionalItems = [
          'Возбуждение',
          'Восторг',
          'Игривость',
          'Наслаждение',
          'Очарование',
          'Осознанность',
          'Смелость',
          'Удовольствие',
          'Чувственность',
          'Энергичность',
          'Экстравагантность'
        ];
        break;
      case 'Страх':
        additionalItems = ['Тревога', 'Нервозность', 'Ужас', 'Опасение'];
        break;
      case 'Бешенство':
        additionalItems = ['Гнев', 'Раздражение', 'Злоба'];
        break;
      case 'Грусть':
        additionalItems = ['Тоска', 'Одиночество', 'Печаль', 'Горе'];
        break;
      case 'Спокойствие':
        additionalItems = ['Умиротворение', 'Расслабленность', 'Согласие'];
        break;
      case 'Сила':
        additionalItems = ['Мощь', 'Власть', 'Дерзость'];
        break;
    }

    return Padding(
      padding: EdgeInsets.all(size.width * 0.04),
      child: Wrap(
        spacing: size.width * 0.02,
        runSpacing: size.width * 0.02,
        children: additionalItems.map((item) {
          bool isSelected = selectedItems.contains(item);
          return GestureDetector(
            onTap: () => toggleSelection(item),
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 3, // Blur radius
                    offset: Offset(0, 3), // Shadow offset
                  ),
                ],
              ),
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: Colors.transparent, // Makes the border invisible
                  ),
                ),
                label: Text(item),
                backgroundColor: isSelected ? Color(0xFFFF8702) : Colors.white,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

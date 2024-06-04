import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/emotion_tab.dart';
import 'widgets/additional_content.dart';
import 'widgets/stress_level_slider.dart';
import 'widgets/self_esteem_slider.dart';
import 'widgets/notes_field.dart';
import 'monthly_calendar.dart';

class TabBarExample extends StatefulWidget {
  @override
  _TabBarExampleState createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? selectedEmotion;
  Set<String> selectedItems = {};
  double stressLevel = 0.5; // Initial value for the stress level slider
  double selfEsteemLevel = 0.5; // Initial value for the self-esteem slider
  TextEditingController notesController = TextEditingController(); // Controller for the notes text field

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void selectEmotion(String emotion) {
    setState(() {
      if (selectedEmotion == emotion) {
        selectedEmotion = null;
        selectedItems.clear();
      } else {
        selectedEmotion = emotion;
        selectedItems.clear();
      }
    });
  }

  void toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  bool isFormComplete() {
    return selectedEmotion != null &&
        selectedItems.isNotEmpty &&
        notesController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.03; // Dynamic padding based on screen width

    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('d MMMM HH:mm', 'ru').format(DateTime.now())),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MonthlyCalendar()),
              );
            },
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Color(0xFFFF8702),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    labelPadding: EdgeInsets.symmetric(horizontal: padding),
                    isScrollable: false,
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Дневник настроения',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bar_chart, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Статистика',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height * 0.2,
                        margin: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
                        child: ListView(
                          padding: EdgeInsets.symmetric(vertical: padding / 2),
                          scrollDirection: Axis.horizontal,
                          children: [
                            EmotionTab(
                              assetPath: 'assets/happiness.png',
                              label: 'Радость',
                              isSelected: selectedEmotion == 'Радость',
                              onTap: () => selectEmotion('Радость'),
                              size: size,
                            ),
                            EmotionTab(
                              assetPath: 'assets/fear.png',
                              label: 'Страх',
                              isSelected: selectedEmotion == 'Страх',
                              onTap: () => selectEmotion('Страх'),
                              size: size,
                            ),
                            EmotionTab(
                              assetPath: 'assets/anger.png',
                              label: 'Бешенство',
                              isSelected: selectedEmotion == 'Бешенство',
                              onTap: () => selectEmotion('Бешенство'),
                              size: size,
                            ),
                            EmotionTab(
                              assetPath: 'assets/sadness.png',
                              label: 'Грусть',
                              isSelected: selectedEmotion == 'Грусть',
                              onTap: () => selectEmotion('Грусть'),
                              size: size,
                            ),
                            EmotionTab(
                              assetPath: 'assets/calm.png',
                              label: 'Спокойствие',
                              isSelected: selectedEmotion == 'Спокойствие',
                              onTap: () => selectEmotion('Спокойствие'),
                              size: size,
                            ),
                            EmotionTab(
                              assetPath: 'assets/strength.png',
                              label: 'Сила',
                              isSelected: selectedEmotion == 'Сила',
                              onTap: () => selectEmotion('Сила'),
                              size: size,
                            ),
                          ],
                        ),
                      ),
                      if (selectedEmotion != null)
                        AdditionalContent(
                          emotion: selectedEmotion!,
                          selectedItems: selectedItems,
                          toggleSelection: toggleSelection,
                          size: size,
                        ),
                      StressLevelSlider(
                        stressLevel: stressLevel,
                        onChanged: (value) {
                          setState(() {
                            stressLevel = value;
                          });
                        },
                        size: size,
                      ),
                      SelfEsteemSlider(
                        selfEsteemLevel: selfEsteemLevel,
                        onChanged: (value) {
                          setState(() {
                            selfEsteemLevel = value;
                          });
                        },
                        size: size,
                      ),
                      NotesField(
                        controller: notesController,
                        onChanged: (text) {
                          setState(() {
                            // Update the button state when the text changes
                          });
                        },
                        size: size,
                      ),
                      // Add more content if needed
                    ],
                  ),
                ),
                Center(child: Text('Статистика Content')),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(padding),
        child: ElevatedButton(
          onPressed: isFormComplete() ? _saveForm : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isFormComplete() ? Color(0xFFFF8702) : Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: padding / 2),
          ),
          child: Text(
            'Сохранить',
            style: TextStyle(
              color: isFormComplete() ? Colors.white : Colors.grey,
              fontSize: size.width * 0.04,
            ),
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    // Show snackbar on successful form save
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text('Форма успешно сохранена'),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.2
        ),
      ),
    );
  }
}

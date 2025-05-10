
import 'package:baixinglive/api/baixing_api_thirdapi.dart';

import '../api/baixing_api_flutter.dart';

class Baixing_SelectBirthdayDialog extends StatefulWidget {

  Baixing_SelectBirthdayDialog({super.key});

  @override
  State<Baixing_SelectBirthdayDialog> createState() =>
      _Baixing_SelectBirthdayDialogState();
}

class _Baixing_SelectBirthdayDialogState
    extends State<Baixing_SelectBirthdayDialog> {
  late DateTime _selectedDate;
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;

  // 年份范围
  final int _startYear = 1900;
  final int _endYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();

    // 初始化控制器
    _yearController = FixedExtentScrollController(
      initialItem: _selectedDate.year - _startYear,
    );
    _monthController = FixedExtentScrollController(
      initialItem: _selectedDate.month - 1,
    );
    _dayController = FixedExtentScrollController(
      initialItem: _selectedDate.day - 1,
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('选择生日', style: textTheme.titleMedium),
          actions: [
            CupertinoButton(
              child: const Text('完成'),
              onPressed: () => Navigator.pop(context, _selectedDate),
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              // 年份选择器
              Expanded(
                child: CupertinoPicker.builder(
                  scrollController: _yearController,
                  itemExtent: 35.h,
                  backgroundColor: CupertinoColors.systemBackground,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      final year = _startYear + index;
                      _selectedDate = DateTime(
                        year,
                        _selectedDate.month,
                        _selectedDate.day.clamp(
                          1,
                          _getDaysInMonth(year, _selectedDate.month),
                        ),
                      );
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index < 0 || index >= (_endYear - _startYear + 1)) {
                      return null;
                    }
                    final year = _startYear + index;
                    return Center(child: Text('$year年'));
                  },
                ),
              ),
              // 月份选择器
              Expanded(
                child: CupertinoPicker.builder(
                  scrollController: _monthController,
                  itemExtent: 35.h,
                  backgroundColor: CupertinoColors.systemBackground,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      final month = index + 1;
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        month,
                        _selectedDate.day.clamp(
                          1,
                          _getDaysInMonth(_selectedDate.year, month),
                        ),
                      );
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index < 0 || index >= 12) {
                      return null;
                    }
                    final month = index + 1;
                    return Center(child: Text('$month月'));
                  },
                ),
              ),
              // 日期选择器
              Expanded(
                child: CupertinoPicker.builder(
                  scrollController: _dayController,
                  itemExtent: 35.h,
                  backgroundColor: CupertinoColors.systemBackground,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      final day = index + 1;
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        day,
                      );
                    });
                  },
                  itemBuilder: (context, index) {
                    final daysInMonth = _getDaysInMonth(
                      _selectedDate.year,
                      _selectedDate.month,
                    );
                    if (index < 0 || index >= daysInMonth) {
                      return null;
                    }
                    final day = index + 1;
                    return Center(child: Text('$day日'));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 计算指定年月的天数
  int _getDaysInMonth(int year, int month) {
    if (month == 2) {
      // 闰年2月有29天，平年2月有28天
      return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) ? 29 : 28;
    }
    // 4, 6, 9, 11月有30天，其他月份有31天
    return [4, 6, 9, 11].contains(month) ? 30 : 31;
  }
}

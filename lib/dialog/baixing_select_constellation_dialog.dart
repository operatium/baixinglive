import 'package:baixinglive/api/baixing_api_thirdapi.dart';

import '../api/baixing_api_flutter.dart';

class Baixing_SelectConstellationDialog extends StatefulWidget {
  final ValueChanged<int>? onSelected;
  final int initialIndex;

  const Baixing_SelectConstellationDialog({
    Key? key,
    this.onSelected,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<Baixing_SelectConstellationDialog> createState() =>
      _Baixing_SelectConstellationDialogState();
}

class _Baixing_SelectConstellationDialogState
    extends State<Baixing_SelectConstellationDialog> {
  late FixedExtentScrollController _scrollController;
  int _selectedIndex = 0;

  static const double itemHeight = 100.0;
  static const double itemExtent = 120.0;

  final List<Map<String, dynamic>> constellations = [
    {'name': '白羊座', 'icon': Icons.star, 'start': '3/21', 'end': '4/19'},
    {'name': '金牛座', 'icon': Icons.star, 'start': '4/20', 'end': '5/20'},
    {'name': '双子座', 'icon': Icons.star, 'start': '5/21', 'end': '6/21'},
    {'name': '巨蟹座', 'icon': Icons.star, 'start': '6/22', 'end': '7/22'},
    {'name': '狮子座', 'icon': Icons.star, 'start': '7/23', 'end': '8/22'},
    {'name': '处女座', 'icon': Icons.star, 'start': '8/23', 'end': '9/22'},
    {'name': '天秤座', 'icon': Icons.star, 'start': '9/23', 'end': '10/23'},
    {'name': '天蝎座', 'icon': Icons.star, 'start': '10/24', 'end': '11/22'},
    {'name': '射手座', 'icon': Icons.star, 'start': '11/23', 'end': '12/21'},
    {'name': '摩羯座', 'icon': Icons.star, 'start': '12/22', 'end': '1/19'},
    {'name': '水瓶座', 'icon': Icons.star, 'start': '1/20', 'end': '2/18'},
    {'name': '双鱼座', 'icon': Icons.star, 'start': '2/19', 'end': '3/20'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(4, constellations.length - 1);
    _scrollController = FixedExtentScrollController(
      initialItem: _selectedIndex,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Color accentColor = Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text('选择星座', style: textTheme.titleMedium),
        leading: null,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('完成', style: textTheme.bodyMedium),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: CupertinoPicker(
          itemExtent: 65.h,
          diameterRatio: 1.05,
          backgroundColor: Colors.transparent,
          scrollController: FixedExtentScrollController(
            initialItem: _selectedIndex,
          ),
          onSelectedItemChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
            widget.onSelected?.call(index);
          },
          children:
              constellations.map((item) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(item['icon'], size: 28.w),
                      SizedBox(height: 4.h),
                      Text(
                        item['name'],
                        style: textTheme.bodyMedium,
                      ),
                      Text(
                        "${item['start']} - ${item['end']}",
                        style: textTheme.labelMedium,
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}

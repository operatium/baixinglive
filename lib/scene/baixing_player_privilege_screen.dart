import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';

import '../api/baixing_api_flutter.dart';

class Baixing_PlayerPrivilegeScreen extends StatefulWidget {
  const Baixing_PlayerPrivilegeScreen({Key? key}) : super(key: key);

  @override
  State<Baixing_PlayerPrivilegeScreen> createState() =>
      _Baixing_PlayerPrivilegeScreenState();
}

class _Baixing_PlayerPrivilegeScreenState
    extends State<Baixing_PlayerPrivilegeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "玩家特权",
          style: textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 按钮切换组
           ClipRRect(
             borderRadius: BorderRadius.circular(100.r),
             child:  Container(
               height: 30.h,
               color: Color(0xFF333333),
                 child: ToggleButtons(
                   isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                   onPressed: (int index) {
                     setState(() {
                       _selectedIndex = index;
                       _pageController.animateToPage(
                         index,
                         duration: Baixing_dd300ms,
                         curve: Curves.easeInOut,
                       );
                     });
                   },
                   color: Colors.white,
                   selectedColor: Colors.black,
                   fillColor: Color(0xFFFFD97A),
                   borderRadius: BorderRadius.circular(100.r),
                   children: [
                     Container(
                       padding: EdgeInsets.symmetric(
                         horizontal: 16.w,
                       ),
                       child: Text('充值'),
                     ),
                     Padding(
                       padding: EdgeInsets.symmetric(
                         horizontal: 16.w,
                       ),
                       child: Text('消费'),
                     ),
                   ],
               ),
             ),
           ),

            // ViewPager2
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  // 充值页面内容
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        '充值页面内容',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  // 消费页面内容
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: Text(
                        '消费页面内容',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

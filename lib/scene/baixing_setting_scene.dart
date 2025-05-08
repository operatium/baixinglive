import 'package:baixinglive/api/baixing_api.dart';

import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';
import '../api/baixing_api_time.dart';
import '../compat/baixing_toast.dart';

class Baixing_SettingScene extends StatefulWidget {
  Baixing_SettingScene({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Baixing_SettingSceneState();
  }
}

class _Baixing_SettingSceneState extends State<Baixing_SettingScene> {
  final _baixing_debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('账号设置'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 5.h),
            _baixing_addClick(
              '账号与安全',
              _buildSettingItem(
                '账号与安全',
                'images/baixing_99.webp', // 请根据实际情况修改图片路径
              ),
            ),
            SizedBox(height: 5.h),
            _baixing_addClick(
              '通知设置',
              _buildSettingItem(
                '通知设置',
                'images/baixing_99.webp', // 请根据实际情况修改图片路径
              ),
            ),
            SizedBox(height: 1.h),
            _baixing_addClick(
              '隐私设置',
              _buildSettingItem(
                '隐私设置',
                'images/baixing_99.webp', // 请根据实际情况修改图片路径
              ),
            ),
            SizedBox(height: 1.h),
            _baixing_addClick(
              '直播间偏好设置',
              _buildSettingItem(
                '直播间偏好设置',
                'images/baixing_99.webp', // 请根据实际情况修改图片路径
              ),
            ),
            SizedBox(height: 10),
            _baixing_addClick("青少年模式", _buildYouthModeItem()),
            SizedBox(height: 1.h),
            _baixing_addClick("清除缓存", _buildClearCacheItem()),
            SizedBox(height: 10),
            _baixing_addClick(
              '个人信息收集清单',
              _buildSettingItem(
                '个人信息收集清单',
                'images/baixing_99.webp', // 请根据实际情况修改图片路径
              ),
            ),
            SizedBox(height: 1.h),
            _baixing_addClick(
              '第三方信息共享清单',
              _buildSettingItem(
                '第三方信息共享清单',
                'images/baixing_99.webp', // 请根据实际情况修改图片路径
              ),
            ),
            SizedBox(height: 1.h),
            _baixing_addClick("关于", _buildAboutItem()),
          ],
        ),
      ),
    );
  }

  Widget _baixing_addClick(String event, Widget child) {
    return GestureDetector(onTap: _obtainClickListener(event), child: child);
  }

  Widget _buildSettingItem(String title, String arrowAsset) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ),
          SizedBox(width: 8.w),
          Image.asset(arrowAsset, width: 20.w, height: 20.w),
        ],
      ),
    );
  }

  Widget _buildYouthModeItem() {
    Baixing_TeenagerModeModel teenagerModeModel = context.watch();
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text('青少年模式', style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            teenagerModeModel.baixing_enable ? '开启' : '未开启',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(width: 12.w),
          Image.asset(
            'images/baixing_99.webp', // 请根据实际情况修改图片路径
            width: 20.w,
            height: 20.w,
          ),
        ],
      ),
    );
  }

  Widget _buildClearCacheItem() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text('清除缓存', style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text('3.93M', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(width: 12.w),
          Image.asset(
            'images/baixing_99.webp', // 请根据实际情况修改图片路径
            width: 20.w,
            height: 20.w,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutItem() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text('关于', style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text('版本:9.39.0', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(width: 12.w),
          Image.asset(
            'images/baixing_99.webp', // 请根据实际情况修改图片路径
            width: 20.w,
            height: 20.w,
          ),
        ],
      ),
    );
  }

  VoidCallback _obtainClickListener(String event) {
    ontap() {
      switch (event) {
        case "账号与安全":
          GoRouter.of(context).push("/account");
          break;
        case "通知设置":
          GoRouter.of(context).push("/notification");
          break;
        case "隐私设置":
          GoRouter.of(context).push("/privacy");
          break;
        case "直播间偏好设置":
          GoRouter.of(context).push("/room_preference");
          break;
        case "个人信息收集清单":
          GoRouter.of(context).push("/personal_info");
          break;
        case "第三方信息共享清单":
          GoRouter.of(context).push("/third_party_info");
          break;
        case "关于":
          GoRouter.of(context).push("/about");
          break;
        case "青少年模式":
          GoRouter.of(context).push("/teenager");
          break;
        case "清除缓存":
          GoRouter.of(context).push("/clear_cache");
          break;
        default:
          Baixing_Toast.show(event);
          break;
      }
    }

    return () {
      _baixing_debouncer.debounce(
        duration: Baixing_dd500ms,
        onDebounce: () {
          ontap.call();
        },
      );
    };
  }
}

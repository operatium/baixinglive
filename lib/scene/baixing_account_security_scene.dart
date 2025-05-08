import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';

/**
 * @author yuyuexing
 * @date: 2025-05-08
 * @description: 账号与安全界面
 */

class Baixing_AccountSecurityScene extends StatefulWidget {
  const Baixing_AccountSecurityScene({super.key});

  @override
  State<Baixing_AccountSecurityScene> createState() => _Baixing_AccountSecuritySceneState();
}

class _Baixing_AccountSecuritySceneState extends State<Baixing_AccountSecurityScene> {
  // 模拟数据
  final String _mBaixing_userId = "31365117";
  final String _mBaixing_phoneNumber = "18888702717";
  final String _mBaixing_gameName = "未实名";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("账号与安全"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          // 安全状态卡片
          Container(
            width: double.infinity,
            height: 120.h,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 安全图标
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset("images/baixing_safe.webp"),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "暂未发现安全隐患",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          ),
          SizedBox(height: 20),
          // 账号信息列表
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildInfoItem("ID", _mBaixing_userId),
                Divider(height: 1, indent: 16, endIndent: 16),
                _buildInfoItem("手机号", _mBaixing_phoneNumber),
                Divider(height: 1, indent: 16, endIndent: 16),
                _buildInfoItem("游戏实名", _mBaixing_gameName, textColor: Colors.red),
              ],
            ),
          ),
          SizedBox(height: 20),
          // 账号操作列表
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildActionItem("切换账号", onTap: () {
                  // 切换账号逻辑
                }),
                Divider(height: 1, indent: 16, endIndent: 16),
                _buildActionItem("注销账号", onTap: () {
                  // 注销账号逻辑
                }),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 35.h,
            child: GestureDetector(
              onTap: () {
                Baixing_AccountModel accountModel = context.read();
                accountModel.baixing_current_account = null;
                GoRouter.of(context).go('/selectLogin');
              },
              child: Center(
                child: Text(
                  "退出登录",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建信息项
  Widget _buildInfoItem(String title, String value, {Color? textColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: textColor ?? Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // 构建操作项
  Widget _buildActionItem(String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
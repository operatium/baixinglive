import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';
import '../api/baixing_api_thirdapi.dart';

/**
 * @author yuyuexing
 * @date: 2025-05-08
 * @description: 账号切换界面
 */

class Baixing_AccountSwitchScene extends StatefulWidget {
  const Baixing_AccountSwitchScene({super.key});

  @override
  State<Baixing_AccountSwitchScene> createState() =>
      _Baixing_AccountSwitchSceneState();
}

class _Baixing_AccountSwitchSceneState
    extends State<Baixing_AccountSwitchScene> {
  bool _mBaixing_delete = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Baixing_AccountModel accountModel = context.watch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("账号切换"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _mBaixing_delete = !_mBaixing_delete;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Text(
                _mBaixing_delete ? "删除" : "切换",
                style: textTheme.titleMedium!.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.separated(
          itemCount: max(accountModel.baixing_getAllAccounts().length + 1, 1),
          itemBuilder: (context, index) {
            Widget view;
            if (index >= accountModel.baixing_getAllAccounts().length) {
              view = _baixing_loginItem(context);
            } else {
              view = _baixing_accountItem(
                context,
                accountModel.baixing_getAllAccounts()[index],
              );
            }
            return SizedBox(
              height: 60.h,
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Center(child: view),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 10.h, color: Colors.transparent);
          },
        ),
      ),
    );
  }

  Widget _baixing_accountItem(
    BuildContext context,
    Baixing_AccountEntity entity,
  ) {
    final textTheme = Theme.of(context).textTheme;
    Baixing_AccountModel accountModel = context.watch();
    return ListTile(
      title: Text(entity.mBaixing_nickName, style: textTheme.labelMedium),
      subtitle: Text(entity.phone, style: textTheme.labelSmall),
      leading: SizedBox(
        width: 40.w,
        height: 40.w,
        child: ClipOval(
          child: Baixing_CoverWidget(mBaixing_url: entity.mBaixing_avatarUrl),
        ),
      ),
      trailing:
          accountModel.baixing_current_account!.mBaixing_id ==
                  entity.mBaixing_id
              ? null
              : Container(
                decoration:
                    _mBaixing_delete
                        ? Baixing_BackGround.baixing_getRoundedRectangular_C001()
                        : Baixing_BackGround.baixing_getRoundedRectangular_K002(),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                child: Text(
                  _mBaixing_delete ? "删除账号" : "切换账号",
                  style: textTheme.labelMedium!.copyWith(color: Colors.white),
                ),
              ),
      onTap: () async {
        final bool isContinue = await baixing_isContinueDialog(
          context,
          _mBaixing_delete ? "删除账号" : "切换账号",
          "确认",
          "取消",
        );
        if (isContinue) {
          _mBaixing_delete
              ? accountModel.baixing_removeHistoryAccount(entity.mBaixing_id)
              : accountModel.baixing_setCurrentAccount(entity);
        }
      },
    );
  }

  Widget _baixing_loginItem(BuildContext context) {
    return ListTile(
      title: Text("登录新账号"),
      leading: Icon(Icons.add_circle_outline),
      onTap: () {
        baixing_showLoginDialog(context);
      },
    );
  }
}

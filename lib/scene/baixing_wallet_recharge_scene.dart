import '../api/baixing_api.dart';
import '../api/baixing_api_flutter.dart';

/**
 * @author yuyuexing
 * @date: 2025.05.11
 * @description: 钱包充值页面
 */
class Baixing_WalletRechargeScene extends StatefulWidget {
  const Baixing_WalletRechargeScene({super.key});

  @override
  State<StatefulWidget> createState() => _Baixing_WalletRechargeSceneState();
}

class _Baixing_WalletRechargeSceneState
    extends State<Baixing_WalletRechargeScene> {
  final _baixing_debouncer = Debouncer();
  bool _mBaixing_agreementChecked = true;
  int _mBaixing_selectedOption = 1000;
  int _mBaixing_selectedPrice = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // 添加 SingleChildScrollView
          child: Container(
            decoration: Baixing_BackGround.baixing_getRectangularGradient(
              (0xff7B61FF),
              (0xffffffff),
            ),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      AppBar(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: const Text('我的钱包'),
                        actions: [
                          TextButton(
                            onPressed: _baixing_onViewTransactionHistory,
                            child: const Text(
                              '收支明细',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      _baixing_buildBalanceSection(),
                    ],
                  ),
                ),
                Container(
                  decoration: Baixing_BackGround.baixing_getRoundedRectangular(
                    radius: 16.r,
                  ),
                  child: Column(
                    children: [
                      _baixing_buildRechargeOptionsSection(),
                      Center(child: _baixing_buildAgreementSection()),
                      GestureDetector(
                        onTap: () {
                          _baixing_pay();
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          decoration: Baixing_BackGround.baixing_getRoundedRectangular_K002(radius: 30.r),
                          child: Text(
                            '确认充值',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h),
                      _baixing_buildWarningText(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 余额显示区域
  Widget _baixing_buildBalanceSection() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.opacity_rounded,
                color: Colors.orangeAccent,
                size: 24.w,
              ),
              SizedBox(width: 5.w),
              Text(
                '余额(柠檬)',
                style: textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            '1,200',
            style: textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontSize: 36.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '收益',
                style: textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
              SizedBox(width: 5.w),
              Text(
                '550',
                style: textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 充值选项区域
  Widget _baixing_buildRechargeOptionsSection() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: Baixing_BackGround.baixing_getRoundedRectangular(
        radius: 16.r,
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('充值金额', style: textTheme.bodyLarge),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            children: [
              _baixing_buildRechargeOption(1000, 10),
              _baixing_buildRechargeOption(5000, 50),
              _baixing_buildRechargeOption(10000, 100),
              _baixing_buildRechargeOption(50000, 500),
              _baixing_buildRechargeOption(100000, 1000),
              _baixing_buildRechargeOption(500000, 5000),
              _baixing_buildRechargeOption(1000000, 10000),
              _baixing_buildRechargeOption(5000000, 50000),
              _baixing_buildRechargeOption(10000000, 100000),
            ],
          ),
        ],
      ),
    );
  }

  // 单个充值选项
  Widget _baixing_buildRechargeOption(int lemonAmount, int price) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        setState(() {
          _mBaixing_selectedOption = lemonAmount;
          _mBaixing_selectedPrice = price;
        });
      },
      child: Container(
        decoration:
            (_mBaixing_selectedOption == lemonAmount)
                ? Baixing_BackGround.baixing_getRoundedRectangular_C001(
                  radius: 6.r,
                  borderColor: Color(0xFF7B61FF),
                  backgroundColor: Color(0xFFEEEEEE),
                )
                : Baixing_BackGround.baixing_getRoundedRectangular(
                  radius: 6.r,
                  color: Color(0xFFEEEEEE),
                ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$lemonAmount',
              style: textTheme.labelMedium!.copyWith(color: Colors.black),
            ),
            SizedBox(height: 2.h),
            Text(
              '柠檬',
              style: textTheme.labelSmall!.copyWith(color: Colors.black),
            ),
            SizedBox(height: 2.h),
            Text(
              '$price元',
              style: textTheme.bodyMedium!.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // 协议同意区域
  Widget _baixing_buildAgreementSection() {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            child: Checkbox(
              value: _mBaixing_agreementChecked,
              onChanged: (value) {
                setState(() {
                  _mBaixing_agreementChecked = !_mBaixing_agreementChecked;
                });
              },
            ),
          ),
          SizedBox(width: 8.w),
          Text('我已阅读并同意', style: textTheme.labelMedium),
          GestureDetector(
            onTap: () {
              baixing_showUrlDialog(context, "https://www.163.com");
            },
            child: Text(
              '《用户充值协议》',
              style: textTheme.labelMedium!.copyWith(color: Color(0xff7B61FF)),
            ),
          ),
        ],
      ),
    );
  }

  // 警告文本
  Widget _baixing_buildWarningText() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Text(
        '禁止未成年人充值消费',
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.center,
      ),
    );
  }

  // 查看交易历史
  void _baixing_onViewTransactionHistory() {
    Baixing_Toast.show('查看收支明细');
  }

  // 选择充值选项
  void _baixing_pay() {
    if (!_mBaixing_agreementChecked) {
      Baixing_Toast.show('请先同意用户充值协议');
      return;
    }

    // 显示充值确认对话框
    baixing_showRechargeConfirmDialog(
      context: context,
      amount: _mBaixing_selectedPrice,
      lemonAmount: _mBaixing_selectedOption,
      onConfirm: (paymentMethod) {
        Baixing_Toast.show('使用$paymentMethod支付了$_mBaixing_selectedPrice元');
      },
    );
  }
}

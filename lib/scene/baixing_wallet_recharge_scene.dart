import 'package:flutter/material.dart';
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

class _Baixing_WalletRechargeSceneState extends State<Baixing_WalletRechargeScene> {
  final _baixing_debouncer = Debouncer();
  bool _mBaixing_agreementChecked = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple.shade800,
                Colors.purple.shade500,
              ],
            ),
          ),
        ),
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
      body: Column(
        children: [
          _baixing_buildBalanceSection(),
          _baixing_buildRechargeOptionsSection(),
          const Spacer(),
          _baixing_buildAgreementSection(),
          _baixing_buildWarningText(),
        ],
      ),
    );
  }

  // 余额显示区域
  Widget _baixing_buildBalanceSection() {
    return Container(
      width: double.infinity,
      color: Colors.purple,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Column(
        children: [
          Text(
            '余额(柠檬)',
            style: TextStyle(
              color: Colors.yellow[100],
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            '1,200',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '收益',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                '¥0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 充值选项区域
  Widget _baixing_buildRechargeOptionsSection() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '充值金额',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            children: [
              _baixing_buildRechargeOption('1,000柠檬', '10元'),
              _baixing_buildRechargeOption('5,000柠檬', '50元'),
              _baixing_buildRechargeOption('10,000柠檬', '100元'),
              _baixing_buildRechargeOption('50,000柠檬', '500元'),
              _baixing_buildRechargeOption('100,000柠檬', '1000元'),
              _baixing_buildRechargeOption('其他金额', '最低10元'),
            ],
          ),
        ],
      ),
    );
  }

  // 单个充值选项
  Widget _baixing_buildRechargeOption(String lemonAmount, String price) {
    return GestureDetector(
      onTap: () => _baixing_onRechargeOptionSelected(lemonAmount, price),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lemonAmount,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              price,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 协议同意区域
  Widget _baixing_buildAgreementSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: _baixing_toggleAgreement,
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _mBaixing_agreementChecked ? Colors.purple : Colors.transparent,
                border: Border.all(
                  color: _mBaixing_agreementChecked ? Colors.purple : Colors.grey,
                ),
              ),
              child: _mBaixing_agreementChecked
                  ? Icon(Icons.check, color: Colors.white, size: 16.w)
                  : null,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '我已阅读并同意',
            style: TextStyle(fontSize: 14.sp),
          ),
          GestureDetector(
            onTap: _baixing_showAgreement,
            child: Text(
              '《用户充值协议》',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.purple,
              ),
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
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 查看交易历史
  void _baixing_onViewTransactionHistory() {
    Baixing_Toast.show('查看收支明细');
  }

  // 选择充值选项
  void _baixing_onRechargeOptionSelected(String lemonAmount, String price) {
    if (!_mBaixing_agreementChecked) {
      Baixing_Toast.show('请先同意用户充值协议');
      return;
    }
    
    Baixing_Toast.show('选择了$lemonAmount，价格$price');
    // 这里可以添加实际的充值逻辑
  }

  // 切换协议同意状态
  void _baixing_toggleAgreement() {
    setState(() {
      _mBaixing_agreementChecked = !_mBaixing_agreementChecked;
    });
  }

  // 显示协议内容
  void _baixing_showAgreement() {
    Baixing_Toast.show('查看用户充值协议');
    // 这里可以添加显示协议的逻辑
  }
}
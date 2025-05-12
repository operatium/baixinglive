import 'package:baixinglive/api/baixing_api_thirdapi.dart';

import '../api/baixing_api_background.dart';
import '../api/baixing_api_flutter.dart';
import '../compat/baixing_toast.dart';

/**
* @author yuyuexing
* @date: 2025.05.12
* @description: 充值确认对话框
*/
class Baixing_RechargeConfirmDialog extends StatefulWidget {
  final int mBaixing_amount; // 充值金额（元）
  final int mBaixing_lemonAmount; // 柠檬数量
  final Function(String) mBaixing_onConfirm; // 确认支付回调

  const Baixing_RechargeConfirmDialog({
    super.key,
    required this.mBaixing_amount,
    required this.mBaixing_lemonAmount,
    required this.mBaixing_onConfirm,
  });

  @override
  State<Baixing_RechargeConfirmDialog> createState() => _Baixing_RechargeConfirmDialogState();
}

class _Baixing_RechargeConfirmDialogState extends State<Baixing_RechargeConfirmDialog> {
  String _mBaixing_selectedPayment = 'wechat'; // 默认选择微信支付
  bool _mBaixing_couponEnabled = false; // 优惠券是否可用

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _baixing_appbar(),
          Divider(height: 1, color: Colors.grey[200]),
          _baixing_buildAmountSection(),
          Divider(thickness: 12.h, color: Colors.grey[200]),
          _baixing_buildPaymentOptions(),
          Divider(height: 1, color: Colors.grey[200]),
          _baixing_buildCouponSection(),
          _baixing_buildConfirmButton(),
          const Spacer(),
        ],
      ),
    );
  }

  // 构建头部
  Widget _baixing_appbar() {
    return AppBar(
      title: Text('确认支付'),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  // 充值金额区域
  Widget _baixing_buildAmountSection() {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '充值金额',
            style: textTheme.bodyMedium,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                '¥${widget.mBaixing_amount}',
                style: textTheme.titleMedium,
              ),
              SizedBox(width: 10.w),
              Text(
                '${widget.mBaixing_lemonAmount}柠檬',
                style: textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 支付方式选项
  Widget _baixing_buildPaymentOptions() {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '推荐支付方式',
            style: textTheme.bodyMedium,
          ),
          SizedBox(height: 16.h),
          _baixing_buildPaymentOption(
            'wechat',
            '微信支付',
            'images/baixing_weixin.webp',
          ),
          SizedBox(height: 16.h),
          _baixing_buildPaymentOption(
            '99pay',
            '支付宝支付',
            'images/baixing_99.webp',
          ),
        ],
      ),
    );
  }

  // 单个支付方式选项
  Widget _baixing_buildPaymentOption(String value, String title, String iconPath) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        setState(() {
          _mBaixing_selectedPayment = value;
        });
      },
      child: Row(
        children: [
          ClipOval(
            child: Container(
              width: 30.w,
              height: 30.w,
              child: Image.asset(iconPath),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: textTheme.bodyMedium,
          ),
          Spacer(),
          Radio<String>(
            value: value,
            groupValue: _mBaixing_selectedPayment,
            activeColor: Colors.black,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _mBaixing_selectedPayment = newValue;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // 优惠券区域
  Widget _baixing_buildCouponSection() {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        // 显示优惠券列表
        Baixing_Toast.show('暂无可用优惠券');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Text(
              '使用优惠券',
              style: textTheme.bodyMedium,
            ),
            Spacer(),
            Text(
              _mBaixing_couponEnabled ? '已选择' : '暂不可用',
              style: textTheme.bodySmall,
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[600],
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }

  // 确认按钮
  Widget _baixing_buildConfirmButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: Baixing_BackGround.baixing_getRoundedRectangular_K002(
        radius: 36.w,
      ),
      child: GestureDetector(
        onTap: () {
          widget.mBaixing_onConfirm(_mBaixing_selectedPayment);
        },
        child: Text(
          '确认支付',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
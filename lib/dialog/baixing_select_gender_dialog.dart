import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/api/baixing_api_flutter.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';

/*
 * 选择性别选择弹窗
 */
class Baixing_SelectGenderDialog extends StatefulWidget {
  Function(String) mBaixing_callback;

  Baixing_SelectGenderDialog({Key? key, required this.mBaixing_callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_SelectGenderDialogState();
  }
}

class _Baixing_SelectGenderDialogState extends State<Baixing_SelectGenderDialog> {
  final _baixing_debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: CupertinoActionSheet(
        title: Text('选择性别', style: textTheme.titleLarge),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('男', style: textTheme.bodyMedium),
            onPressed: () {
              _baixing_selectItem('男');
            },
          ),
          CupertinoActionSheetAction(
            child: Text('女', style: textTheme.bodyMedium),
            onPressed: () {
              _baixing_selectItem('女');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            '取消',
            style: textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _baixing_selectItem(String string) {
    _baixing_debouncer.debounce(
      duration: Baixing_dd500ms,
      onDebounce: () async {
        Navigator.pop(context);
        widget.mBaixing_callback(string);
      },
    );
  }
}

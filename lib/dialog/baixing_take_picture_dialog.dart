import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/api/baixing_api_flutter.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';

/*
 * 选择头像弹窗
 */
class Baixing_TakePictureDialog extends StatefulWidget {
  Function(Widget) mBaixing_callbackImage;

  Baixing_TakePictureDialog({Key? key, required this.mBaixing_callbackImage}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Baixing_TakePictureDialogState();
  }
}

class _Baixing_TakePictureDialogState extends State<Baixing_TakePictureDialog> {
  final ImagePicker _picker = ImagePicker();
  final _baixing_debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: CupertinoActionSheet(
        title: Text('选择头像', style: textTheme.titleLarge),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('相册', style: textTheme.bodyMedium),
            onPressed: () {
              _baixing_pickImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text('拍照', style: textTheme.bodyMedium),
            onPressed: () {
              _baixing_pickImage(ImageSource.camera);
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

  // 从相册选择图片
  void _baixing_pickImage(ImageSource source) {
    _baixing_debouncer.debounce(
      duration: Baixing_dd500ms,
      onDebounce: () async {
        Navigator.pop(context);
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: 800,
          maxHeight: 800,
          imageQuality: 100,
        );
        if (pickedFile != null) {
          widget.mBaixing_callbackImage(
              Image.file(File(pickedFile.path), fit: BoxFit.cover)
          );
        }
      },
    );
  }
}

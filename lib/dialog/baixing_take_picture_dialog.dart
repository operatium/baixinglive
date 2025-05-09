import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/api/baixing_api_flutter.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';
import 'package:image_picker/image_picker.dart';

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
              _baixing_debouncer.debounce(
                duration: Baixing_dd500ms,
                onDebounce: () {
                  Navigator.pop(context);
                  _baixing_pickImageFromGallery();
                },
              );
            },
          ),
          CupertinoActionSheetAction(
            child: Text('拍照', style: textTheme.bodyMedium),
            onPressed: () {
              _baixing_debouncer.debounce(
                duration: Baixing_dd500ms,
                onDebounce: () {
                  _baixing_pickImageFromGallery();
                },
              );
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
  Future<void> _baixing_pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      widget.mBaixing_callbackImage(
          Image.file(File(pickedFile.path), fit: BoxFit.cover)
      );
    }
  }
}

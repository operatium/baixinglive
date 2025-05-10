import 'package:baixinglive/api/baixing_api.dart';
import 'package:baixinglive/api/baixing_api_thirdapi.dart';

import '../api/baixing_api_flutter.dart';

class Baixing_NickNameEditScene extends StatefulWidget {
  const Baixing_NickNameEditScene({Key? key}) : super(key: key);

  @override
  State<Baixing_NickNameEditScene> createState() =>
      _Baixing_NickNameEditSceneState();
}

class _Baixing_NickNameEditSceneState extends State<Baixing_NickNameEditScene> {
  final TextEditingController _nicknameController = TextEditingController();
  int _characterCount = 0;

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_updateCharacterCount);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nickname = context.read<Baixing_AccountModel>().baixing_getNickName();
      _nicknameController.text = nickname;
      _characterCount = nickname.length;
    });
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _updateCharacterCount() {
    final text = _nicknameController.text;
    // 简单计算：中文占2字符，其他占1字符
    int count = 0;
    for (var char in text.runes) {
      if (char > 0x7F) {
        count += 2;
      } else {
        count += 1;
      }
    }

    setState(() {
      _characterCount = count;
    });
  }

  void _clearText() {
    _nicknameController.clear();
  }

  void _saveNickname() {
    // 实现保存逻辑
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('昵称已保存')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('编辑昵称'),
        actions: [
          TextButton(
            onPressed: () {
              _saveNickname();
            },
            child: Text('保存', style: textTheme.titleSmall),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            controller: _nicknameController,
                            placeholder: '请输入昵称',
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            maxLength: 20,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: _clearText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 1.h, color: Color(0xFFEEEEEE)),
              Container(
                margin: EdgeInsets.only(right: 40.w),
                alignment: Alignment.centerRight,
                child: Text(
                  '$_characterCount/20',
                  style: textTheme.labelSmall,
                ),
              ),
              Container(
                child: Text(
                  '1. 每天最多修改3次；\n'
                  '2.仅支持数字/字母/汉字/下划线；不建议使用生僻字；\n'
                  '3.昵称限20字符，中文占2字符，英文/数字占1字符；\n'
                  '4.使用健康/财经/司法/教育类昵称，请先完成相关资质认证；\n'
                  '5.禁止使用色情/违法/低俗昵称；\n',
                  style: textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

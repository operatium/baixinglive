# 项目规则
### 基本
- 使用中文进行交流
- 这是 Flutter 项目
- 编写 dart 代码
- 出现文件的增加和删除都要完善到工程索引.md文件里。
- changelog.txt已有内容不可变，只能进行内容追加。
将每一次操作的当前时间，操作内容，修改过的文件都写入changelog.txt。
```
\n
2025.04.25 14:29(当前时间)
app/src/main/java/com/baixingkuaizu/live/android/Baixing_Config.kt
```

### 内容
- 每次修改代码前必须将修改前的代码使用 Git 提交
- 通过执行以下命令获取当前时间
```
date '\n+%Y-%m-%d %H:%M:%S'
```


### 代码规范
- 每一个类都必须创建一个新的文件
- 每一个类都必须定义一个新的类
- 每一个类都必须在顶部写上注释，格式必须是
  /**
* @author yuyuexing
* @date:
* @description:
  */
- 类的前缀是: Baixing_
- 私有类的前缀是: _Baixing_
- 成员变量的前缀是: mBaixing_
- 私有成员变量的前缀是: _mBaixing_
- 函数的前缀是: baixing_
- 私有函数的前缀是: _baixing_
- 数据类的类名都以Entity结尾
- 写对话框，界面内容文件在lib/dialog/目录下, 文件名以Dialog结尾。显示对话框的函数名必须写在lib/api/baixing_api_dialog.dart文件中。
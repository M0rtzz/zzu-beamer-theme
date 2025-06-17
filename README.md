# 郑州大学Beamer模板

## Build

```shell
make
```

## LaTeX+VSCode配置教程

[VSCode_Configuration.md](./docs/VSCode_Configuration.md)

或：

[https://blog.csdn.net/M0rtzz/article/details/136026129](https://blog.csdn.net/M0rtzz/article/details/136026129)

或：

[https://www.m0rtzz.com/posts/4](https://www.m0rtzz.com/posts/4)

## 模板

由于Overleaf官方免费版的编译时长限制过短，故提供[中国科技云Overleaf模板](https://template-sharelatex.cstcloud.cn/templateDesc/684e42ac2f021b517f8953c8)，根据链接内项目的文件树进行准备即可。

![image-20250615115311213](https://static.m0rtzz.com/images/Year:2025/Month:06/Day:15/11:53:11_image-20250615115311213.png)

如果你注册不了中国科技云账号，可使用[鄙人自行搭建的Overleaf（注册需要`*.edu.cn`邮箱且稳定性及速度不如中国科技云）](https://latex.m0rtzz.com/template/684d77651f36ba61d78abb04)。

![image-20250617130955023](https://static.m0rtzz.com/images/Year:2025/Month:06/Day:17/13:10:02_image-20250617130955023.png)

### 一些注意事项

如果报错：

![image-20250614185740855](https://static.m0rtzz.com/images/Year:2025/Month:06/Day:14/18:57:40_image-20250614185740855.png)

请检查编译器是不是`XeLaTeX`：

点击左上角的`Menu`：

![image-20250614180421389](https://static.m0rtzz.com/images/Year:2025/Month:06/Day:14/18:04:21_image-20250614180421389.png)

选择`Compiler`为`XeLaTeX`并设置`Main document`为`slide.tex`：

![image-20250614184619421](https://static.m0rtzz.com/images/Year:2025/Month:06/Day:14/18:46:19_image-20250614184619421.png)

编译成功：

![image-20250614185818664](https://static.m0rtzz.com/images/Year:2025/Month:06/Day:14/18:58:18_image-20250614185818664.png)

## References

[THU-Beamer-Theme](https://github.com/tuna/THU-Beamer-Theme)

[xelatex-emoji](https://github.com/mreq/xelatex-emoji)

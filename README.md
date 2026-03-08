# 郑州大学 Beamer 模板

## Build

```shell
make
```

## LaTeX + VSCode 配置教程

[https://blog.csdn.net/M0rtzz/article/details/136026129](https://blog.csdn.net/M0rtzz/article/details/136026129)

或：

[https://www.m0rtzz.com/posts/4](https://www.m0rtzz.com/posts/4)

## 模板

由于 Overleaf 官方免费版的编译时长限制过短，故提供[中国科技云 Overleaf 模板](https://template-sharelatex.cstcloud.cn/templateDesc/69ad476b3425935175b3586b)，根据链接内项目的文件树进行准备即可。

![image-20250711175448412](https://static.m0rtzz.com/images/Year:2025/Month:07/Day:11/17:54:55_image-20250711175448412.png)

### 一些注意事项

如果报错：

![image-20260308172139740](https://static.m0rtzz.com/images/Year:2026/Month:03/Day:08/17:21:39_image-20260308172139740.png)

请检查编译器是不是 `LuaLaTeX`：

点击左上角的 `Menu`：

![image-20250614180421389](https://static.m0rtzz.com/images/Year:2025/Month:06/Day:14/18:04:21_image-20250614180421389.png)

选择 `Compiler` 为 `XeLaTeX` 并设置 `Main document` 为 `slide.tex`：

![image-20260308172215694](https://static.m0rtzz.com/images/Year:2026/Month:03/Day:08/17:22:15_image-20260308172215694.png)

编译成功：

![image-20260308172607298](https://static.m0rtzz.com/images/Year:2026/Month:03/Day:08/17:26:07_image-20260308172607298.png)

## References

[THU-Beamer-Theme](https://github.com/tuna/THU-Beamer-Theme)

# number_pagination_flutter文档 1.0.0

# 组件库文档模版

## 版本更新说明

### version 1.0.0 2024/4/28

# 样式

![Untitled](README_IMG/Untitled.png)

1. 拟定组件库文档模版

## 一、目录结构

| 一级目录 |  子目录 | 说明 |
| --- | --- | --- |
| lib |  | 组件库源码 |
|  | number_pagination_flutter | 基础框架源码目录 |
|  | files | 基础框架工具类目录 |
| test |  | 单元测试用例目录 |

## 二、导入方法

在需要引用本组件库的flutter工程中的pubspec.yaml中添加依赖

```dart
dependencies:
  flutter:
    sdk: flutter
	...
	number_pagination_flutter: ^1.0.0
	...
```

## 三、使用方法

具体的细节参数，都行写了英文备注，可以进去看

```dart
NumberPaginationFlutter(
                  onPageChanged: (int pageNumber) {
                    controller.page.value = pageNumber;
                  },
                  threshold: 10,
                  pageTotal: size,
                  pageInit: currentPage, // picked number when init page
                  colorPrimary: Colors.blue,
                  colorBackGround: Colors.white,
                )
```
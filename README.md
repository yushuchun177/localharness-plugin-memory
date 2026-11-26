# 记忆系统

长期记忆：记住偏好与事实，按关键词检索，只存本机。

Local-Harness（Godot 版）的独立插件。**不随主程序发布**，由主程序「设置 → 插件管理」从 GitHub 下载并自动部署到 `user://plugins/memory/`。

## 工具

- `memory_remember` —— 记住一条事实或偏好（尽量一句话，带关键词方便以后检索）。
  - `text`: string，要记住的内容
  - `tag`: string，可选，分类标签，例如 偏好 / 事实 / 项目
- `memory_recall` —— 按关键词检索记忆；不给关键词就返回最近 10 条。
  - `query`: string，可选
  - `limit`: int，可选，默认 10
- `memory_forget` —— 按关键词删除匹配到的记忆。
  - `query`: string，关键词

## 安装

1. 打开 Local-Harness → 设置 → 插件管理 → 刷新列表
2. 找到「记忆系统」点安装
3. 装完直接在对话里让模型调用即可（插件会出现在系统提示的工具清单里）

也可以手动：把本仓库下载解压到 `%LOCALAPPDATA%\Godot\app_userdata\Local-Harness\plugins\memory\`。

## 结构

```
manifest.json   清单：id / 版本 / 工具定义
main.gd         extends Node，实现 run(tool, args) -> {ok, output}
```

## 许可

GPL-3.0（与主程序一致）。

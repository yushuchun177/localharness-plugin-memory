# 记忆系统 / Memory

长期记忆：把用户偏好、事实记下来，需要时按关键词检索。存在本地 user:// 里，不上传。

Long-term memory: store facts, recall by keyword, local only.

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

1. Local-Harness → 设置 → 插件管理 → 刷新列表
2. 找到「记忆系统」点安装
3. 装完直接在对话里让模型调用（插件会出现在系统提示的工具清单里）

手动安装：把仓库解压到 `%LOCALAPPDATA%\Godot\app_userdata\Local-Harness\plugins\memory\`。

## 结构

```
manifest.json   清单：id / 版本 / 工具定义
main.gd         extends Node，实现 run(tool, args) -> {ok, output}
```

## 许可

GPL-3.0（与主程序一致）。完整协议文本见仓库根目录的 `LICENSE` 文件。

# 记忆系统 / Memory

长期记忆：把用户偏好、事实记下来，需要时按关键词检索。存在本地 user:// 里，不上传。

Long-term memory: store facts, recall by keyword, local only.

> Local-Harness（Godot 版）的独立插件。不随主程序发布，由主程序
> 「设置 → 插件管理」从 GitHub 下载并自动部署到 `user://plugins/memory/`。

## 安装

1. 打开 Local-Harness → 设置 → 插件管理 → 刷新列表
2. 找到「记忆系统」点「安装」
3. 装好后在侧栏底部点同名按钮，里面是这个插件自己的设置页

手动安装：把本仓库下载解压到 `%LOCALAPPDATA%\Godot\app_userdata\Local-Harness\plugins\memory\`

## 工具

- `memory_remember` —— 记住一条事实或偏好（尽量一句话，带关键词方便以后检索）。（会产生操作）
  - `text`: string，要记住的内容
  - `tag`: string，可选，分类标签，例如 偏好 / 事实 / 项目
- `memory_recall` —— 按关键词检索记忆；不给关键词就返回最近 10 条。（只读）
  - `query`: string，可选
  - `limit`: int，可选，默认 10
- `memory_forget` —— 按关键词删除匹配到的记忆。（会产生操作）
  - `query`: string，关键词

## 命令

- `/mem 要记住的内容` —— 记住一句话
- `/memlist [关键词]` —— 看已记住的内容

## 设置项

- **最多记忆条数**（`max_items`，默认 `500`）超过后自动丢弃最早的

## 权限

每个工具都能在插件设置页里单独开关。关掉之后它不会出现在模型的工具清单里，
就算模型硬要调用也会被主程序拒绝。协议里用 `level` 标了风险等级：

- `read` 只读：不会改动任何东西
- `act` 会产生操作：会读写文件、联网或占用设备
- `danger` 高危：会操作你的系统

## 怎么用

装好后直接在对话里提需求，例如：“记住一条事实或偏好（尽量一句话，带关键词方便以后检索）。”

模型会输出一行 ```tool 协议块，宿主解析后执行，再把结果喂回模型。
也可以直接用斜杠命令，不经过模型。

## 许可

GPL-3.0（与主程序一致）。完整协议文本见仓库根目录的 [LICENSE](LICENSE)。

---

# Memory

Long-term memory: store facts, recall by keyword, local only.

> An independent plugin for **Local-Harness (Godot edition)**. It is not bundled with the
> app; the app downloads it from this repository into `user://plugins/memory/` and hot-loads it.

## Install

1. Local-Harness → Settings → Plugins → Refresh
2. Find "Memory" and click Install
3. Open it from the button at the bottom of the sidebar for its own settings page

Manual: unzip this repo into `%LOCALAPPDATA%\Godot\app_userdata\Local-Harness\plugins\memory\`

## Tools

- `memory_remember` — 记住一条事实或偏好（尽量一句话，带关键词方便以后检索）。 (has side effects)
  - `text`: string，要记住的内容
  - `tag`: string，可选，分类标签，例如 偏好 / 事实 / 项目
- `memory_recall` — 按关键词检索记忆；不给关键词就返回最近 10 条。 (read-only)
  - `query`: string，可选
  - `limit`: int，可选，默认 10
- `memory_forget` — 按关键词删除匹配到的记忆。 (has side effects)
  - `query`: string，关键词

## Commands

- `/mem 要记住的内容` — 记住一句话
- `/memlist [关键词]` — 看已记住的内容

## Settings

- **最多记忆条数** (`max_items`, default `500`) 超过后自动丢弃最早的

## Permissions

Every tool can be toggled individually on the plugin settings page. A disabled tool is
removed from the model's tool list and rejected by the host even if the model still calls it.
`level` in the manifest marks the risk:

- `read` — no side effects
- `act` — reads/writes, network or devices
- `danger` — controls your system

## Usage

Just ask in the chat, e.g. “记住一条事实或偏好（尽量一句话，带关键词方便以后检索）。”

The model emits a ```tool block, the host executes it and feeds the result back.
You can also use the slash commands above, which skip the model entirely.

## License

GPL-3.0 (same as the host app). Full text: [LICENSE](LICENSE).

extends VBoxContainer
## 记忆系统 —— 这个页面是插件自己提供的界面。
## 界面全部由插件自己拼，主程序只提供积木。

func build(plugin_id: String) -> void:
	add_theme_constant_override("separation", 12)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var rows: Array = []
	var path := "user://plugin_memory.json"
	var f := FileAccess.open(path, FileAccess.READ)
	if f != null:
		var arr = JSON.parse_string(f.get_as_text())
		if arr is Array:
			for it in arr:
				rows.append(it)
	rows.reverse()

	add_child(PluginUI.section("现在的情况"))
	add_child(PluginUI.stats_row([
		{"label": "记住的条数", "value": str(rows.size())},
		{"label": "存在哪", "value": "本机"},
		{"label": "上限", "value": str(PluginPrefs.get_value(plugin_id, "max_items", 500))},
	]))

	add_child(PluginUI.section("怎么记"))
	add_child(PluginUI.big_toggle(plugin_id, "auto", "让助手自己决定要不要记",
		"打开后，你说到偏好、身份、重要事实时它会主动记下来；关掉则只在你明确说“记住”时记", true))

	var table_rows: Array = []
	for it in rows:
		var when := Time.get_datetime_string_from_unix_time(int(it.get("ts", 0))).replace("T", " ")
		table_rows.append([when, str(it.get("tag", "")) if str(it.get("tag", "")) != "" else "—",
			str(it.get("text", ""))])
	add_child(PluginUI.data_card("已记住的内容",
		"保存在 %s（只在本机）" % ProjectSettings.globalize_path(path),
		["时间", "标签", "内容"], table_rows,
		"还没有任何记忆。在对话里说“记住：我不吃香菜”，或者用 /mem 我不吃香菜"))

	add_child(PluginUI.action_row("清空全部记忆",
		"把上面这些全删掉，不可恢复", "清空", func(): return _clear_all()))
	add_child(PluginUI.overview(plugin_id))
	add_child(PluginUI.permissions_section(plugin_id))
	add_child(PluginUI.doc_section(plugin_id))


func _clear_all() -> Dictionary:
	var f := FileAccess.open("user://plugin_memory.json", FileAccess.WRITE)
	if f != null:
		f.store_string("[]")
	return {"ok": true, "output": "已清空，下次打开就是空的"}

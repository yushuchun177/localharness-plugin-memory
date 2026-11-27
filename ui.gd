extends VBoxContainer
## 记忆系统的设置界面（插件自己提供）

func build(plugin_id: String) -> void:
	add_theme_constant_override("separation", 12)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(PluginUI.plugin_header(plugin_id))
	add_child(PluginUI.overview(plugin_id))

	# 数据：真的把存在本机的记忆列出来
	var rows: Array = []
	var path := "user://plugin_memory.json"
	var f := FileAccess.open(path, FileAccess.READ)
	if f != null:
		var arr = JSON.parse_string(f.get_as_text())
		if arr is Array:
			for it in arr:
				var ts := int(it.get("ts", 0))
				var when := Time.get_datetime_string_from_unix_time(ts).replace("T", " ")
				rows.append([when, str(it.get("tag", "")) if str(it.get("tag", "")) != "" else "—",
					str(it.get("text", ""))])
	# 最新的排前面
	rows.reverse()
	add_child(PluginUI.data_card("已记住的内容",
		"保存在 %s（只在本机，不上传、不联网）" % ProjectSettings.globalize_path(path),
		["时间", "标签", "内容"], rows,
		"还没有任何记忆。在对话里说“记住……”或者调用 memory_remember 就会出现在这里。"))

	add_child(PluginUI.command_section(plugin_id))
	add_child(PluginUI.settings_section(plugin_id))
	add_child(PluginUI.permissions_section(plugin_id))
	add_child(PluginUI.doc_section(plugin_id))

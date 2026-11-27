extends VBoxContainer
## 本插件的设置界面 —— 由插件自己提供，主程序只负责挂载。
## 想改这个插件在这里长什么样、有哪些开关，改这个文件即可。

func build(plugin_id: String) -> void:
	add_theme_constant_override("separation", 10)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(PluginUI.title("记忆系统"))
	add_child(PluginUI.hint("把偏好和事实记在本机，需要时按关键词找回来。不上传、不联网。"))
	add_child(PluginUI.section("行为"))
	add_child(PluginUI.int_field(plugin_id, "max_items", "最多记忆条数", 500,
		"超过后自动丢弃最早的记忆"))
	add_child(PluginUI.section("能力开关"))
	add_child(PluginUI.hint("每一项都能单独关掉；关掉后模型看不到这个能力，也调用不了。"))
	for t in Plugins.tools_of(plugin_id):
		var tname := str(t.get("name", ""))
		var human := tname
		var desc := str(t.get("description", ""))
		if tname == "memory_remember":
			human = "写入记忆"
			desc = "把一条内容存到本机记忆库"
		if tname == "memory_recall":
			human = "检索记忆"
			desc = "按关键词读回来"
		if tname == "memory_forget":
			human = "删除记忆"
			desc = "会真的删掉匹配到的记录"
		add_child(PluginUI.perm_row(tname, human, desc, bool(t.get("dangerous", false))))
	add_child(PluginUI.readme_box(plugin_id))

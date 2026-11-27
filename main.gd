extends Node
## 记忆插件 · local-harness
## 工具：memory_remember(text, tag?) / memory_recall(query?, limit?) / memory_forget(query)
##
## 数据文件：user://plugin_memory.json —— 只在本机，不上传、不联网。
## 结构：[{text, tag, ts}]

const STORE := "user://plugin_memory.json"


func _load() -> Array:
	var f := FileAccess.open(STORE, FileAccess.READ)
	if f == null:
		return []
	var obj = JSON.parse_string(f.get_as_text())
	if obj is Array:
		return obj
	return []


func _save(items: Array) -> void:
	var f := FileAccess.open(STORE, FileAccess.WRITE)
	if f:
		f.store_string(JSON.stringify(items, "  "))



func _pref(key: String, def_value):
	var ml := Engine.get_main_loop()
	var prefs = ml.root.get_node_or_null("/root/PluginPrefs") if ml != null else null
	if prefs == null:
		return def_value
	return prefs.get_value("memory", key, def_value)

func run(tool: String, args: Dictionary) -> Dictionary:
	match tool:
		"memory_remember":
			return _remember(args)
		"memory_recall":
			return _recall(args)
		"memory_forget":
			return _forget(args)
	return {"ok": false, "output": "未知工具：%s" % tool}


func _remember(args: Dictionary) -> Dictionary:
	var text := str(args.get("text", "")).strip_edges()
	if text == "":
		return {"ok": false, "output": "text 不能为空"}
	var items := _load()
	for it in items:
		if str(it.get("text", "")) == text:
			return {"ok": true, "output": "这条已经记过了"}
	items.append({
		"text": text,
		"tag": str(args.get("tag", "")),
		"ts": int(Time.get_unix_time_from_system()),
	})
	var cap: int = int(_pref("max_items", 500))
	if items.size() > cap:
		items = items.slice(items.size() - cap, items.size())
	_save(items)
	return {"ok": true, "output": "记住了（共 %d 条）" % items.size()}


func _recall(args: Dictionary) -> Dictionary:
	var q := str(args.get("query", "")).strip_edges().to_lower()
	var limit := int(args.get("limit", 10))
	var items := _load()
	if items.is_empty():
		return {"ok": true, "output": "（记忆是空的）"}
	var hits: Array = []
	for it in items:
		var t := str(it.get("text", ""))
		if q == "" or t.to_lower().find(q) >= 0 or str(it.get("tag", "")).to_lower().find(q) >= 0:
			hits.append(it)
	if hits.is_empty():
		return {"ok": true, "output": "没有匹配「%s」的记忆" % q}
	var out: PackedStringArray = []
	for i in range(hits.size() - 1, max(-1, hits.size() - 1 - limit), -1):
		var it: Dictionary = hits[i]
		var tag := str(it.get("tag", ""))
		var line := "- " + str(it.get("text", ""))
		if tag != "":
			line += "  [" + tag + "]"
		out.append(line)
	return {"ok": true, "output": "\n".join(out)}


func _forget(args: Dictionary) -> Dictionary:
	var q := str(args.get("query", "")).strip_edges().to_lower()
	if q == "":
		return {"ok": false, "output": "query 不能为空"}
	var items := _load()
	var keep: Array = []
	var removed := 0
	for it in items:
		if str(it.get("text", "")).to_lower().find(q) >= 0:
			removed += 1
		else:
			keep.append(it)
	_save(keep)
	return {"ok": true, "output": "删除了 %d 条，剩 %d 条" % [removed, keep.size()]}

class_name ArrayJoin extends Object

static func join(array: Variant, sep: String = ",") -> String:
	var r := ""
	var start := true
	for v in array:
		if start:
			r += sep
		r += str(v)
		start = false
	return r

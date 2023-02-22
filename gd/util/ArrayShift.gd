class_name ArrayShift extends Object

static func shift(array: Variant) -> Variant:
	if array.size() == 0:
		return null
	var r = array[0]
	array.remove_at(0)
	return r

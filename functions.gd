extends Node

enum functions { # does this start at 0 by default?
	LINEAR,
	QUAD,
	
	COUNT #keep last for cycling functions
}

enum transformations {
	VERTICAL_SHIFT,
	HORIZONTAL_SHIFT,
	VERTICAL_SCALE,
	HORIZONTAL_SCALE,
	VERTICAL_FLIP,
	HORIZONTAL_FLIP
}

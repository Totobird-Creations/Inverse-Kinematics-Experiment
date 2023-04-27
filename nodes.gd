extends Node2D


func _physics_process(delta : float) -> void:
	var children := %nodes.get_children();
	children.reverse();

	for child in children:
		if (child is IKNode):
			var next   :         = %nodes.get_child(child.get_index() + 1);
			if (next is IKNodeEnd):
				child.global_position = child.global_position.move_toward(next.global_position, 250.0 * delta);
			else:
				var direction := Vector2.ZERO;
				if (Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
					var rng    := RandomNumberGenerator.new();
					var offset := self.get_global_mouse_position();
					direction = (next.global_position - child.global_position).normalized() + (child.global_position - offset).normalized() + Vector2(rng.randf_range(-16.0, 16.0), rng.randf_range(-1.0, 1.0)) * 0.1;
				else:
					direction = next.global_position - child.global_position;
				child.global_position = next.global_position - direction.normalized() * child.length;

	var last := children[0];
	children.reverse();
	var first :         = true;
	var pos   : Vector2;
	for child in children:
		if (child is IKNode):
			if (first):
				pos = child.global_position - %nodes.get_child(0).global_position;
				first = false;
			child.global_position -= pos;

	%line.points = PackedVector2Array(children.filter(func(child : Node) -> bool: return child is IKNode).map(func(child : Node) -> Vector2: return child.global_position));

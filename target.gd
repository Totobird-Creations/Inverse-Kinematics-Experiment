extends Node2D
class_name IKNodeEnd


@export
var mouse_button : MouseButton = MOUSE_BUTTON_LEFT;
@export
var randomise : bool = false;

var target : Vector2;


func _physics_process(delta: float) -> void:
	if (Input.is_mouse_button_pressed(self.mouse_button) && self.global_position.distance_to(target) > 512.0):
		self.target = self.get_global_mouse_position();
	self.global_position = self.global_position.move_toward(self.target, 512.0 * delta);
	if (self.randomise && self.global_position.is_equal_approx(self.target)):
		var target := self.get_global_mouse_position();
		if (Input.is_mouse_button_pressed(self.mouse_button) && self.global_position.distance_to(target) > 128.0):
			self.target = target;
		else:
			self.randomise_now();


func randomise_now() -> void:
	var rng := RandomNumberGenerator.new();
	rng.randomize();
	self.target = Vector2(self.rand(rng), self.rand(rng));

func rand(rng : RandomNumberGenerator) -> float:
	return rng.randf_range(256.0, 512.0) * sign(rng.randf_range(-1.0, 1.0))

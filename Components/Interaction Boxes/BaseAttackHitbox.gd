extends PlayerHitbox
class_name BaseAttackHitbox

func _on_area_entered(area):
	var popupInst : Marker2D = damagePopup.instantiate()
	Ref.particlesFolder.add_child(popupInst)
	popupInst.label.text = str(snapped(PlayerInfo.data.baseDamage, 0.1))
	popupInst.global_position = area.global_position

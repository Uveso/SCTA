
local TACommander = import('/mods/SCTA-master/lua/TAconstructor.lua').TACommander
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun

CORDECOM = Class(TACommander) {

	Weapons = {
		COMLASER = Class(TAweapon) {
		},
		DGun = Class(TADGun) {
		},		
		AutoDGun = Class(TADGun) {
		},
	},
}

TypeClass = CORDECOM
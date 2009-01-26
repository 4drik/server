otstd.shovel = {}

otstd.shovels = {
		[2554] = {},
		[5710] = {}
	}
	
function otstd.shovel.callback(event)
	local tile = map:getTile(event.target)
	if tile then
		local hole = tile:getThing(event.target.stackpos)
		if not hole then
			return
		end
		
		for holeid, openid in pairs(otstd.holes) do
			if openid.open and hole:getItemID() == holeid then
				hole:setItemID(openid.open)
				hole:startDecaying()
				return
			end
		end
	end
	
	event.retval = RETURNVALUE_NOTPOSSIBLE
end

function otstd.shovel.registerHandlers()
	for id, data in pairs(otstd.shovels) do
		if data.listener ~= nil then
			stopListener(data.listener)
		end
		data.listener =
			registerOnUseItemNearby("itemid", id, otstd.shovel.callback)
	end
end

otstd.shovel.registerHandlers()

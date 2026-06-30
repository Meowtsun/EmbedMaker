--!nocheck

local copy = require(script.Parent.Copy)


local function reconcile<a, b> (src: a, template: b): a & b
	local tbl = table.clone(src)

	for k, v in template do
		local src = src
		local sv = src[k]
		if sv == nil then
			if type(v) == "table" then
				tbl[k] = copy(v, true)
			else
				tbl[k] = v
			end
		elseif type(sv) == "table" then
			if type(v) == "table" then
				tbl[k] = reconcile(sv, v)
			else
				tbl[k] = copy(sv, true)
			end
		end
	end

	return tbl
end


return reconcile
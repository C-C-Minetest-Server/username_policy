local auth = minetest.get_auth_handler()
local disconnect_string = "" ..
    "Your username (%s) is disallowed because it matches the following pattern: %s\n" ..
    "Consider another username. Additional informations:\n%s\n" ..
    "Report bug: bit.ly/ccs_up_i"

local disallowed_patterns = {
    ["Player%d"] = "Please think of your own username.\nUsername Generator: bit.ly/ccs_ug",
}

minetest.register_on_prejoinplayer(function(name, ip)
    if auth.get_auth(name) then return end
    for x,y in pairs(disallowed_patterns) do
        if name:match(x) then
            return disconnect_string:format(name,x,y or "None")
        end
    end
end)

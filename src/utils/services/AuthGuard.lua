--[[
authguard.org yes
]]

local AuthGuard = {}

function AuthGuard.New(ServiceId)
    local API = loadstring(game:HttpGet("https://cdn.authguard.org/virtual-file/36ecbcfd36c74381846aa46ad683de3a"))()
    local fsetclipboard = setclipboard or toclipboard
    
    local __SERVICE_ID = ServiceId or error("No Service ID provided")
    
    function Validatekey(key)
        if AuthGuard.ValidateKey({Service = __SERVICE_ID__,Key = key}) ~= "validated" then
            return false, "Invalid Key"
        end
        return true, "Valid Key"
    end

    function CopyLink()
        fsetclipboard(AuthGuard.GetKeyLink({Service = __SERVICE_ID__}))
    end

    return {
        Verify = Validatekey,
        Copy = CopyLink
    }
end

return AuthGuard


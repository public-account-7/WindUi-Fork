return {
    platoboost = {
        Name = "Platoboost",
        Icon = "rbxassetid://75920162824531",
        Args = {"ServiceId", "Secret"},
        
        
        New = require("./Platoboost").New
    },
    pandadevelopment = {
        Name = "Panda Development",
        Icon = "panda",
        Args = {"ServiceId"},
        
        
        New = require("./PandaDevelopment").New
    },
    luarmor = {
        Name = "Luarmor",
        Icon = "rbxassetid://130918283130165",
        Args = {"ScriptId", "Discord"},
        
        
        New = require("./Luarmor").New
    },
    authguard = {
        Name = "AuthGuard",
        Icon = "rbxassetid://0",
        Args = {"ServiceId"},

        New = require("./AuthGuard").New
    },
}
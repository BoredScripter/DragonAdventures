return function (self)
    if _G.Client.InTutorial then
        __require("model.utils.CompleteTutorial")()
    end
end
local Constants = require('utils.Constants')

Menu = {}

function Menu:new()
    local menu = {
        selectedOption = 1,
        currentState = Constants.States.MENU,
        options = {
            "Play 2 players",
            "Play 4 players",
            "Foosball",
            "Close game"
        }
    }

    setmetatable(menu, self)
    self.__index = self

    return menu
end

function Menu:getCurrentState()
    return self.currentState
end

function Menu:getSelectedOption()
    return self.selectedOption
end

function Menu:getMenuOptions()
    return self.options
end

function Menu:setCurrentState(newState)
    self.currentState = newState
end

function Menu:setSelectedOption(newOption)
    self.selectedOption = newOption
end

return Menu
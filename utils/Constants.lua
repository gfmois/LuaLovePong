local Constants = {}

-- State
Constants.States = {
    MENU = 0,
    DEFAULT_GAME = 1,
    MULTIPLE_GAME = 2,
    FOOSBALL_GAME = 3
}

Constants.WindowOptions = {
    HEIGHT = 600,
    WIDTH = 800
}

Constants.PaddleOptions = {
    WIDTH = 10,
    HEIGHT = 80,
    SPEED = 300
}

Constants.BallOptions = {
    SIZE = 10,
    SPEED = 200
}

Constants.Player = {
    LEFT_PLAYER = {
        UP = 'w',
        DOWN = 's',
    },
    RIGHT_PLAYER = {
        UP = "up",
        DOWN = 'down',
    },
    TOP_PLAYER = {
        UP = "left",
        DOWN = 'right',
    },
    BOTTOM_PLAYER = {
        UP = "kp4",
        DOWN = 'kp6'
    }
}

return Constants
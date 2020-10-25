--paddle global variables
paddleWidth = 10
paddleHeight = 50

--movable objects initial speed
initialSpeed = 1.5

--main ball radius
ballRadius = 8

--screen global variables
screenWidth, screenHeight = love.graphics.getDimensions()

--spawns x/y global variables
playerSpawnX = 25
playerSpawnY = screenHeight/2-25
cpuSpawnX = screenWidth-35
cpuSpawnY = screenHeight/2-25

--score panel positioning global variables
playerScorePos = -45
cpuScorePos = 20
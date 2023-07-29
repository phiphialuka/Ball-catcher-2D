 SCREEN_WIDTH = 1280
 SCREEN_HEIGHT = 720


VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243



local RECTANGLE_WIDTH = 120
local RECTANGLE_HEIGHT = 20
local BALL_SIZE = 30


local playerX = SCREEN_WIDTH / 2 - RECTANGLE_WIDTH / 2
local ballX, ballY
local ballSpeed = 200
local ballFalling = false
local points = 0
local gameOver = false
local restartPrompt = false



local hitSound = love.audio.newSource("Hit.wav", "static")
local gameOverSound = love.audio.newSource("gameOver.wav", "static")



local customFont = love.graphics.newFont("font.ttf", 24)
 

function love.load()
    love.window.setTitle("Ball catcher 2D")
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBackgroundColor(0.4, 0.4, 0.4)
    love.graphics.setFont(customFont)
    resetBall()
end


function love.update(dt)
    if not gameOver then
       
        if love.keyboard.isDown("left") then
            playerX = playerX - 500 * dt
        elseif love.keyboard.isDown("right") then
            playerX = playerX + 500 * dt
        end

       
        playerX = math.max(0, math.min(playerX, SCREEN_WIDTH - RECTANGLE_WIDTH))

        
        if ballFalling then
            ballY = ballY + ballSpeed  * dt



            
            
            if ballY + BALL_SIZE >= SCREEN_HEIGHT - RECTANGLE_HEIGHT and ballX >= playerX and ballX + BALL_SIZE <= playerX + RECTANGLE_WIDTH then
                points = points + 10
                hitSound:play()
                resetBall()
            end

            
            if ballY + BALL_SIZE >= SCREEN_HEIGHT then
                gameOver = true
                gameOverSound:play()
            end
        end
    end

   
    if gameOver and love.keyboard.isDown("return") then
        resetGame()
    end
end


function love.draw()
    

    love.graphics.setBackgroundColor(0, 255, 255)


    love.graphics.setColor(255, 255, 0)
    love.graphics.rectangle("fill", playerX, SCREEN_HEIGHT - RECTANGLE_HEIGHT, RECTANGLE_WIDTH, RECTANGLE_HEIGHT)

   
    if ballFalling then
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", ballX, ballY, BALL_SIZE, BALL_SIZE)
    end

    
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Points  " .. points, 10, 10)

   
    

    
    if gameOver then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Game Over! Your Score   "  .. points, SCREEN_WIDTH / 2 - 120, SCREEN_HEIGHT / 2 - 10)

        if gameOver then
            love.graphics.setColor(0, 0, 0)
            love.graphics.print("Press  Enter  to  Restart", SCREEN_WIDTH / 2 - 120, SCREEN_HEIGHT / 2 + 30)
        end
    end
end


function resetBall()
    ballX = math.random(0, SCREEN_WIDTH - BALL_SIZE)
    ballY = 0
    ballFalling = true
end


function resetGame()
    playerX = SCREEN_WIDTH / 2 - RECTANGLE_WIDTH / 2
    points = 0
    customShift = 0
    gameOver = false
    restartPrompt = false
    resetBall()
end
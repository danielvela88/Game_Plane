-- Dependencias
push = require 'push'
Class = require 'class'

require 'Barco'
require 'Avion'

-- Variables generales
anchoVentana = 1280
altoVentana = 720
anchoVirtual = 432 
altoVirtual = 243

jugadorX = 432/2 - 25 
jugadorY = 180 

puntaje = 0


local avion = Avion()
local disparos = {}

function love.load()
    -- Configuración inicial
    love.window.setTitle('River Raid')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    smallFont = love.graphics.newFont('font.ttf', 15)
    love.graphics.setFont(smallFont)

    -- Sonidos
    sounds = {
        ['music'] = love.audio.newSource('RobotRace.mp3', 'static') -- AQUI PON EL NOMBRE DEL AUDIO
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()

    push:setupScreen(anchoVirtual, altoVirtual, anchoVentana, altoVentana, { 
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- parametros para Barco
    barco = Barco(anchoVirtual/2 + math.random(-200, 200), -10)
    estadoJuego = 'start'
    titulo = 'Enter inicia y espacio dispara'
    mensaje = ''

    love.keyboard.keysPressed = {}
end





function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if estadoJuego == 'start' then
            estadoJuego = 'play'
            titulo = ''
        else
            estadoJuego = 'start'
            avion:reset()
            barco:reset()
            puntaje = 0
        end
    elseif key == 'space' then
    	table.insert(disparos, {x = avion.x + avion.width/2 - 28, y = avion.y, width = 5, height = 10})
	end

end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.resize(w, h)
    push:resize(w, h)
end







function love.update(dt)
    avion:update(dt)

    if estadoJuego == 'play' then
        barco:update(dt)
    end

    if avion:collides(barco) then
        mensaje = 'Perdiste'
        estadoJuego = 'pause'
        titulo = 'Enter inicia y espacio dispara'
    else
        mensaje = ''
    end

    for i, disparo in ipairs(disparos) do
        disparo.y = disparo.y - 800 * dt -- ajusta esta velocidad según tus necesidades

        -- verifica la colisión con el barco
        if disparo.y < barco.y + barco.height and disparo.y + disparo.height > barco.y and 
           disparo.x < barco.x + barco.width and disparo.x + disparo.width > barco.x then

           	puntaje = puntaje + 1  -- Incrementar el puntaje
            table.remove(disparos, i)
            barco:reset()
        end

        -- Elimina disparos que ya no están en la pantalla
        if disparo.y < -disparo.height then
            table.remove(disparos, i)
        end
    end



    love.keyboard.keysPressed = {}
end







function love.draw()
    push:start()
    love.graphics.clear(54, 26, 237, 255)
    
    avion:render()
    barco:render()

    for _, disparo in pairs(disparos) do
    	love.graphics.setColor(255,255,255,255) --Cambiar el color de la balas
        love.graphics.rectangle('fill', disparo.x, disparo.y, disparo.width, disparo.height)
    end

    love.graphics.setColor(255, 255, 240)
    love.graphics.printf(titulo, 0, 10, anchoVirtual, 'center')
    love.graphics.setColor(25, 229, 144)
    love.graphics.print(mensaje, 180, 30)

    love.graphics.setColor(252, 139, 10)  
    love.graphics.printf("Score: " .. tostring(puntaje), 10, 10, anchoVirtual - 20, 'left') 
    
    push:finish()
end

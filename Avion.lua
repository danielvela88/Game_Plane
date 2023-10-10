
Avion = Class{}

local velocidadAvion = 200

function Avion:init()
    --Agregamos la imagen y obtenemos sus dimensiones
    self.image = love.graphics.newImage('Avion.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- posicion de la nave en medio de la pantalla
    self.x = jugadorX
    self.y = jugadorY
end


function Avion:update(dt)
    --Movimiento del Avion
    if love.keyboard.isDown('left') then
        if self.x > 0 and estadoJuego == 'play' then  --Limitar movimiento de avion en izquierda
            self.x = self.x + -velocidadAvion * dt
        end
    end

    if love.keyboard.isDown('right') then
        if self.x < 380 and estadoJuego == 'play' then  --Limitar movimiento de avion en derecha
            self.x = self.x + velocidadAvion * dt
        end
    end

    if love.keyboard.isDown('up') then
        if self.y > 100 and estadoJuego == 'play' then  --Limitar movimiento de avion arriba
            self.y = self.y + -velocidadAvion * dt
        end
    end

    if love.keyboard.isDown('down') then
        if self.y < 180 and estadoJuego == 'play' then  --Limitar movimiento de avion en abajo
            self.y = self.y + velocidadAvion * dt
        end
    end

end


-- Colision con otro objeto
function Avion:collides(objeto)
    return not (self.x > objeto.x + objeto.width or self.x + self.width < objeto.x or
                self.y > objeto.y + objeto.height or self.y + self.height < objeto.y)
end



--Dibujamos la imagen del Avion, le ponemos el jugadorX para que podamos moverla
function Avion:render()
    love.graphics.draw(self.image, self.x - 30, self.y - 20)
end


function Avion:reset()
    --Volvemos a poner los valores en X y Y para que cuando reinicie aparezca en posicion inicial
    self.x = 432/2 - 25
    self.y = 180
    love.graphics.draw(self.image, self.x, self.y)
end




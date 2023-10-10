
Barco = Class{}

imagenBarco = love.graphics.newImage('barco.png')


BARCO_ANCHO = 40
BARCO_ALTO = 40
local velocidadEnemigo = 0.4

function Barco:init(x, y, width, height) 
    self.x = x 
    self.y = y - 50
    self.width = BARCO_ANCHO
    self.height = BARCO_ALTO

    -- 
    self.dy = 0
    self.dx = 0
end




-- Coloca la Enmigo en el centro de la pantalla, sin movimiento.
function Barco:reset()
    self.x = math.random(anchoVirtual/2 -220, anchoVirtual / 2 + 80)
    self.y = - 50
end



function Barco:update(dt)
    self.x = self.x + 0 * dt
    self.y = self.y + velocidadEnemigo + 0 * dt -- Movimiento en Y del enemigo
end





function Barco:render()
    love.graphics.draw(imagenBarco, self.x , self.y)
end



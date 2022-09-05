function love.load()
	x, y, w, h = 10, 0, 20, 100  --player paddle
	ox,oy =  570 , 0
	cx,cy = 0, 0 --ball
	cdx,cdy = 1,1 -- ball delta
	dx,dy = 0,0 -- player delta
	r,g,b = 0,0,1
	height = 400
	width = 600
	dr,dg,db = 1,1,1
	score = 0
	speedup = 1

	love.window.setMode(width, height, {resizable=true, 
										vsync=0, 
										minwidth=400, 
										minheight=300})
	love.window.setTitle('LOVE PONG')

end

function colorChange()
	r = math.random()
	g = math.random()
	b = math.random()
	br = math.random()
	bg = math.random()
	bb = math.random()
end

function playerLost()
	score = score + 1
	cx, cy = width/2, height/2
end

function speedBall() -- increases ball speed over time
	speedup = speedup + 0.001
end


function love.update(dt)

	x = x + dx
	y = y + dy

	if y > (height - 100) then
		dy = 0
	elseif y < 0 then
		dy = 0
	end

	cx = cx + (cdx * speedup)
	cy = cy + (cdy * speedup)

	if cy > oy then
		oy = oy + 1
	elseif cy < oy then
		oy = oy -1
	end

	if cx > width then
		cdx = -1
		colorChange()
		speedBall()
	elseif cx < 20 then
		if y < cy and (y+100) > cy then
			cdx = 1
		else
			playerLost()
		end
		colorChange()
		speedBall()
	elseif cy > height then
		cdy = - 1
		colorChange()
		speedBall()
	elseif cy < 0 then
		cdy = 1
		colorChange()
		speedBall()
	end

	function love.keypressed(key, scancode, isrepeat)

		if scancode == 'w' and y > 0 then
			dy = -1.5
			dr = math.random()
		elseif scancode == 's' and y < height - 100 then
			dy = 1.5
			dg = math.random()
		elseif scancode == 'r' then
			dy,dx = 0,0
			r = math.random()
			g = math.random()
			b = math.random()
			--width, height = love.window.getDimensions( )
		end
	end
end

function love.draw()
	love.graphics.setBackgroundColor(dr,dg,db,1) --background collor

	love.graphics.setColor(r,g,b)  -- Draw player paddle
	love.graphics.rectangle("fill",x,y,w,h)

	love.graphics.setColor(r,g,b)  -- Draw computer paddle
	love.graphics.rectangle("fill",ox,oy,w,h)

	love.graphics.setColor(r,g,b) -- Draw ball
	love.graphics.circle('fill',cx,cy,15,15)

	love.graphics.setColor(1,0,1) --Draw score
	love.graphics.print(score, width/2, 10)
end


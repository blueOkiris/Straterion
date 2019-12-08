module Player where

import State(GameState(..), Sprite(..), GameObject(..))

-- Move the player around and stuff
playerUpdate :: GameState -> GameObject -> GameObject
playerUpdate state player =
    player  { objPosition = (xp, yp)
            , dir =         direction
            , spriteIndex = sprInd }
    where
        (x, y) = objPosition player
        (vx, vy) = velocity player
        dt = deltaTime state
        
        xp = x + vx * dt
        yp = y + vy * dt

        direction =
            if vx > 0 then
                0
            else if vx < 0 then
                1
            else
                dir player
        
        sprInd = 
            if (abs vx) == 0 && (abs vy) == 0 then
                if direction == 0 then
                    sprStickPIdleR state
                else
                    sprStickPIdleL state
            else
                if direction == 0 then
                    sprStickPWalkR state
                else
                    sprStickPWalkL state

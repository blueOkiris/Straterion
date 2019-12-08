module Input where

import Graphics.Gloss.Interface.Pure.Game(Event(..), SpecialKey(..), KeyState(..), Key(..))

import State(GameState(..), GameObject(..))

-- Here we have a list of event handlers
-- This includes (and is primarily used for) all forms of Input
handler :: Event -> GameState -> GameState

-- Key down
handler (EventKey key Down _ _) state =
    if key == Char 'a' || key == SpecialKey KeyLeft then
        state { player = playerWLeftVel }
    else if key == Char 'd' || key == SpecialKey KeyRight then
        state { player = playerWRightVel }
    else if key == Char 'w' || key == SpecialKey KeyUp then
        state { player = playerWUpVel }
    else if key == Char 's' || key == SpecialKey KeyDown then
        state { player = playerWDownVel }
    else
        state
    where
        plyr = player state
        (playerVx, playerVy) = velocity plyr
        moveSpd = playerMoveSpd state

        playerWLeftVel = plyr { velocity = (-moveSpd, playerVy) }
        playerWRightVel = plyr { velocity = (moveSpd, playerVy) }
        playerWUpVel = plyr { velocity = (playerVx, -moveSpd) }
        playerWDownVel = plyr { velocity = (playerVx, moveSpd) }

-- Key up
handler (EventKey key Up _ _) state =
    if (key == Char 'a' || key == SpecialKey KeyLeft) 
            || (key == Char 'd' || key == SpecialKey KeyRight) then
        state { player = playerUnMoveHor }
    else if (key == Char 'w' || key == SpecialKey KeyUp)
            || (key == Char 's' || key == SpecialKey KeyDown) then
        state { player = playerUnMoveVert }
    else
        state
    where
        plyr = player state
        (playerVx, playerVy) = velocity plyr
        moveSpd = playerMoveSpd state

        playerUnMoveHor = plyr { velocity = (0, playerVy) }
        playerUnMoveVert = plyr { velocity = (playerVx, 0) }

-- Handle other events
handler _ state =
    state
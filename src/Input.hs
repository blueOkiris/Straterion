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
    else
        state
    where
        plyr = player state
        (playerVx, playerVy) = velocity plyr
        moveSpd = playerMoveSpd state

        playerWLeftVel = plyr { velocity = (-moveSpd, playerVy) }
        playerWRightVel = plyr { velocity = (moveSpd, playerVy) }

-- Key up
handler (EventKey key Up _ _) state =
    if (key == Char 'a' || key == SpecialKey KeyLeft) 
            || (key == Char 'd' || key == SpecialKey KeyRight) then
        state { player = playerUnMoveHor }
    else
        state
    where
        plyr = player state
        (playerVx, playerVy) = velocity plyr
        moveSpd = playerMoveSpd state

        playerUnMoveHor = plyr { velocity = (0, playerVy) }

-- Handle other events
handler _ state =
    state
module Input where

import Graphics.Gloss.Interface.Pure.Game(Event)

import State(GameState(..))

-- Here we have a list of event handlers
-- This includes (and is primarily used for) all forms of Input
handler :: Event -> GameState -> GameState
handler _ state =
    state
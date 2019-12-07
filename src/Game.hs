module Game where

import Graphics.Gloss.Interface.Pure.Game(play, Event)
import Graphics.Gloss(Picture, circleSolid, red, color)

import State(GameWindow(..), GameState(..))
import Globals(startState)

render :: GameState -> Picture
render state =
    color red (circleSolid 10)

update :: Float -> GameState -> GameState
update deltaTime state =
    state

handler :: Event -> GameState -> GameState
handler _ state =
    state

startGame :: IO()
startGame =
    play disp bg numframes startState render handler update
    where
        disp =      display (window startState)
        bg =        bgColor (window startState)
        numframes = fps     (window startState)
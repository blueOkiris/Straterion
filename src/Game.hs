module Game where

import Graphics.Gloss.Interface.Pure.Game(play, Event)
import Graphics.Gloss   ( Picture(..), pictures, circleSolid, translate
                        , red, color )
import Graphics.Gloss.Data.ViewPort

import State(GameWindow(..), GameState(..), Sprite(..), GameObject(..), drawSprite, drawGameObject)
import Globals(startState)
import Input(handler)

-- Adjust viewport to follow the player
scrollToPlayer :: Picture -> GameState -> Picture
scrollToPlayer img state =
    applyViewPortToPicture newViewPort img
    where
        (px, py) = objPosition $ player state

        newViewPort = viewPortInit  { viewPortTranslate =   (-px, py) }

-- Draw everything important on screen
-- Will eventually "iterate" through a list of GameObjects and draw their sprites
-- Will be something like "map (drawGameObject state) gameObjectList"
render :: GameState -> Picture
render state =
    -- Test basic drawing and changed viewport/coordinate system
    scrollToPlayer (pictures    [ Blank -- This is just here so when I'm testing and there's not much stuff, I can keep the formatting the same
                                        -- Player should be drawn last, so I have to redo the formatting everytime I remove test objects
                                , drawGameObject state $ player state ]) state
    where
        (px, py) = objPosition $ player state

-- This updates all the moving objects in the system
-- It also increases animCounter which allows render to display the correct frame
update :: Float -> GameState -> GameState
update dt state =
    state   { animCounter = increaseCounter
            , player =      playerUpdate (player state)
            , deltaTime =   dt }
    where
        increaseCounter = (animCounter state) + dt
        playerUpdate = (updateObject (player state)) state

-- This initalizes the "play" command
-- play is of type :: Display -> Color -> Int -> T -> (T -> Picture) -> (Event -> T -> T) -> (Float -> T -> T)
-- In our case the 'T' is GameState
-- Each of these corresponds to (in order):
--  * physically drawn window data,
--  * window background color
--  * fps
--  * render function
--  * event handler
--  * update function
startGame :: IO()
startGame =
    play disp bg numframes startState render handler update
    where
        disp =      display $ window startState
        bg =        bgColor $ window startState
        numframes = fps     $ window startState
module Game where

import Graphics.Gloss.Interface.Pure.Game(play, Event)
import Graphics.Gloss   ( Picture, pictures, circleSolid, translate
                        , red, color )
import Graphics.Gloss.Data.ViewPort

import State(GameWindow(..), GameState(..), Sprite(..), drawSprite)
import Globals(startState)

-- Draw everything important on screen
-- Will eventually "iterate" through a list of GameObjects and draw their sprites
-- Will be something like "map (drawGameObject state) gameObjectList"
render :: GameState -> Picture
render state =
    -- Test basic drawing and changed viewport/coordinate system
    pictures    [ color red (circleSolid 100)
                , translate 100 (-100) (color red (circleSolid 100)) 
                , drawSprite state $ sprCubeManIdle state
                , drawSprite state $ sprCubeManWalk state ]

-- This updates all the moving objects in the system
-- It also increases animCounter which allows render to display the correct frame
update :: Float -> GameState -> GameState
update deltaTime state =
    state { animCounter = increaseCounter }
    where
        increaseCounter = (animCounter state) + deltaTime

-- Here we have a list of event handlers
-- When they get large enough, they'll all probably get moved to a separate file
handler :: Event -> GameState -> GameState
handler _ state =
    state

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
    play disp bg numframes startState renderViewPort handler update
    where
        disp =      display $ window startState
        bg =        bgColor $ window startState
        numframes = fps     $ window startState
        winWidth =  width   $ window startState
        winHeight = height  $ window startState

        -- Shift everything over to get regular electronic coordinate systems
        newViewPort = viewPortInit  { viewPortTranslate =   (-winWidth / 2, winHeight / 2) }
        renderViewPort state =
            applyViewPortToPicture newViewPort (render state)
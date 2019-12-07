module Game where

import Graphics.Gloss.Interface.Pure.Game(play, Event)
import Graphics.Gloss   ( Picture, pictures, circleSolid, translate
                        , red, color )
import Graphics.Gloss.Data.ViewPort

import State(GameWindow(..), GameState(..), Sprite(..), drawSprite)
import Globals(startState)

render :: GameState -> Picture
render state =
    -- Test basic drawing and changed viewport/coordinate system
    pictures    [ color red (circleSolid 100)
                , translate 100 (-100) (color red (circleSolid 100)) 
                , drawSprite state $ sprCubeManIdle state
                , drawSprite state $ sprCubeManWalk state ]

update :: Float -> GameState -> GameState
update deltaTime state =
    state { animCounter = increaseCounter }
    where
        increaseCounter = (animCounter state) + deltaTime

handler :: Event -> GameState -> GameState
handler _ state =
    state

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
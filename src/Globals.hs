module Globals where

import Graphics.Gloss(white, Display(InWindow))

import State(GameWindow(..), GameState(..))

startState :: GameState
startState =
    GameState   { window =
                    GameWindow  { bgColor = white
                                , fps =     60
                                , display = InWindow "Straterion" (1280, 720) (200, 200)
                                , width =   1280
                                , height =  720 } }

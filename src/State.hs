module State where

import Graphics.Gloss(Color, Display)

data GameWindow =
    GameWindow  { bgColor       :: Color
                , fps           :: Int
                , display       :: Display 
                , width         :: Float
                , height        :: Float }

data GameState =
    GameState   { window        :: GameWindow }

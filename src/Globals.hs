module Globals where

import Graphics.Gloss(white, Display(InWindow))

import State(GameWindow(..), GameState(..), Sprite(..), pngToPicture)

startState :: GameState
startState =
    GameState   { window =
                    GameWindow  { bgColor = white
                                , fps =     60
                                , display = InWindow "Straterion" (1280, 720) (200, 200)
                                , width =   1280
                                , height =  720 }
                , animCounter = 0 
                , sprCubeManWalk =
                    Sprite  { images =      [ pngToPicture "images/cube-man/cube-man-walk-0.png"
                                            , pngToPicture "images/cube-man/cube-man-walk-1.png" ]
                            , position =    (200, 200)
                            , imageSpeed =  30 }
                , sprCubeManIdle =
                    Sprite  { images =      [ pngToPicture "images/cube-man/cube-man-idle.png" ]
                            , position =    (800, 200)
                            , imageSpeed =  0 } }

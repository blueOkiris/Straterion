module Globals where

import Graphics.Gloss(white, Display(InWindow), scale)

import Player(playerUpdate)
import State(GameWindow(..), GameState(..), Sprite(..), GameObject(..), pngToPicture)

-- Example gameobject update
-- Moves until past 800 and then jumps back
--playerUpdate :: GameState -> GameObject -> GameObject
--playerUpdate state obj =
--    obj { objPosition = (xp, y) }
--    where
--        (x, y) = objPosition obj
--        xp =
--            if x > 900 then
--                200
--            else
--                x + 16

-- This is the initial state for EVERYTHING
-- window creates the actual running window
-- spr* load from the specified files
-- all the actual "states" of the game set to defaults and everything
startState :: GameState
startState =
    GameState   { window =
                    GameWindow      { bgColor = white
                                    , fps =     60
                                    , display = InWindow "Straterion" (1280, 720) (200, 200)
                                    , width =   1280
                                    , height =  720 }
                , animCounter =     0
                , deltaTime =       0
                --, sprCubeManWalk =  spr_cubemanwalk
                --, sprCubeManIdle =  spr_cubemanidle
                --, sprStickPIdleR =  spr_stickpidler
                --, sprStickPWalkR =  spr_stickpwalkr
                --, sprStickPIdleL =  spr_stickpidlel
                --, sprStickPWalkL =  spr_stickpwalkl
                , sprPlayerIdleR =  spr_playeridler
                , sprPlayerIdleL =  spr_playeridlel
                , sprPlayerWalkR =  spr_playerwalkr
                , sprPlayerWalkL =  spr_playerwalkl
                , playerMoveSpd =   512
                , player =
                    GameObject      { spriteIndex =     spr_playeridler
                                    , objPosition =     (500, 400)
                                    , velocity =        (0, 0)
                                    , dir =             0
                                    , collisionMask =   [(32, 32), (192, 224)]
                                    , updateObject =    playerUpdate } }
    where
        spr_playeridler = Sprite    { images =  [ scale 0.5 0.5 $ pngToPicture "images/player/right/idle-0.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 0 }
        spr_playeridlel = Sprite    { images =  [ scale 0.5 0.5 $ pngToPicture "images/player/left/idle-0.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 0 }
        spr_playerwalkr = Sprite    { images =  [ scale 0.5 0.5 $ pngToPicture "images/player/right/walk-0.png"
                                                , scale 0.5 0.5 $ pngToPicture "images/player/right/walk-1.png"
                                                , scale 0.5 0.5 $ pngToPicture "images/player/right/walk-2.png"
                                                , scale 0.5 0.5 $ pngToPicture "images/player/right/walk-1.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 5 }
        spr_playerwalkl = Sprite    { images =  [ scale 0.5 0.5 $ pngToPicture "images/player/left/walk-0.png"
                                                , scale 0.5 0.5 $ pngToPicture "images/player/left/walk-1.png"
                                                , scale 0.5 0.5 $ pngToPicture "images/player/left/walk-2.png"
                                                , scale 0.5 0.5 $ pngToPicture "images/player/left/walk-1.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 5 }
        --spr_cubemanwalk =   Sprite  { images =      [ pngToPicture "images/cube-man/cube-man-walk-0.png"
        --                            , pngToPicture "images/cube-man/cube-man-walk-1.png" ]
        --                             , position =    (0, 0)
        --                             , imageSpeed =  30 }
        -- spr_cubemanidle =   Sprite  { images =      [ pngToPicture "images/cube-man/cube-man-idle.png" ]
        --                             , position =    (0, 0)
        --                             , imageSpeed =  0 }
        -- spr_stickpidler =   Sprite  { images =      [ pngToPicture "images/player-placeholder/right/idle-0.png"
        --                                             , pngToPicture "images/player-placeholder/right/idle-1.png"
        --                                             , pngToPicture "images/player-placeholder/right/idle-2.png"] 
        --                             , position =    (0, 0)
        --                             , imageSpeed =  10 }
        -- spr_stickpwalkr =   Sprite  { images =      [ pngToPicture "images/player-placeholder/right/walk-0.png"
        --                                             , pngToPicture "images/player-placeholder/right/walk-1.png"
        --                                             , pngToPicture "images/player-placeholder/right/walk-2.png"
        --                                             , pngToPicture "images/player-placeholder/right/walk-3.png"
        --                                             , pngToPicture "images/player-placeholder/right/walk-4.png"
        --                                             , pngToPicture "images/player-placeholder/right/walk-5.png"
        --                                             , pngToPicture "images/player-placeholder/right/walk-6.png" ]
        --                             , position =    (0, 0)
        --                             , imageSpeed =  4 }
        -- spr_stickpidlel =   Sprite  { images =      [ pngToPicture "images/player-placeholder/left/idle-0.png"
        --                                             , pngToPicture "images/player-placeholder/left/idle-1.png"
        --                                             , pngToPicture "images/player-placeholder/left/idle-2.png"] 
        --                             , position =    (0, 0)
        --                             , imageSpeed =  10 }
        -- spr_stickpwalkl =   Sprite  { images =      [ pngToPicture "images/player-placeholder/left/walk-0.png"
        --                                             , pngToPicture "images/player-placeholder/left/walk-1.png"
        --                                             , pngToPicture "images/player-placeholder/left/walk-2.png"
        --                                             , pngToPicture "images/player-placeholder/left/walk-3.png"
        --                                             , pngToPicture "images/player-placeholder/left/walk-4.png"
        --                                             , pngToPicture "images/player-placeholder/left/walk-5.png"
        --                                             , pngToPicture "images/player-placeholder/left/walk-6.png" ]
        --                             , position =    (0, 0)
        --                             , imageSpeed =  4 }

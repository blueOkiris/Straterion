module Globals where

import Graphics.Gloss(white, Display(InWindow), scale)

import Player(playerUpdate)
import State(GameWindow(..), GameState(..), Sprite(..), GameObject(..), pngToPicture)

-- Size of tiles in the world
tileSize :: Int
tileSize = 96

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
        playerSpriteSize = 256
        playerScale = (fromIntegral tileSize) / playerSpriteSize
        spr_playeridler = Sprite    { images =  [ scale playerScale playerScale $ pngToPicture "images/player/right/idle-0.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 0 }
        spr_playeridlel = Sprite    { images =  [ scale playerScale playerScale $ pngToPicture "images/player/left/idle-0.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 0 }
        spr_playerwalkr = Sprite    { images =  [ scale playerScale playerScale $ pngToPicture "images/player/right/walk-0.png"
                                                , scale playerScale playerScale $ pngToPicture "images/player/right/walk-1.png"
                                                , scale playerScale playerScale $ pngToPicture "images/player/right/walk-2.png"
                                                , scale playerScale playerScale $ pngToPicture "images/player/right/walk-1.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 5 }
        spr_playerwalkl = Sprite    { images =  [ scale playerScale playerScale $ pngToPicture "images/player/left/walk-0.png"
                                                , scale playerScale playerScale $ pngToPicture "images/player/left/walk-1.png"
                                                , scale playerScale playerScale $ pngToPicture "images/player/left/walk-2.png"
                                                , scale playerScale playerScale $ pngToPicture "images/player/left/walk-1.png" ]
                                    , position = (0, 0)
                                    , imageSpeed = 5 }
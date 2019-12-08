module State where

import Graphics.Gloss(Color, Display, Picture, translate, text)
import Graphics.Gloss.Juicy(loadJuicyPNG)
import System.IO.Unsafe(unsafePerformIO)

import Debug.Trace

-- Window and basic system function data
data GameWindow =
    GameWindow  { bgColor           :: Color
                , fps               :: Int
                , display           :: Display 
                , width             :: Float
                , height            :: Float }

-- A drawable image
data Sprite =
    Sprite      { images            :: [Picture]
                , position          :: (Float, Float)
                , imageSpeed        :: Float }

-- A game object that uses a specific sprite, but can interact with stuff
data GameObject =
    GameObject  { spriteIndex       :: Sprite
                , objPosition       :: (Float, Float)
                , velocity          :: (Float, Float)
                , dir               :: Int
                , collisionMask     :: [(Float, Float)] 
                , updateObject      :: GameState -> GameObject -> GameObject }

-- Overall state of the game
-- Includes sprites, gameobjects, window, actual state (like map/dialog/battle), etc
data GameState =
    GameState   { window            :: GameWindow
                , animCounter       :: Float
                , deltaTime         :: Float
                , sprCubeManWalk    :: Sprite 
                , sprCubeManIdle    :: Sprite
                , sprStickPIdleR    :: Sprite
                , sprStickPWalkR    :: Sprite 
                , sprStickPIdleL    :: Sprite
                , sprStickPWalkL    :: Sprite
                , playerMoveSpd     :: Float
                , player            :: GameObject }

-- Functions for dealing with sprite drawing
imageIndex :: GameState -> Sprite -> Int            -- Get the current frame of the image based on animation speed, time passed, and fps
imageIndex state spr =
    index
    --trace ("Seconds: " ++ (show $ animCounter state) ++ ", Frames: " ++ (show frames) ++ ", Spd: " ++ (show spd) ++ ", ImgCount: " ++ (show imgCount) ++ ", Index: " ++ (show index)) index
    where
        frames =  (fromIntegral $ fps $ window state) * (animCounter state)
        spd = imageSpeed spr
        imgCount = length $ images spr
        index = (round (frames / spd)) `mod` imgCount
drawSprite :: GameState -> Sprite -> Picture        -- Draw the current animation frame at the correct (x, y) position
drawSprite state spr =                              -- Makes sure to invert the y as the viewport is upside-down
    translate (fst $ position spr) (-(snd $ position spr)) ((images spr) !! (imageIndex state spr))
pngToPicture :: FilePath -> Picture
pngToPicture fname =
    maybe (text "PNG ERROR") id (unsafePerformIO $ loadJuicyPNG fname)

-- Functions for drawing the sprite of a game object
drawGameObject :: GameState -> GameObject -> Picture
drawGameObject state obj =
    drawSprite state ((spriteIndex obj) { position = objPos })
    where
        objPos = objPosition obj
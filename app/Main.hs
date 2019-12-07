module Main where

import Game(startGame)

main :: IO ()
main =
    do
        putStrLn "Hello, world!"
        startGame

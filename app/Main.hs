module Main where

import Network.Wai.Handler.Warp (runSettings, setPort, setLogger, defaultSettings)
import Network.Wai.Logger (withStdoutLogger)

import Server

main :: IO ()
main = withStdoutLogger $ \logger ->
    runSettings (setPort 8080 $ setLogger logger $ defaultSettings) $ lyricist

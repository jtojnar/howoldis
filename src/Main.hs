{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}

import Web.Scotty

import Control.Monad.Trans (liftIO)
import System.Environment (getEnvironment)
import Text.Hamlet (shamletFile)
import Text.Blaze.Html.Renderer.Text (renderHtml)

import Channels (Channel (..), channels, jobset, label, humantime, commit)


main :: IO ()
main = do
  env <- getEnvironment
  let port = maybe 3000 read $ lookup "PORT" env
  scotty port $ do
    get "/" $ do
      allChannels <- liftIO channels
      html $ renderHtml $(shamletFile "src/index.hamlet")
    get "/api/channels" $ do
      allChannels <- liftIO channels
      json allChannels

module AZLyrics where

import Prelude hiding (filter)

import Data.Char (isAlphaNum)
import Data.Maybe (fromMaybe)
import Data.String.Conversions (cs)
import Data.Text (Text, filter, stripPrefix, toLower)
import Network.HTTP.Conduit
import Text.HTML.DOM (parseLBS)
import Text.XML.Cursor (fromDocument)
import Text.XML.Scraping (innerText)
import Text.XML.Selector

import Lyrics

getLyrics :: Title -> Artist -> IO Lyrics
getLyrics title artist = do
  res <- simpleHttp $ lyricsURL
  let root = fromDocument . parseLBS $ res
  let songDiv = query lyricsSelector root
  pure $ Lyrics title artist $ cs $ innerText songDiv
  where
    lyricsSelector = "body > div.container.main-page > div > div.col-xs-12.col-lg-8.text-center > div:nth-child(8)"
    lyricsURL = azlyricsURL title artist

azlyricsURL :: Title -> Artist -> String
azlyricsURL title artist = cs $ "https://www.azlyrics.com/lyrics/"
                         <> artist' <> "/"
                         <> title' <> ".html"
  where
    artist' = stripPrefixThe . limitToAlphaNum . toLower $ artist
    title' = limitToAlphaNum . toLower $ title
    stripPrefixThe ar = fromMaybe ar (stripPrefix ar "the")
    limitToAlphaNum = filter isAlphaNum

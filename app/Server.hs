module Server where

import Control.Monad.Except
import Data.Text (Text)
import Servant

import AZLyrics
import Lyrics

type LyricsAPI = "lyrics"
                  :> QueryParam "artist" Artist
                  :> QueryParam "title" Title
                  :> Get '[JSON] Lyrics

lyricistServer :: Server LyricsAPI
lyricistServer = lyrics
  where lyrics :: Maybe Artist -> Maybe Title -> Handler Lyrics
        lyrics mArtist mTitle =
          case (mArtist, mTitle) of
            (Just ar, Just ti) -> getLyrics ti ar
            (Nothing, Nothing) -> missingError "Missing artist and title"
            (Nothing, _) -> missingError "Missing artist"
            (_, Nothing) -> missingError "Missing title"
        missingError msg = throwError $ err422 { errBody = msg }

lyricist = serve (Proxy :: Proxy LyricsAPI) lyricistServer

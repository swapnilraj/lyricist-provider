module Lyrics where

import GHC.Generics (Generic)

import Data.Text (Text)
import Data.Aeson.Types (ToJSON)

type Artist = Text
type Title = Text

data Lyrics = Lyrics
              { title :: Title
              , artist :: Artist
              , lyrics :: Text
              }
  deriving (Generic, ToJSON)

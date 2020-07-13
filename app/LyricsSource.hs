{-# LANGUAGE MultiParamTypeClasses #-}
module LyricsSource where

import Lyrics

class LyricsSource a where
  getLyrics :: Artist -> Title -> Lyrics

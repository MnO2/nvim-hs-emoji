{-# LANGUAGE TemplateHaskell #-}
module Fibonacci (plugin) where

import Neovim
import Fibonacci.Plugin (fibonacci, emojicomplete)

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin Plugin
    { exports         = [ $(function "Fibonacci" 'fibonacci) Sync
                        , $(function "EmojiComplete" 'emojicomplete) Sync
                        ]
    , statefulExports = []
    }

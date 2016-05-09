import Neovim

import qualified Fibonacci as Fibonacci

main :: IO ()
main = neovim defaultConfig
  { plugins = plugins defaultConfig ++ [ Fibonacci.plugin ] 
  }

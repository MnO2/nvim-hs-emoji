#!/bin/sh

sandbox_directory=/Users/mno2/Develop/haskell/nvim-hs-emoji

old_pwd="`pwd`"
cd "$sandbox_directory"

if [ -d "$sandbox_directory/.cabal-sandbox" ] ; then
    # We detect the sandbox by checking for the directory .cabal-sandbox
    # This should work most of the time.
    env CABAL_SANDBOX_CONFIG="$sandbox_directory"/cabal.sandbox.config cabal \
        exec "$sandbox_directory/.cabal-sandbox/bin/nvim-hs-emoji-exe" -- "$@"
elif [ -d "$sandbox_directory/.stack-work" ] ; then
    # Stack leaves behind a .stack-work directory, so we take its present as a
    # sign to use this approach.
    PATH=`stack path --bin-path` stack exec nvim-hs-emoji-exe -- "$@"
else
    echo "No development directories found. Have you built the project?"
    exit 2
fi
cd "$old_pwd"

# vim: foldmethod=marker sts=2 ts=4 expandtab sw=4

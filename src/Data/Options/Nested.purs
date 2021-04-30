-- | Utilities for nesting `Options`.
module Data.Options.Nested
  ( OptionN
  , optN
  , optionsToOptions
  )
  where

import Prelude

import Data.Op (Op(..))
import Data.Options (Option, Options(..), options)
import Data.Tuple (Tuple(..))


type OptionN :: forall k l. k -> l -> Type
type OptionN o i = Option o (Options i)


-- | Creates an `Option` that takes `Options` for its value.
optN :: forall o i. String -> OptionN o i
optN = Op <<< optionsToOptions


-- | Turns `Options i` into `Foreign`, yielding `Options o`.
optionsToOptions :: forall i o. String -> Options i -> Options o
optionsToOptions k v = Options [Tuple k (options v)]

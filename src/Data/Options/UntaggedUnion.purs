-- | Utilities for `untagged-union`.
module Data.Options.UntaggedUnion
  ( optU
  )
  where

import Prelude

import Data.Op (Op(..))
import Data.Options (Option, defaultToOptions)
import Type.Proxy (Proxy)
import Untagged.Union (class InOneOf, OneOf, asOneOf)


-- | Creates an `Option o` that takes any type `v` that can be
-- | coerced using `InOneOf`.
-- |
-- | The `h` and `t` type parameters must be provided through
-- | a proxied `OneOf` type.
optU
  :: forall o v h t
   . InOneOf v h t
  => Proxy (OneOf h t)
  -> String
  -> Option o v
optU _ = Op <<< untaggedToOptions
  where
    untaggedToOptions k v = defaultToOptions k (asOneOf v :: OneOf h t)

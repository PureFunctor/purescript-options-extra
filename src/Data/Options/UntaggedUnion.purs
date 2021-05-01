-- | Utilities for `untagged-union`.
module Data.Options.UntaggedUnion
  ( optU
  , untaggedToOptions
  )
  where

import Prelude

import Data.Op (Op(..))
import Data.Options (Option, Options, defaultToOptions)
import Type.Proxy (Proxy)
import Untagged.Union (class InOneOf, OneOf, asOneOf)


-- | Creates an option over a type `v` that can be coerced
-- | using `InOneOf`.
-- |
-- | The `h` and `t` type parameters are provided through a
-- | proxied `OneOf` type.
optU
  :: forall o v h t
   . InOneOf v h t
  => Proxy (OneOf h t)
  -> String
  -> Option o v
optU p = Op <<< untaggedToOptions p


-- | Builds an `Options o` from a `v` that can be coerced
-- | using `InOneOf`.
-- |
-- | Similar to `optU`, the `h` and `t` type parameters
-- | are provided through a proxied `OneOf` type.
untaggedToOptions
  :: forall o v h t
   . InOneOf v h t
  => Proxy (OneOf h t)
  -> String
  -> v
  -> Options o
untaggedToOptions _ k v = defaultToOptions k (asOneOf v :: OneOf h t)

module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Nested as Nested
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)
import Test.UntaggedUnion as UntaggedUnion


main :: Effect Unit
main = launchAff_ $ runSpec [ consoleReporter ] do
  Nested.spec
  UntaggedUnion.spec

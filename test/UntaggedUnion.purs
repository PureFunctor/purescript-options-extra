module Test.UntaggedUnion where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Options (Option, options, (:=))
import Data.Options.UntaggedUnion (optU)
import Foreign.Object as Object
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Type.Equality (class TypeEquals)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Union (class InOneOf, type (|+|))


data Untagged

type Triple = String |+| Number |+| Int


triple
  :: forall v h t
     -- | Pattern match `Triple` into `h` and `t`.
   . TypeEquals Triple (h |+| t)
     -- | Assert that `v` can be either `h` or `t`.
  => InOneOf v h t
  => Option Untagged v
triple =
  -- | Pass `h` and `t` to solve `optU`.
  optU (Proxy :: _ (h |+| t)) "triple"


spec :: Spec Unit
spec = do
  describe "UntaggedUnion" do
    it "should coerce items" do
      let s = unsafeCoerce $ options $ triple := "42"
          n = unsafeCoerce $ options $ triple := 42.0
          i = unsafeCoerce $ options $ triple := 4200
      Object.lookup "triple" s `shouldEqual` Just "42"
      Object.lookup "triple" n `shouldEqual` Just 42.0
      Object.lookup "triple" i `shouldEqual` Just 4200

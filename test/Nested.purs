module Test.Nested where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Options (Option, opt, options, (:=))
import Data.Options.Nested (OptionN, optN)
import Foreign.Object as Object
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Unsafe.Coerce (unsafeCoerce)


data TopLevel

data Triple


group :: OptionN TopLevel Triple
group = optN "group"


atom :: Option TopLevel Char
atom = opt "atom"


foo :: Option Triple String
foo = opt "foo"


bar :: Option Triple Int
bar = opt "bar"


baz :: Option Triple Number
baz = opt "baz"


spec :: Spec Unit
spec = do
  let
    opt = unsafeCoerce $ options $
      group := ( foo := "foo" <>
                 bar := 42000 <>
                 baz := 420.0 ) <>
      atom := 'e'

  describe "Nested" do
    it "should contain top-level items" do
      Object.member "group" opt `shouldEqual` true
      Object.member "atom" opt `shouldEqual` true
    it "should contain inner items" do
      let search n = Object.member n <$> Object.lookup "group" opt
      search "foo" `shouldEqual` Just true
      search "bar" `shouldEqual` Just true
      search "baz" `shouldEqual` Just true

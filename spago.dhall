{ name = "options-extra"
, dependencies =
  [ "contravariant"
  , "options"
  , "prelude"
  , "tuples"
  , "untagged-union"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, license = "BSD-3-Clause"
, repository = "https://github.com/PureFunctor/purescript-options-extra.git"
}

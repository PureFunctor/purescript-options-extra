let conf = ./spago.dhall

in      conf
    //  { dependencies =
              conf.dependencies
            # [ "aff"
              , "effect"
              , "foreign-object"
              , "maybe"
              , "spec"
              , "type-equality"
              , "unsafe-coerce"
              ]
        , sources = conf.sources # [ "test/**/*.purs" ]
        }

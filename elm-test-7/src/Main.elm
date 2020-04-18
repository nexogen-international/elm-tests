module Main exposing (main)

import App exposing (Flags, Model, Msg, init, subscriptions, update, view)
import Browser


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

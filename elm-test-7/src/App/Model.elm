module App.Model exposing (Flags, Model, init)

import App.Messages exposing (Msg(..))
import App.Animal.Model

type alias Model =
    { score : Int
    , items : App.Animal.Model.Model
    }


{-| We can use abstract type if it is constructed with Elm's primitive values.
-}
type alias Flags =
    { seed : Int
    , dev : Bool
    }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( Model 0 [], Cmd.none )

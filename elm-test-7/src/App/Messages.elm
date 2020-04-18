module App.Messages exposing (Msg(..))

import App.Animal.Messages


type Msg
    = Reset
    | Roll
    | AnimalMsg App.Animal.Messages.Msg

module App.Animal.Update exposing (update)

import App.Animal.Messages exposing (Msg(..))
import App.Animal.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Update newModel ->
            ( newModel, Cmd.none )

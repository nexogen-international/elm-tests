module App.Update exposing (update)

import App.Animal.Messages
import App.Animal.Update
import App.Messages exposing (Msg(..))
import App.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimalMsg animalMsg ->
            let
                ( animalModel, animalCmd ) =
                    App.Animal.Update.update animalMsg model.items
            in
            ( { model | items = animalModel }
            , Cmd.map AnimalMsg animalCmd
            )

        Reset ->
            ( model
            , Cmd.none
            )

        Roll ->
            ( model
            , Cmd.map AnimalMsg App.Animal.Messages.updateCommand
            )

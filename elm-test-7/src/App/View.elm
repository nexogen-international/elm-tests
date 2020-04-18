module App.View exposing (view)

import App.Animal.View
import App.Messages exposing (Msg(..))
import App.Model exposing (Model)
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Model -> Html Msg
view model =
    div []
        [ model.items |> App.Animal.View.view |> Html.map AnimalMsg
        , a [ class "f6 link dim ba bw1 ph3 pv2 mb2 dib near-black", onClick Roll ] [ text "Roll" ]
        , a [ class "f6 link dim ba bw1 ph3 pv2 mb2 dib near-black", onClick Reset ] [ text "Reset" ]
        ]

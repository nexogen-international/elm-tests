module Main exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }


type Msg
    = Change String


type alias Model =
    { content : String
    , dummy : String
    }


init : Model
init =
    { content = ""
    , dummy = ""
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        ]

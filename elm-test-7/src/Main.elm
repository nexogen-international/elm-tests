module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Events exposing (onClick)
import Random



-- Main


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { diceFace : Int
    }


type Msg
    = RollDice
    | NewDiceFace Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( { diceFace = 1 }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (String.fromInt model.diceFace) ]
        , button [ onClick RollDice ] [ text "Roll" ]
        ]



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RollDice ->
            ( model, Random.generate NewDiceFace rollDice )

        NewDiceFace diceFace ->
            ( { model | diceFace = diceFace }, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- Random


rollDice : Random.Generator Int
rollDice =
    Random.int 1 6

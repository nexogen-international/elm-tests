module Main exposing (main)

import Browser
import Html exposing (Html, pre, text)
import Http



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


type Model
    = Failure
    | Loading
    | Success String


httpGetString : (Result Http.Error String -> msg) -> String -> Cmd msg
httpGetString msg url =
    Http.get
        { url = url
        , expect = Http.expectString msg
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , httpGetString GotText "https://elm-lang.org/assets/public-opinion.txt"
    )



-- Update


type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )


-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- View


view : Model -> Html Msg
view model =
    case model of
        Failure ->
            text "I was unable to load your book."

        Loading ->
            text "Loading..."

        Success fullText ->
            pre [] [ text fullText ]

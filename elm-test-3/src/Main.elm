module Main exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (placeholder, style, type_, value)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type Msg
    = Name String
    | Password String
    | PasswordAgain String


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    { name = ""
    , password = ""
    , passwordAgain = ""
    }


updateName : String -> Model -> Model
updateName name model =
    { model | name = name }


updatePassword : String -> Model -> Model
updatePassword password model =
    { model | password = password }


updatePasswordAgain : String -> Model -> Model
updatePasswordAgain passwordAgain model =
    { model | passwordAgain = passwordAgain }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            updateName name model

        Password password ->
            updatePassword password model

        PasswordAgain passwordAgain ->
            updatePasswordAgain passwordAgain model


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if model.password == model.passwordAgain then
        div [ style "color" "green" ] [ text "OK" ]

    else
        div [ style "color" "red" ] [ text "Passwords do not match!" ]


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]

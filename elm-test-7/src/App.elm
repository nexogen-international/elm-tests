module App exposing (Flags, Model, Msg(..), init, subscriptions, update, view)

import Animals
import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- Model


type alias Model =
    { score : Int
    , items : Animals.Model
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



-- Messages


type Msg
    = Reset
    | Roll
    | AnimalMsg Animals.Msg



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimalMsg animalMsg ->
            updateAnimals animalMsg model

        Reset ->
            resetAnimals model

        Roll ->
            rollAnimals model


resetAnimals : Model -> (Model, Cmd Msg)
resetAnimals =
    updateAnimals Animals.Reset


rollAnimals : Model -> (Model, Cmd Msg)
rollAnimals =
    updateAnimals Animals.Roll


updateAnimals : Animals.Msg -> Model -> ( Model, Cmd Msg )
updateAnimals msg model =
    let
        ( animalModel, animalCmd ) =
            Animals.update msg model.items
    in
    ( { model | items = animalModel }
    , Cmd.map AnimalMsg animalCmd
      -- we can batch a Cmd if we want to have other effects on App
    )



-- View


view : Model -> Html Msg
view model =
    div []
        [ model.items |> Animals.view |> Html.map AnimalMsg
        , a [ class "f6 link dim ba bw1 ph3 pv2 mb2 dib near-black", onClick Roll ] [ text "Roll" ]
        , a [ class "f6 link dim ba bw1 ph3 pv2 mb2 dib near-black", onClick Reset ] [ text "Reset" ]
        ]

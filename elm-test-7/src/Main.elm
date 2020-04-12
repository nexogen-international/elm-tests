module Main exposing (main)

import Browser
import Html exposing (Html, a, article, div, h1, hr, img, p, text)
import Html.Attributes exposing (class, src, title)
import Html.Events exposing (onClick)
import Random



-- Main


main : Program () (Model Animal) (Msg Animal)
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type Animal
    = Raccoon
    | Dog
    | Cat
    | Camel
    | Rabbit
    | Monkey


type alias Model a =
    { score : Int
    , items : List a
    }


type Msg a
    = NewItems (List a)
    | Reset
    | Roll


init : () -> ( Model Animal, Cmd (Msg Animal) )
init _ =
    ( Model 0 [], Cmd.none )



-- View


view : Model Animal -> Html (Msg Animal)
view model =
    div []
        [ model.items |> viewColumnLayout viewAnimal
        , a [ class "f6 link dim ba bw1 ph3 pv2 mb2 dib near-black", onClick Roll ] [ text "Roll" ]
        , a [ class "f6 link dim ba bw1 ph3 pv2 mb2 dib near-black", onClick Reset ] [ text "Reset" ]
        ]


viewColumnItem : Html msg -> Html msg
viewColumnItem item =
    div [ class "fl w-25 tc pv5 bg-black-05" ] [ item ]


viewColumnLayout : (a -> Html msg) -> List a -> Html msg
viewColumnLayout viewItem items =
    div [ class "cf" ] (items |> List.map viewItem |> List.map viewColumnItem)


viewAnimal : Animal -> Html (Msg Animal)
viewAnimal animal =
    viewCard <| animalToName animal


viewCard : String -> Html (Msg Animal)
viewCard name =
    article [class "mw5 center bg-white br3 pa3 pa4-ns mv3 ba b--black-10"]
    [ div [ class "tc"]
      [ img [ src (String.concat [ "img/", String.toLower name, ".svg" ])
            , class "br-100 h3 w3 dib"
            , title name
            ] []
      , h1 [ class "f4" ] [ text name ]
      , hr [ class "mw3 bb bw1 b--black-10" ] []
      ]
    , p [ class "lh-copy measure center f6 black-70" ] [ text "" ]
    ]


-- Update


update : Msg Animal -> Model Animal -> ( Model Animal, Cmd (Msg Animal) )
update msg model =
    case msg of
        NewItems items ->
            ( { model | items = items }, Cmd.none )

        Reset ->
            ( Model 0 [], Cmd.none )

        Roll ->
            ( model, Random.generate NewItems (toListGenerator animalGenerator) )



-- Subscriptions


subscriptions : Model Animal -> Sub (Msg Animal)
subscriptions _ =
    Sub.none


-- Helpers


toList : a -> a -> a -> a -> List a
toList a b c d =
    [ a, b, c, d ]


-- Random


toListGenerator : Random.Generator a -> Random.Generator (List a)
toListGenerator generator =
    Random.map4 toList generator generator generator generator


animalGenerator : Random.Generator Animal
animalGenerator =
    Random.uniform Raccoon [ Dog, Cat, Camel, Rabbit, Monkey ]


-- Converters


animalToName : Animal -> String
animalToName animal =
    case animal of
        Raccoon ->
            "Raccoon"

        Dog ->
            "Dog"

        Cat ->
            "Cat"

        Camel ->
            "Camel"

        Rabbit ->
            "Rabbit"

        Monkey ->
            "Monkey"

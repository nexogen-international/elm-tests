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
    ( Model 0 [], newAnimalsCommand )



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
    div [ class "fl w-25 tc pv5" ] [ item ]


viewColumnLayout : (a -> Html msg) -> List a -> Html msg
viewColumnLayout viewItem items =
    div [ class "cf h-25" ] (items |> List.map viewItem |> List.map viewColumnItem)


viewAnimal : Animal -> Html (Msg Animal)
viewAnimal animal =
    (viewCard <| animalToName animal) <| animalToDescription animal


viewCard : String -> String -> Html (Msg Animal)
viewCard name description =
    article [ class "mw5 center bg-white br3 pa3 pa4-ns mv3 ba b--black-10" ]
        [ div [ class "tc" ]
            [ img
                [ src (String.concat [ "assets/images/", String.toLower name, ".svg" ])
                , class "br-100 h3 w3 dib"
                , title name
                ]
                []
            , h1 [ class "f4" ] [ text name ]
            , hr [ class "mw3 bb bw1 b--black-10" ] []
            ]
        , p [ class "lh-copy measure center f6 black-70" ] [ text description ]
        ]



-- Update


newAnimalsCommand : Cmd (Msg Animal)
newAnimalsCommand =
    Random.generate NewItems (toListGenerator animalGenerator)


update : Msg Animal -> Model Animal -> ( Model Animal, Cmd (Msg Animal) )
update msg model =
    case msg of
        NewItems items ->
            ( { model | items = items }, Cmd.none )

        Reset ->
            ( Model 0 [], Cmd.none )

        Roll ->
            ( model, newAnimalsCommand )



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


animalToDescription : Animal -> String
animalToDescription animal =
    case animal of
        Raccoon ->
            "The raccoon, sometimes spelled racoon, also known as the common raccoon, North American raccoon, northern raccoon, or coon, is a medium-sized mammal native to North America."

        Dog ->
            "The dog is a member of the genus Canis, which forms part of the wolf-like canids, and is the most widely abundant terrestrial carnivore."

        Cat ->
            "The cat is a domestic species of small carnivorous mammal. It is the only domesticated species in the family Felidae and is often referred to as the domestic cat to distinguish it from the wild members of the family."

        Camel ->
            "A camel is an even-toed ungulate in the genus Camelus that bears distinctive fatty deposits known as \"humps\" on its back."

        Rabbit ->
            "Rabbits are small mammals in the family Leporidae of the order Lagomorpha. Oryctolagus cuniculus includes the European rabbit species and its descendants, the world's 305 breeds of domestic rabbit."

        Monkey ->
            "Monkey is a common name that may refer to groups or species of mammals, in part, the simians of infraorder Simiiformes. The term is applied descriptively to groups of primates."

module App.Animal.Model exposing (Animal(..), Model)


type Animal
    = Raccoon
    | Dog
    | Cat
    | Camel
    | Rabbit
    | Monkey


type alias Model =
    List Animal

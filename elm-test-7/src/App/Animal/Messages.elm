module App.Animal.Messages exposing (Msg(..), updateCommand)

import App.Animal.Model exposing (Animal(..), Model)
import Random


type Msg
    = NoOp
    | Update Model


updateCommand : Cmd Msg
updateCommand =
    Random.generate Update (toListGenerator animalGenerator)


toList : a -> a -> a -> a -> List a
toList a b c d =
    [ a, b, c, d ]


toListGenerator : Random.Generator a -> Random.Generator (List a)
toListGenerator generator =
    Random.map4 toList generator generator generator generator


animalGenerator : Random.Generator Animal
animalGenerator =
    Random.uniform Raccoon [ Dog, Cat, Camel, Rabbit, Monkey ]

module Utils exposing (toList4, toListGenerator4)

import Random


-- log : Bool -> String -> a -> a
-- log dev label val =
--     if dev == True then
--         Debug.log label val

--     else
--         val


toList4 : a -> a -> a -> a -> List a
toList4 a b c d =
    [ a, b, c, d ]


toListGenerator4 : Random.Generator a -> Random.Generator (List a)
toListGenerator4 generator =
    Random.map4 toList4 generator generator generator generator

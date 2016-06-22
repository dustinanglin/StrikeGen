module PowerUtilities exposing (..)

import Dict exposing (Dict, get)
import Maybe exposing (Maybe)
import FormsModel exposing (..)
import ModelDB exposing (..)
import String

powerDict : Model -> List (Model -> Power) -> Dict String Power
powerDict m l =
  let toTuple p = ((p m).name, p m) in
    Dict.fromList (List.map toTuple l)


powerlookup : Model -> String -> (Model -> Dict String Power) -> List Power
powerlookup m key list = case (getResponse m key) of
  Nothing -> []
  Just choice -> case (get choice (list m)) of
    Nothing -> []
    Just power -> [power]


powerChoiceField m name key list =
  DropdownField { name=name, del=False, key=key, choices=[""] ++ (Dict.keys (list m)) }


quickPower name page slot freq range area damage m =
        {name = name,
         text = overtext (String.filter (\x -> (x /= ' ')) name) ("See page " ++ (toString page) ++ "."),
         slot = slot,
         freq = freq,
         range = range,
         area = area,
         damage = damage
       }

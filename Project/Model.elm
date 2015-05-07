module Project.Model where

import Detail.Model as Detail exposing (Detail)
import Prompt.Model as Prompt exposing (Prompt)
import Dict exposing (Dict)

type alias Project =
    { name : String
    , details : Dict String Detail
    , detailNamePrompt : Maybe Prompt
    }

new : String -> Project
new projectName = 
    { name = projectName
    , details = Dict.empty
    , detailNamePrompt = Nothing
    }

module Project.Update where

import Project.Model exposing (..)
import Detail.Model as DM exposing (Detail)
import Detail.Update as DU
import Prompt.Model as MM exposing (Prompt)
import Prompt.Update as MU
import Dict
import Signal exposing ((<~))

type Action = NewDetail String
            | Remove String
            | DetailAction String DU.Action
            | AllDetailAction DU.Action
            | PromptAction MU.Action
            | ShowModal
            | HideModal
            | NoOp

step : Action -> Project -> Project
step action project = 
    case action of 
        NewDetail detailName -> 
            if | Dict.member detailName project.details -> project
               | otherwise -> { project 
                              | details <- Dict.insert detailName (DM.new detailName) project.details 
                              , detailNamePrompt <- Nothing
                              }
        Remove detailName -> { project | details <- Dict.remove detailName project.details }
        DetailAction detailName action -> { project | details <- Dict.update detailName (Maybe.map <| DU.step action) project.details }
        AllDetailAction action -> { project | details <- Dict.map (always <| DU.step action) project.details }
        PromptAction promptAction -> 
            case project.detailNamePrompt of 
                Nothing -> project
                Just prompt -> { project | detailNamePrompt <- Just <| MU.step promptAction prompt }
        ShowModal -> { project | detailNamePrompt <- Just <| MM.new "New Detail" "Please enter a new detail name" }
        HideModal -> { project | detailNamePrompt <- Nothing }
        NoOp -> project


actionSignal' : Project -> Signal Action
actionSignal' project = Signal.mergeMany <| List.map (\d -> DetailAction d.name <~ DU.actionSignal) (Dict.values project.details)

actionSignal : Signal Action
actionSignal = AllDetailAction <~ DU.actionSignal
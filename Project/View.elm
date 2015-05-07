module Project.View where


import Project.Model exposing (..)
import Project.Update exposing (..)

import Detail.Model as DM exposing (Detail)
import Detail.View as DV

import Prompt.Model as MM exposing (Prompt)
import Prompt.View as MV

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)

import Dict

import Time exposing (..)

type alias Context = 
    { actions : Signal.Address Action
    , currentTime : Time
    }

detailContext : Detail -> Context -> DV.Context
detailContext d context = 
    { actions = Signal.forwardTo context.actions <| DetailAction d.name
    , currentTime = context.currentTime
    , remove = Signal.forwardTo context.actions (always <| Remove d.name)
    }

promptContext : Prompt -> Context -> MV.Context
promptContext prompt context = 
    { actions = Signal.forwardTo context.actions PromptAction
    , cancel = Signal.forwardTo context.actions <| always HideModal
    , submit = Signal.forwardTo context.actions (always <| NewDetail prompt.value)
    }

display : Context -> Project -> Html
display context project = 
    case project.detailNamePrompt of
        Nothing ->
            div 
                [] <|
                [ text project.name
                , button 
                    [ onClick context.actions ShowModal]
                    [ text "Add Detail" ]
                ] ++ Dict.values (Dict.map (\n d -> DV.display (detailContext d context) d) project.details)
        Just prompt ->
            div 
                []
                [ MV.display (promptContext prompt context) prompt ]         
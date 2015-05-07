module Detail.View where

import Detail.Model exposing (..)
import Detail.Update exposing (..)
import Session.View as SV
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)

import Time exposing (..)

type alias Context =
    { actions : Signal.Address Action
    , remove : Signal.Address ()
    , currentTime : Time
    }

display : Context -> Detail -> Html
display context detail = 
    div 
        [] <|
        [ text detail.name
        , totalLength detail
             |> toString
             |> text
        , case detail.currentSession of 
                        Nothing -> button 
                                        [ onClick context.actions <| Start context.currentTime ]
                                        [ text "Start" ]
                        Just _ -> button
                                    [ onClick context.actions Stop ]
                                    [ text "Stop" ]
        , button
            [ onClick context.remove () ]
            [ text "delete" ]
        ] ++ List.map (SV.display <| Signal.forwardTo context.actions SessionAction) detail.pastSessions
module Session.View where

import Session.Model exposing (..)
import Session.Update exposing (..)
import Time exposing (..)
import Date exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Lazy exposing (lazy, lazy2, lazy3)

type alias Context = Signal.Address Action

display : Context -> Session -> Html
display _ s = 
    let startDate = fromTime s.startTime
        endDate = fromTime s.endTime
        showSeconds = inMinutes (s.endTime - s.startTime) < 1 
        showDate = year startDate /= year endDate || month startDate /= month endDate || day startDate /= day endDate
    in div [] [ formatDate startDate showSeconds showDate, text " - ", formatDate endDate showSeconds showDate ]

formatDate : Date -> Bool -> Bool -> Html
formatDate d showSeconds showDate =
    span 
        [] <|
        if showDate then [ text << toString <| dayOfWeek d ] else []
        ++
        [ text << toString <| Date.hour d, text ":", text << toString <| Date.minute d ]
        ++
        if showSeconds then [ text ":", text << toString  <| Date.second d] else []
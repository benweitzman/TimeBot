module Session.Update where

import Session.Model exposing (..)
import Time exposing (..)
import Signal exposing ((<~))

type Action = Tick Time

step : Action -> Session -> Session
step (Tick t) session = { session | endTime <- t }

actionSignal : Signal Action
actionSignal = Tick <~ every second
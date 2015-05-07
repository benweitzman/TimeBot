module Detail.Update where

import Detail.Model exposing (..)
import Time exposing (..)
import Session.Model as SM
import Session.Update as SU
import Signal exposing ((<~))

type Action = SessionAction SU.Action
            | Start Time
            | Stop

step : Action -> Detail -> Detail
step action detail = 
    case action of 
        Start t -> case detail.currentSession of
                     Nothing -> { detail | currentSession <- Just <| SM.new t }
                     Just _ -> detail

        Stop -> case detail.currentSession of
                  Nothing -> detail
                  Just session -> { detail | pastSessions <- session :: detail.pastSessions
                                           , currentSession <- Nothing
                                  }

        SessionAction a  -> case detail.currentSession of 
                              Nothing -> detail
                              Just session -> { detail | currentSession <- Just <| SU.step a session }

actionSignal : Signal Action
actionSignal = SessionAction <~ SU.actionSignal

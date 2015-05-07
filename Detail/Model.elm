module Detail.Model where

import Session.Model as Session exposing (Session)

type alias Detail = 
    { name : String
    , pastSessions : List Session
    , currentSession : Maybe Session
    }

new : String -> Detail
new name = 
    { name = name
    , pastSessions = []
    , currentSession = Nothing
    }

totalLength : Detail -> Int
totalLength detail = 
    List.sum << List.map Session.length <|
    case detail.currentSession of
        Nothing -> detail.pastSessions
        Just session -> session :: detail.pastSessions

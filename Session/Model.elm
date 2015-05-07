module Session.Model where

import Time exposing (..)

type alias Session = 
    { startTime : Time
    , endTime : Time
    }

new : Time -> Session
new t = 
    { startTime = t
    , endTime = t
    }  

length : Session -> Int
length session = session.endTime - session.startTime
                    |> inSeconds
                    |> round
module Prompt.Update where

import Prompt.Model exposing (..)

type Action = SetValue String

step : Action -> Prompt -> Prompt
step action prompt = 
    case action of
        SetValue value -> { prompt | value <- value }
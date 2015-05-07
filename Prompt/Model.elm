module Prompt.Model where

type alias Prompt =
    { label : String
    , message : String
    , value : String
    }

new : String -> String -> Prompt
new label message = 
    { label = label
    , message = message
    , value = ""
    }

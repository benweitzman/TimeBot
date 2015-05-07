module Prompt.View where

import Prompt.Model exposing (..)
import Prompt.Update exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Context = 
    { actions : Signal.Address Action
    , cancel : Signal.Address ()
    , submit : Signal.Address String
    }

display : Context -> Prompt -> Html
display context prompt =
    div
        []
        [ h1 [] [ text prompt.label ]
        , h2 [] [ text prompt.message ]
        , input 
            [ on "input" targetValue (Signal.message context.actions << SetValue)
            , onSubmit context.submit prompt.value
            ]
            []
        , button
            [ onClick context.submit prompt.value ]
            [ text "Submit" ]
        , button
            [ onClick context.cancel () ]
            [ text "Cancel" ]
        ]


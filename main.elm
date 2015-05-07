import Graphics.Element exposing (..)

import Detail.Model as DM
import Detail.View as DV
import Detail.Update as DU
import Session.Model as SM
import Session.View as SV
import Session.Update as SU
import Project.Update as PU
import Project.Model as PM
import Project.View as PV

import Time exposing (..)

import Signal exposing ((<~), (~))

actions : Signal.Mailbox PU.Action
actions = Signal.mailbox PU.NoOp

{-
actionSignal' : PM.Project -> Signal PU.Action -> Signal PU.Action
actionSignal' project action = Signal.merge (PU.actionSignal project) action

actionSignal : PM.Project -> Signal PU.Action
actionSignal project = actionSignal' project actions.signal

a : Signal (Signal PU.Action)
a = Signal.foldp actionSignal' (Signal.constant PU.NoOp) model
-}

model : Signal PM.Project
model = Signal.foldp PU.step (PM.new "Test") (Signal.merge PU.actionSignal actions.signal)

main = PV.display <~ (PV.Context actions.address <~ every second) ~ model
-- ----------------------------------------------------------------------------
-- imports
-- ----------------------------------------------------------------------------

import XMonad
import qualified XMonad.StackSet as W

-- System
import System.Exit (exitSuccess)

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll (killAll, sinkAll)

-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts)

-- Layouts
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)


-- ----------------------------------------------------------------------------
-- general definitions
-- ----------------------------------------------------------------------------

myTerminal :: String
myTerminal = "alacritty"

myEditor :: String
myEditor = myTerminal ++ " -e vim "

myBrowser :: String
myBrowser = "qutebrowser"

myEmailClient :: String
myEmailClient = "thunderbird"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False


-- ----------------------------------------------------------------------------
-- key bindings
-- ----------------------------------------------------------------------------

myModMask :: KeyMask
myModMask = mod4Mask    -- Set Mod to the Super/Windows key

myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
    [ ("M-C-c", spawn "xmonad --recompile")
    , ("M-C-r", spawn "xmonad --restart")
    , ("M-C-q", io exitSuccess)

    -- Window navigation
    , ("M-m", windows W.focusMaster)
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)
    , ("M-C-m", windows W.swapMaster)
    , ("M-C-j", windows W.swapDown)
    , ("M-C-k", windows W.swapUp)

    -- Window resizing
    , ("M-M1-h", sendMessage Shrink)
    , ("M-M1-l", sendMessage Expand)
    , ("M-M1-j", sendMessage MirrorShrink)
    , ("M-M1-k", sendMessage MirrorExpand)

    -- Layouts
    , ("M-<Tab>", sendMessage NextLayout)

    -- Run Prompt
    , ("M1-<Space>", spawn "dmenu_run -l 10 -p 'Run: '")

    -- Start some often used programs
    , ("M1-<Return>", spawn (myTerminal ++ " --working-directory $HOME"))
    , ("M1-C-b", spawn (myBrowser))
    , ("M1-C-f", spawn (myTerminal ++ " -e $HOME/.dotfiles/.config/vifm/scripts/vifmrun"))
    , ("M1-C-l", spawn "slock")
    , ("M1-C-m", spawn (myEmailClient))
    , ("M1-C-v", spawn "pavucontrol")
    , ("M1-C-w", spawn "firefox --new-window https://web.whatsapp.com")

    -- Close programs
    , ("M-w", kill1)
    , ("M1-<F4>", kill1)
    , ("M-S-w", killAll)
    , ("M1-S-<F4>", killAll)

    -- Dmenu scripts
    , ("M1-C-d p", spawn "dmenu_pdf")
    , ("M1-C-d s", spawn "dmenu_scrot")
    , ("M1-C-d m", spawn "dmenu_monitor")
    , ("M1-C-d y", spawn "dmenu_youtube")
    ]


-- ----------------------------------------------------------------------------
-- layouts
-- ----------------------------------------------------------------------------

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing x = spacingRaw False (Border x x x x) True (Border x x x x) True

myBorderWidth :: Dimension
myBorderWidth = 3

tall = renamed [Replace "tall"]
    $ smartBorders
    $ mySpacing 10
    $ ResizableTall 1 (3/100) (1/2) []

grid = renamed [Replace "Grid"]
    $ smartBorders
    $ mySpacing 10
    $ Grid

myLayoutHook =  avoidStruts
    $ withBorder myBorderWidth
    $ tall ||| grid ||| Full


-- ----------------------------------------------------------------------------
-- main
-- ----------------------------------------------------------------------------

main :: IO ()
main = xmonad $ def
    { modMask = myModMask
    , focusFollowsMouse = myFocusFollowsMouse
    , layoutHook = myLayoutHook
    } `additionalKeysP` myKeys

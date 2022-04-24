-- ----------------------------------------------------------------------------
-- imports
-- ----------------------------------------------------------------------------

import XMonad

-- System
import System.Exit (exitSuccess)

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.WithAll (killAll, sinkAll)

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
-- main
-- ----------------------------------------------------------------------------
--
main :: IO ()
main = xmonad $ def
    { modMask = myModMask
    } `additionalKeysP` myKeys

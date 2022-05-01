-- ----------------------------------------------------------------------------
-- imports
-- ----------------------------------------------------------------------------

import XMonad
import qualified XMonad.StackSet as W

-- System
import System.Exit (exitSuccess)

-- Data
import Data.Monoid

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS
import XMonad.Actions.MouseResize
import XMonad.Actions.WithAll (killAll, sinkAll)
import XMonad.Actions.PhysicalScreens

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- Layouts
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers


-- ----------------------------------------------------------------------------
-- general definitions
-- ----------------------------------------------------------------------------

myTerminal :: String
myTerminal = "alacritty"

myEditor :: String
myEditor = myTerminal ++ " -e vim "

myBrowser :: String
myBrowser = "qutebrowser"

myBrowserAlt :: String
myBrowserAlt = "firefox"

myEmailClient :: String
myEmailClient = "thunderbird"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myClickJustFocuses :: Bool
myClickJustFocuses = False

myWorkspaces = [ "<fn=1>\xf0e0</fn>"
               , "<fn=1>\xf0ac</fn>"
               , "<fn=1>\xf086</fn>"
               , "<fn=1>\xf120</fn>1"
               , "<fn=1>\xf120</fn>2"
               , "<fn=1>\xf120</fn>3"
               , "<fn=1>\xf121</fn>1"
               , "<fn=1>\xf121</fn>2"
               , "<fn=1>\xf121</fn>3"
               ]


-- ----------------------------------------------------------------------------
-- key bindings
-- ----------------------------------------------------------------------------

myModMask :: KeyMask
myModMask = mod4Mask    -- Set Mod to the Super/Windows key

myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
    [ ("M-C-c",         spawn "xmonad --recompile")
    , ("M-C-r",         spawn "xmonad --restart")
    , ("M-C-q",         io exitSuccess)

    -- Window navigation
    , ("M-m",           windows W.focusMaster)
    , ("M-j",           windows W.focusDown)
    , ("M-k",           windows W.focusUp)
    , ("M-C-m",         windows W.swapMaster)
    , ("M-C-j",         windows W.swapDown)
    , ("M-C-k",         windows W.swapUp)

    -- Window resizing
    , ("M-M1-h",        sendMessage Shrink)
    , ("M-M1-l",        sendMessage Expand)
    , ("M-M1-j",        sendMessage MirrorShrink)
    , ("M-M1-k",        sendMessage MirrorExpand)

    -- Workspace navigation
    , ("M-C-h",         prevWS)
    , ("M-C-<Left>",    prevWS)
    , ("M-C-l",         nextWS)
    , ("M-C-<Right>",   nextWS)
    , ("M-C-S-h",       shiftToPrev)
    , ("M-C-S-<Left>",  shiftToPrev)
    , ("M-C-S-l",       shiftToNext)
    , ("M-C-S-<Right>", shiftToNext)

    -- Floating windows
    , ("M-t",           withFocused $ windows . W.sink)
    , ("M-S-t",         sinkAll)

    -- Layouts
    , ("M-<Tab>",       sendMessage NextLayout)

    -- Run Prompt
    , ("M1-<Space>",    spawn "dmenu_run -l 10 -p 'Run: '")

    -- Start some often used programs
    , ("M1-<Return>",   spawn (myTerminal ++ " --working-directory $HOME"))
    , ("M1-C-b",        spawn (myBrowser))
    , ("M1-C-S-b",      spawn (myBrowserAlt))
    , ("M1-C-f",        spawn (myTerminal ++ " -e $HOME/.dotfiles/.config/vifm/scripts/vifmrun"))
    , ("M1-C-l",        spawn "slock")
    , ("M1-C-m",        spawn (myEmailClient))
    , ("M1-C-v",        spawn "pavucontrol")
    , ("M1-C-w",        spawn "firefox --new-window https://web.whatsapp.com")

    -- Close programs
    , ("M-w",           kill1)
    , ("M1-<F4>",       kill1)
    , ("M-S-w",         killAll)
    , ("M1-S-<F4>",     killAll)

    -- Dmenu scripts
    , ("M1-C-d p",      spawn "dmenu_pdf")
    , ("M1-C-d s",      spawn "dmenu_scrot")
    , ("M1-C-d m",      spawn "dmenu_monitor")
    , ("M1-C-d y",      spawn "dmenu_youtube")
    , ("M1-C-<Delete>", spawn "dmenu_break")
    ]
    ++
    -- Physical screens
    -- The original xmonad shortcuts M-{wer} switch focus to the screens 1, 2,
    -- and 3 respectively. Unfortunatley these screen number don't nessecarily
    -- correspond to the the phyical set up of the screens. PhysicalScreens
    -- allows you to switch to focos to screens depending on there actual
    -- position in the monitor setup.
    [("M-" ++ modKey2 ++ keyChar, screenOperation screen)
        | (keyChar, screen) <- zip ["s", "d", "f"] [0..]
        , (screenOperation, modKey2) <- [(viewScreen def, "")
                                       , (sendToScreen def, "S-")]
    ]
    ++
    -- View workspace sets
    -- I wanted to have key bindings that allow me to set a set of workspaces
    -- on up to three screens. So pressing M-c for example places workspace 4
    -- on physical screen 0, workspace 5 on phyical screen 1, and workspace 6
    -- on physical screen 2. It also bring the focus on my primary screen.
    [ ("M-x", sequence_ [sWW 0 (mWS 0), sWW 1 (mWS 1), sWW 2 (mWS 2), focusPrimary])
    , ("M-c", sequence_ [sWW 0 (mWS 3), sWW 1 (mWS 4), sWW 2 (mWS 5), focusPrimary])
    , ("M-v", sequence_ [sWW 0 (mWS 6), sWW 1 (mWS 7), sWW 2 (mWS 8), focusPrimary])
    ]

screenWithWorkspace :: PhysicalScreen -> String -> X()
screenWithWorkspace screen workspace =
    sequence_ [vS screen, windows $ W.greedyView workspace]

sWW   = screenWithWorkspace
vS    = viewScreen def
mWS i = (myWorkspaces !! i)

-- focusPrimary:
-- was written by basically copying the xmonad's default keybin M-w. It moved
-- the fucus on the primary monitor (set e.g. by xrandr or ARandR).
focusPrimary = screenWorkspace 0 >>= flip whenJust (windows . W.view)


-- ----------------------------------------------------------------------------
-- layouts
-- ----------------------------------------------------------------------------

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing x = spacingRaw False (Border x x x x) True (Border x x x x) True

myBorderWidth :: Dimension
myBorderWidth = 3

myNormalBorderColor  = "#555555"
myFocusedBorderColor = "#268bd2"

tall = renamed [Replace "tall"]
    $ smartBorders
    $ mySpacing 5
    $ ResizableTall 1 (3/100) (1/2) []

grid = renamed [Replace "Grid"]
    $ smartBorders
    $ mySpacing 5
    $ Grid

myLayoutHook = avoidStruts
    $ withBorder myBorderWidth
    $ tall ||| Mirror tall ||| grid ||| noBorders Full


-- ----------------------------------------------------------------------------
-- hooks
-- ----------------------------------------------------------------------------

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [
     -- float
       className =? "Blueman-manager" --> doFloat
     , className =? "confirm"         --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat
     , title =? "Oracle VM VirtualBox Manager"            --> doFloat
     -- shift to certain workspace
     , className =? "Thunderbird"     --> doShift (mWS 0)
     ]


-- ----------------------------------------------------------------------------
-- startup
-- ----------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "/usr/lib/notification-daemon-1.0/notification-daemon"
    spawnOnce "trayer --monitor primary --edge top --align right --distance 5 --distancefrom top --padding 5 --SetDockType true --SetPartialStrut true --expand true --widthtype request --transparent true --alpha 0 --tint 0x083f4d --height 25 --iconspacing 5 &"
    spawnOnce "nm-applet &"
    spawnOnce "blueman-applet &"
    spawnOnce "udiskie --no-automaount --no-notify --tray &"
    spawnOnce "keepassxc &"
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom --config ~/.config/picom/picom.conf &"
    spawnOnce "xss-lock -- slock &"
    spawnOnce "xsetroot -cursor_name left_ptr &"


-- ----------------------------------------------------------------------------
-- xmobar
-- ----------------------------------------------------------------------------

myXmobarPP :: PP
myXmobarPP = def
    { ppCurrent         = brightWhite . wrap "[ " " ]"
    , ppVisible         = normalWhite . wrap "[ " " ]"
    , ppHidden          = normalWhite . wrap "  " "* "
    , ppHiddenNoWindows = normalWhite . wrap "  " "  "
    , ppUrgent          = normalRed   . wrap "  " "  "
    , ppSep             = " │ "
    , ppWsSep           = " "
    , ppTitle           = brightWhite . shorten 50
    , ppTitleSanitize   = xmobarStrip
    , ppOrder           = \[ws, l, win] -> [ws, l, win]
    }


-- Color definition are matched to the once I use in my alacritty config.
-- The used color scheme is my variation of solarizid dark.
background, foreground :: String -> String
background    = xmobarColor "#002b36" ""
foreground    = xmobarColor "#839496" ""

normalBlack, normalRed, normalGreen, normalYellow :: String -> String
normalBlack   = xmobarColor "#083f4d" ""
normalRed     = xmobarColor "#dc322f" ""
normalGreen   = xmobarColor "#169921" ""
normalYellow  = xmobarColor "#b58900" ""

normalBlue, normalMagenta, normalCyan, normalWhite :: String -> String
normalBlue    = xmobarColor "#268bd2" ""
normalMagenta = xmobarColor "#da54da" ""
normalCyan    = xmobarColor "#26958c" ""
normalWhite   = xmobarColor "#839496" ""

brightBlack, brightRed, brightGreen, brightYellow :: String -> String
brightBlack   = xmobarColor "#0c677e" ""
brightRed     = xmobarColor "#df5017" ""
brightGreen   = xmobarColor "#1aba27" ""
brightYellow  = xmobarColor "#daa400" ""

brightBlue, brightMagenta, brightCyan, brightWhite :: String -> String
brightBlue    = xmobarColor "#2a9dea" ""
brightMagenta = xmobarColor "#fe61fe" ""
brightCyan    = xmobarColor "#2db0a5" ""
brightWhite   = xmobarColor "#d9f2f3" ""


-- ----------------------------------------------------------------------------
-- main
-- ----------------------------------------------------------------------------

main :: IO ()
main = xmonad 
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar -x 0" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask            = myModMask
    , focusFollowsMouse  = myFocusFollowsMouse
    , clickJustFocuses   = myClickJustFocuses
    , startupHook        = myStartupHook
    , layoutHook         = myLayoutHook
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , manageHook         = myManageHook
    , workspaces         = myWorkspaces
    } `additionalKeysP` myKeys

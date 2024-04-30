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
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.SpawnOn
import XMonad.Actions.WithAll (killAll, sinkAll)

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.RefocusLast (refocusLastLayoutHook, refocusLastWhen, refocusingIsActive, isFloat)
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing

-- Layouts
import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Loggers
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

import Graphics.X11.Xinerama (getScreenInfo)

-- ----------------------------------------------------------------------------
-- general definitions
-- ----------------------------------------------------------------------------

myTerminal :: String
myTerminal = "alacritty -o font.size=10"

myEditor :: String
myEditor = myTerminal ++ " -e vim "

myBrowser :: String
myBrowser = "qutebrowser"

myBrowserAlt :: String
myBrowserAlt = "firefox"

myEmailClient :: String
myEmailClient = (myTerminal ++ " --working-directory $HOME -e neomutt")

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
               , "<fn=1>\xf03a</fn>"
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
    , ("M1-<Tab>",      windows W.focusDown)

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
    -- I have my todo list on the tens workspace.
    , ("M-0",           windows $ W.greedyView (myWorkspaces !! 9))
    , ("M-S-0",         windows $ W.shift (myWorkspaces !! 9))

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
    , ("M1-C-m",        spawnOn (myWorkspaces !! 0) myEmailClient)
    , ("M1-C-v",        spawn "pavucontrol")
    , ("M1-C-w",        spawnOn (myWorkspaces !! 2) "firefox --new-window https://web.whatsapp.com")
    , ("M1-C-t",        sequence_ [ windows $ W.greedyView (myWorkspaces !! 9)
                                  , spawn (myTerminal ++ " --working-directory $HOME")
                                  ]
      )

    -- Open scratchpads
    , ("M1-C-<Return>", namedScratchpadAction myScratchPads "terminal")
    , ("M1-C-c",        namedScratchpadAction myScratchPads "calendar")
    , ("M1-C-q",        namedScratchpadAction myScratchPads "calculator")

    -- Close programs
    , ("M-w",           kill1)
    , ("M1-<F4>",       kill1)
    , ("M-S-w",         killAll)
    , ("M1-S-<F4>",     killAll)

    -- Dmenu scripts
    , ("M1-C-d p",      spawn "dmenu_pdf")
    , ("M1-C-d s",      spawn "dmenu_scrot")
    , ("M1-C-d m",      spawn "dmenu_monitors")
    , ("M1-C-d y",      spawn "dmenu_youtube")
    , ("M1-C-<Delete>", spawn "dmenu_break")
    ]
    ++
    -- Physical screens
    -- The original xmonad shortcuts M-{wer} switch focus to the screens 1, 2,
    -- and 3 respectively. Unfortunatley these screen number don't nessecarily
    -- correspond to the the phyical set up of the screens. PhysicalScreens
    -- allows you to switch to focus to screens depending on there actual
    -- position in the monitor setup.
    [("M-" ++ modKey2 ++ keyChar, screenOperation screen)
        | (keyChar, screen) <- zip ["s", "d", "f", "g"] [0..]
        , (screenOperation, modKey2) <- [(viewScreen def, "")
                                       , (sendToScreen def, "S-")]
    ]
    ++
    -- View workspace sets
    -- I wanted to have key bindings that allow me to set a set of three
    -- workspaces on up to three screens. I grouped my nine workspaces into
    -- three sets of three workpaces as you can see by examining there names.
    -- So pressing M-c for example places workspace 3 on physical screen 0,
    -- workspace 4 on phyical screen 1, and workspace 5 on physical screen 2.
    -- It also bring the focus on my primary screen. The reversed order in
    -- which the workspaces are set to the screens metter (at least if there
    -- are not three monitors). In case there is only one monitor I want to set
    -- the first workspace of the corresponding set to that monitor. In case
    -- there are two mointors I want to set the first workspace of the
    -- corresponding set to the left most monitor and the second workspace of
    -- the set to the other monitor. If the "sequences" were ordered
    -- differently, this wouldn't work. Somehow setting a workspace to a
    -- physical screen that doesn't exist causes a behaviour that I didn't
    -- think all the way through. I just realized that doing it the way it is
    -- done now, works.
    [ ("M-x", showSet1)
    , ("M-c", showSet2)
    , ("M-v", showSet3)
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

numScreens :: X Int
numScreens = withDisplay (io.fmap length.getScreenInfo)

showSet1 = do
    ns <- numScreens
    if ns == 4
        then sequence_ [sWW 3 (mWS 9), sWW 2 (mWS 2), sWW 1 (mWS 1), sWW 0 (mWS 0), focusPrimary]
        else sequence_ [sWW 2 (mWS 2), sWW 1 (mWS 1), sWW 0 (mWS 0), focusPrimary]
showSet2 = do
    ns <- numScreens
    if ns == 4
        then sequence_ [sWW 3 (mWS 9), sWW 2 (mWS 5), sWW 1 (mWS 4), sWW 0 (mWS 3), focusPrimary]
        else sequence_ [sWW 2 (mWS 5), sWW 1 (mWS 4), sWW 0 (mWS 3), focusPrimary]
showSet3 = do
    ns <- numScreens
    if ns == 4
        then sequence_ [sWW 3 (mWS 9), sWW 2 (mWS 8), sWW 1 (mWS 7), sWW 0 (mWS 6), focusPrimary]
        else sequence_ [sWW 2 (mWS 8), sWW 1 (mWS 7), sWW 0 (mWS 6), focusPrimary]

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
    $ refocusLastLayoutHook
    $ tall ||| Mirror tall ||| grid ||| noBorders Full


-- ----------------------------------------------------------------------------
-- scratchpads
-- ----------------------------------------------------------------------------

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal"   spawnTerm findTerm manageTerm
                , NS "calculator" spawnCalc findCalc manageCalc
                , NS "calendar"   spawnCal  findCal  manageCal
                ]
  where
    spawnTerm  = myTerminal ++ " -t spTerminal"
    findTerm   = title =? "spTerminal"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.8
                 w = 0.8
                 t = 0.1
                 l = 0.1
    spawnCal   = myTerminal ++ " --hold -t spCal -e cal -m -Y -S"
    findCal    = title =? "spCal"
    manageCal  = customFloating $ W.RationalRect l t w h
               where
                 h = 0.85
                 w = 0.45
                 t = 0.075
                 l = 0.275
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.7
                 w = 0.5
                 t = 0.15
                 l = 0.25


-- ----------------------------------------------------------------------------
-- hooks
-- ----------------------------------------------------------------------------

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeOne
    [
    -- float
      isDialog -?> doFloat
    , className =? "Blueman-manager" -?> doFloat
    , className =? "confirm"         -?> doFloat
    , className =? "dialog"          -?> doFloat
    , className =? "download"        -?> doFloat
    , className =? "error"           -?> doFloat
    , className =? "file_progress"   -?> doFloat
    , className =? "mpv"             -?> doFloat
    , className =? "notification"    -?> doFloat
    , className =? "pinentry-gtk-2"  -?> doFloat
    , className =? "Pavucontrol"     -?> doFloat
    , className =? "com.st.app.Main" -?> doFloat
    , (className =? "firefox" <&&> resource =? "Dialog") -?> doFloat
    -- shift to certain workspace
    , className =? "Thunderbird" <||> className =? "thunderbird" -?> doShift (mWS 0)

    -- all non floating new windows insert below the current one in the window
    -- stack
    , return True -?> insertPosition Below Newer
    ] <+> namedScratchpadManageHook myScratchPads

myHandleEventHook :: Event -> X All
myHandleEventHook = mconcat
    [
      refocusLastWhen (refocusingIsActive <||> isFloat)
    , swallowEventHook (className =? "Alacritty") (return True)
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
    spawnOnce "udiskie --no-automount --no-notify --tray &"
    spawnOnce "keepassxc &"
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom --config ~/.config/picom/picom.conf &"
    spawnOnce "xss-lock -- slock &"
    spawnOnce "xsetroot -cursor_name left_ptr &"
    showSet1


-- ----------------------------------------------------------------------------
-- xmobar
-- ----------------------------------------------------------------------------

myXmobarPP :: ScreenId -> PP
myXmobarPP i = filterOutWsPP [scratchpadWorkspaceTag] $ def
    { ppCurrent         = brightWhite . wrap "[ " " ]"
    , ppVisible         = normalWhite . wrap "[ " " ]"
    , ppHidden          = normalWhite . wrap "  " "* "
    , ppHiddenNoWindows = normalWhite . wrap "  " "  "
    , ppUrgent          = normalRed   . wrap "  " "  "
    , ppSep             = " │ "
    , ppWsSep           = " "
    , ppTitle           = brightWhite . shorten 50
    , ppTitleSanitize   = xmobarStrip
    , ppOrder           = \[ws, l, win, extras] -> [ws, extras, l, win]
    , ppExtras          = [ xmobarColorL "#d9f2f3" "" $ logCurrentOnScreen i ]
    }

myXmobarPP0 = myXmobarPP 0
myXmobarPP1 = myXmobarPP 1
myXmobarPP2 = myXmobarPP 2
myXmobarPP3 = myXmobarPP 3

myXmobar0 = statusBarPropTo "_XMONAD_LOG_0" "xmobar -x 0 ~/.config/xmobar/xmobarrc_0" (pure myXmobarPP0)
myXmobar1 = statusBarPropTo "_XMONAD_LOG_1" "xmobar -x 1 ~/.config/xmobar/xmobarrc_1" (pure myXmobarPP1)
myXmobar2 = statusBarPropTo "_XMONAD_LOG_2" "xmobar -x 2 ~/.config/xmobar/xmobarrc_2" (pure myXmobarPP2)
myXmobar3 = statusBarPropTo "_XMONAD_LOG_3" "xmobar -x 3 ~/.config/xmobar/xmobarrc_3" (pure myXmobarPP3)

myBarSpawner :: ScreenId -> IO StatusBarConfig
myBarSpawner 0 = pure $ myXmobar0
myBarSpawner 1 = pure $ myXmobar1
myBarSpawner 2 = pure $ myXmobar2
myBarSpawner 3 = pure $ myXmobar3
myBarSpawner _ = mempty

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
     . dynamicSBs myBarSpawner
     . docks
     $ myConfig

myConfig = def
    { modMask            = myModMask
    , focusFollowsMouse  = myFocusFollowsMouse
    , clickJustFocuses   = myClickJustFocuses
    , startupHook        = myStartupHook
    , layoutHook         = myLayoutHook
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , manageHook         = manageSpawn <+> myManageHook
    , handleEventHook    = myHandleEventHook
    , workspaces         = myWorkspaces
    } `additionalKeysP` myKeys

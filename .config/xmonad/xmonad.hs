import Data.Map qualified as M
import Data.Ratio ((%))
import System.Exit (exitSuccess)
import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen)
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders (noBorders)
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing (spacingWithEdge)
import XMonad.ManageHook
import XMonad.StackSet qualified as W
import XMonad.Util.Cursor (setDefaultCursor)
import XMonad.Util.NamedScratchpad

term = "wezterm"

scratchpads =
  [ NS "htop" (term <> " -e htop") (title =? "htop") nonFloating,
    NS "discord" "discord" (appName =? "discord") nonFloating
  ]

keybinds conf@(XConfig {XMonad.modMask = modKey}) =
  M.fromList $
    [ -- APPS
      ((modKey, xK_t), spawn term), -- terminal
      ((modKey, xK_p), spawn "dmenu_run"), -- run prompt
      ((modKey, xK_b), spawn "brave"), -- browser
      ((modKey .|. shiftMask, xK_p), spawn "pavucontrol"), -- volume mixer
      ((modKey, xK_e), spawn "emacsclient -c --alternate-editor emacs"), -- open an emacs frame
      ((0, xK_Print), spawn "flameshot gui"), -- area screenshot (flameshot)
      ((controlMask .|. shiftMask, xK_Escape), namedScratchpadAction scratchpads "htop"), -- switch to htop
      ((modKey, xK_d), namedScratchpadAction scratchpads "discord"), -- switch to discord
      ((modKey .|. controlMask, xK_k), spawn "kmonad-toggle"), -- toggle kmonad bindings
      -- WINDOWING
      ((modKey, xK_w), kill), -- close window
      ((modKey, xK_Tab), sendMessage NextLayout), -- switch layout
      ((modKey, xK_j), windows W.focusDown), -- focus next
      ((modKey, xK_k), windows W.focusUp), -- focus previous
      ((modKey, xK_m), windows W.focusMaster), -- focus master
      ((modKey, xK_Return), windows W.swapMaster), -- swap master
      ((modKey .|. shiftMask, xK_j), windows W.swapDown), -- swap next
      ((modKey .|. shiftMask, xK_k), windows W.swapUp), -- swap previous
      ((modKey, xK_h), sendMessage Shrink), -- shrink master
      ((modKey, xK_l), sendMessage Expand), -- expand master
      ((modKey, xK_v), withFocused $ windows . W.sink), -- set tile
      ((modKey, xK_i), sendMessage (IncMasterN 1)), -- increment master count
      ((modKey, xK_o), sendMessage (IncMasterN (-1))), -- decrement master count
      -- SYSTEM
      ((modKey .|. shiftMask, xK_q), io exitSuccess), -- Quit xmonad
      ((modKey, xK_q), spawn "xmonad --recompile && xmonad --restart"), -- Restart xmonad
      ((modKey .|. shiftMask .|. controlMask, xK_r), spawn "loginctl reboot"), -- reboot pc
      ((modKey .|. shiftMask .|. controlMask, xK_s), spawn "loginctl poweroff"), -- shut down pc
      ((modKey .|. shiftMask, xK_s), spawn "loginctl suspend"), -- suspend pc
      ((modKey .|. shiftMask, xK_s), spawn "pa-toggle-output")
    ]
      <> [ ((m .|. modKey, k), windows $ f i)
           | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
             (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
         ]
      <> [ ((m .|. modKey, key), screenWorkspace sc >>= flip whenJust (windows . f))
           | (key, sc) <- zip [xK_comma, xK_period] [1, 0],
             (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]

layouts =
  let tiled = spacingWithEdge 5 $ Tall 1 (3 % 100) (1 % 2)
      full = noBorders Full
   in onWorkspace "1" (full ||| tiled) (tiled ||| full)

startup = do
  setWMName "LG3D"
  spawn "discord"
  spawn "emacs"
  setDefaultCursor xC_left_ptr

myMangageHook =
  composeAll
    [ namedScratchpadManageHook scratchpads,
      appName =? "discord" --> doShift "2"
    ]

conf =
  def -- This is just an `XConfig` instance
    { terminal = term,
      modMask = mod4Mask,
      normalBorderColor = "#1e1e2e",
      focusedBorderColor = "#b4befe",
      borderWidth = 2,
      workspaces = show <$> [1 .. 6],
      keys = keybinds,
      layoutHook = layouts,
      manageHook = myMangageHook,
      startupHook = startup,
      focusFollowsMouse = True,
      clickJustFocuses = True
    }

main :: IO ()
main = xmonad . ewmh $ conf

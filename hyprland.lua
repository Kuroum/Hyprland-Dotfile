-- ==============================================================================
-- HYPRLAND LUA CONFIG 
-- ==============================================================================

hl.monitor({
    output   = "",
    mode     = "2560x1440@360",
    position = "auto",
    scale    = "1",
})

local terminal    = "kitty"
local browser     = "librewolf"
local filemanager = "nnn"
local mainMod     = "SUPER"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function () 
    hl.exec_cmd("mako")
    hl.exec_cmd("pipewire")
    hl.exec_cmd("wireplumber")
    hl.exec_cmd("swaybg -i ~/Wallpapers/cat.png -m fill")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
    general = { 
        gaps_in = 4,
        gaps_out = 8,
        border_size = 0,
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },
    decoration = {
        rounding         = 10,
        active_opacity   = 0.85,
        inactive_opacity = 0.85,
        blur = {
            enabled        = true,
            size           = 6,
            passes         = 2,
            ignore_opacity = true,
        },
        shadow = {
            enabled = false,
        },
    },
    animations = { enabled = true },
    misc = { 
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },
    dwindle = { preserve_split = true },
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0, 
    },
})

--------------------
---- ANIMATIONS ----
--------------------
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.animation({ leaf = "windows",    enabled = true, speed = 5,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 5,  bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5,  bezier = "default" })

---------------------
---- KEYBINDINGS ----
---------------------
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty -e " .. filemanager))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("steam"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("sh -c 'grim -g \"$(slurp)\" ~/screenshot_$(date +%Y%m%d_%H%M%S).png'"))

-- GEFIXTE AUDIO HOTKEYS (CTRL statt CONTROL)
hl.bind("CTRL + up",    hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("CTRL + down",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("CTRL + right", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true })
hl.bind("CTRL + left",  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true })

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-----------------------
---- WINDOW RULES  ----
-----------------------
hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ name = "opacity-librewolf", match = { class = "^(librewolf)$" }, opacity = "1.0 1.0" })
hl.window_rule({ name = "opacity-LibreWolf-caps", match = { class = "^(LibreWolf)$" }, opacity = "1.0 1.0" })
hl.window_rule({ name = "opacity-fullscreen", match = { fullscreen = true }, opacity = "1.0 1.0" })
hl.window_rule({ name = "opacity-kitty", match = { class = "^(kitty)$" }, opacity = "0.85 0.85" })

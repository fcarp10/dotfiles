if id -u "broly" >/dev/null 2>&1; then
  niri --config .config/niri/desktop.kdl --session
elif id -u "vegito" >/dev/null 2>&1; then
  Hyprland --config .config/hypr/setup_laptop.conf
elif id -u "vegeta" >/dev/null 2>&1; then
  Hyprland --config .config/hypr/setup_desktop_office.conf
elif id -u "goku" >/dev/null 2>&1; then
  Hyprland --config .config/hypr/setup_laptop_office.conf
elif id -u "mutenroshi" >/dev/null 2>&1; then
  Hyprland --config .config/hypr/setup_imac.conf
else
  echo "no valid user found"
fi 

#!/bin/zsh

# Change terminal color for SSH (Add "PermitLocalCommand yes" to /etc/ssh/ssh_config)
ssh() {
  FG=$(xtermcontrol --get-fg)
  BG=$(xtermcontrol --get-bg)
  command ssh "$@"
  xtermcontrol --fg="$FG"
  xtermcontrol --bg="$BG"
}

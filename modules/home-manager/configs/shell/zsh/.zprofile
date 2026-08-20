# Add local bins to the path
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$PATH:$HOME/.local/bin"
fi

# Source Home Manager session variables if they exist
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
elif [ -f "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh" ]; then
  . "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh"
fi

# export XDG_CONFIG_HOME=$HOME/.config
# export XDG_CACHE_HOME=$HOME/.cache
# export XDG_DATA_HOME=$HOME/.local/share

# source local non-version controlled profile
source ~/.local_profile

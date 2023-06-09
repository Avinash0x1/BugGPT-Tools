#Full Colors
set -g default-terminal "screen-256color"

# Use Alt + G as the prefix key
set-option -g prefix M-g
unbind-key C-b
bind-key M-t send-prefix

# Bindings for splitting windows
bind-key M-h split-window -h
bind-key M-v split-window -v

# Binding for creating a new window
bind-key M-n new-window
# Kill current Window
bind-key -n M-t send-keys C-b "&" \; send-keys M-t x

# Alt + T + S will list all sessions
# Switch between sessions using Alt + S + {session number}
#bind-key -n M-s command-prompt -p "Switch to session:" "switch-client -t '%%'"
bind-key -n M-s choose-session

# Enable mouse support
set -g mouse on

#Vim like edit mode
setw -g mode-keys vi

# start windows numbering at 1
set -g base-index 1           
# make pane numbering consistent with windows
setw -g pane-base-index 1     
set-window-option -g pane-base-index 1
# rename window to reflect current program
setw -g automatic-rename on   
# renumber windows when a window is closed
set -g renumber-windows on    
# set terminal title
set -g set-titles on

# Increase the scrollback history limit
set-option -g history-limit 10000

# Reload the tmux configuration with Alt + R
bind-key -n M-r source-file ~/.tmux.conf

#Plugins
set -g @plugin 'tmux-plugins/tpm'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run-shell "tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH '${HOME}/.tmux/plugins/'"
run '~/.tmux/plugins/tpm/tpm'

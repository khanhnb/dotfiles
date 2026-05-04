# Prevent blinking cursor.
# function __set_beam_cursor {
#     echo -ne '\e[6 q'
# }

function __set_blinking_bar_cursor {
    echo -ne '\e[1 q'
    # echo -ne '\e[2 q'
}

# function __set_block_cursor {
#     echo -ne '\e[2 q'
# }

function zle-keymap-select {
  case $KEYMAP in
    vicmd) __set_blinking_bar_cursor;;
    viins|main) __set_blinking_bar_cursor;;
  esac
}
zle -N zle-keymap-select

precmd_functions+=(__set_blinking_bar_cursor)

# Powerlevel10k, lean style in tokyonight night colors. Only settings that differ from the
# defaults are here; see /opt/homebrew/share/powerlevel10k/config/p10k-lean.zsh for the rest.

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # Tokyonight night
  local blue='#7aa2f7' cyan='#7dcfff' purple='#bb9af7' red='#f7768e'
  local yellow='#e0af68' green='#9ece6a' comment='#565f89'

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline prompt_char)
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs)

  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=true
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
  typeset -g POWERLEVEL9K_MULTILINE_{FIRST,NEWLINE,LAST}_PROMPT_{PREFIX,SUFFIX}=
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '

  # Prompt symbol: blue after success, red after failure
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$red
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='➜'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=

  # Directory
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=$comment
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER='(.git|package.json|go.mod|Cargo.toml|.shorten_folder_marker)'
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

  # Git status via gitstatusd: branch [!2 +1 ?3]
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=$' '
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

  function my_git_formatter() {
    emulate -L zsh
    if [[ -n $P9K_CONTENT ]]; then
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi

    # Colors are literal here: this runs at render time, after the config's locals are gone
    local branch_color changes_color
    if (( $1 )); then
      branch_color='%F{#bb9af7}' changes_color='%F{#f7768e}'
    else
      branch_color='%F{#565f89}' changes_color='%F{#565f89}'
    fi

    local res
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
      (( $#branch > 32 )) && branch[13,-13]="…"
      res+="${branch_color}%B${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}%b"
    elif [[ -n $VCS_STATUS_TAG ]]; then
      res+="${branch_color}%B#${(V)VCS_STATUS_TAG//\%/%%}%b"
    else
      res+="${branch_color}%B@${VCS_STATUS_COMMIT[1,8]}%b"
    fi

    local flags=()
    (( VCS_STATUS_NUM_CONFLICTED )) && flags+=("=${VCS_STATUS_NUM_CONFLICTED}")
    (( VCS_STATUS_COMMITS_AHEAD && VCS_STATUS_COMMITS_BEHIND )) &&
      flags+=("⇕⇡${VCS_STATUS_COMMITS_AHEAD}⇣${VCS_STATUS_COMMITS_BEHIND}")
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && flags+=("⇡${VCS_STATUS_COMMITS_AHEAD}")
    (( VCS_STATUS_COMMITS_BEHIND && !VCS_STATUS_COMMITS_AHEAD )) && flags+=("⇣${VCS_STATUS_COMMITS_BEHIND}")
    (( VCS_STATUS_STASHES        )) && flags+=("*${VCS_STATUS_STASHES}")
    (( VCS_STATUS_NUM_UNSTAGED   )) && flags+=("!${VCS_STATUS_NUM_UNSTAGED}")
    (( VCS_STATUS_NUM_STAGED     )) && flags+=("+${VCS_STATUS_NUM_STAGED}")
    (( VCS_STATUS_NUM_UNTRACKED  )) && flags+=("?${VCS_STATUS_NUM_UNTRACKED}")
    [[ -n $VCS_STATUS_ACTION     ]] && flags+=("${VCS_STATUS_ACTION}")
    (( $#flags )) && res+=" ${changes_color}%B[${(j::)flags}]%b"

    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null

  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
  typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_FOREGROUND=$purple

  # Exit status: the prompt symbol already turns red, so only show signals and pipe failures
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR=false
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=$green
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=$red
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=$red
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false

  # Command duration, shown after 2 seconds
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=2
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$yellow
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$green

  # Instant prompt draws the prompt before the rest of .zshrc finishes loading
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'

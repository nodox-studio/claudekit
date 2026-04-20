#!/bin/bash
input=$(cat)

# Session timer — keyed by parent PID
TIMER_DIR="${HOME}/.claude/.session-timers"
mkdir -p "$TIMER_DIR"
TIMER_FILE="${TIMER_DIR}/${PPID}"
if [ ! -f "$TIMER_FILE" ]; then
    date +%s > "$TIMER_FILE"
fi
START=$(cat "$TIMER_FILE")
ELAPSED=$(( $(date +%s) - START ))
HOURS=$((ELAPSED / 3600))
MINS=$(( (ELAPSED % 3600) / 60 ))
SECS=$((ELAPSED % 60))
TIME_FMT=$(printf '%02d:%02d:%02d' "$HOURS" "$MINS" "$SECS")

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"' | sed 's/Claude //')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
IN=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
OUT=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
FULL_DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')
DIR=$(basename "$FULL_DIR")

COST_FMT=$(printf '$%.2f' "$COST")

fmt_tokens() {
    local t=$1
    if [ "$t" -ge 1000000 ]; then
        awk "BEGIN {printf \"%.1fM\", $t/1000000}"
    elif [ "$t" -ge 1000 ]; then
        awk "BEGIN {printf \"%.1fK\", $t/1000}"
    else
        echo "$t"
    fi
}

IN_FMT=$(fmt_tokens "$IN")
OUT_FMT=$(fmt_tokens "$OUT")

# True color — AA contrast on dark backgrounds (#1a1a1a+)
# All values tested ≥ 4.5:1 ratio
if [ "$PCT" -ge 90 ]; then
    CTX='\033[38;2;255;110;110m'
elif [ "$PCT" -ge 70 ]; then
    CTX='\033[38;2;255;210;80m'
else
    CTX='\033[38;2;100;220;130m'
fi
R='\033[0m'
WHITE='\033[38;2;230;230;235m'
MUTED='\033[38;2;150;150;160m'
SEP="${MUTED}▐${R}"

# tmux top bar — project + timer
if [ -n "$TMUX" ]; then
    tmux set -q status-right "#[fg=#a6adc8]${DIR} #[fg=#f5c2e7]⏱ ${TIME_FMT} #[fg=#6c7086]▐ #[fg=#a6adc8]%H:%M " 2>/dev/null
fi

# Project name — prefer session_name, fall back to current dir basename
SESSION_NAME=$(echo "$input" | jq -r '.session_name // empty')
if [ -n "$SESSION_NAME" ]; then
    PROJECT="$SESSION_NAME"
else
    PROJECT="$DIR"
fi

CYAN='\033[38;2;100;200;255m'
YELLOW='\033[38;2;255;210;80m'
GREEN='\033[38;2;100;220;130m'

# RTK savings — parse `rtk gain` output
RTK_SEGMENT=""
if command -v rtk &>/dev/null; then
    RTK_OUT=$(rtk gain 2>/dev/null)
    if [ -n "$RTK_OUT" ]; then
        # Parse "Tokens saved: 2.2M (67.0%)" line
        TOKENS_SAVED_LINE=$(echo "$RTK_OUT" | grep -i 'tokens saved')
        RTK_PCT=""
        RTK_DOLLARS=""

        # Extract percentage from parentheses, e.g. (67.0%)
        if [ -n "$TOKENS_SAVED_LINE" ]; then
            RTK_PCT=$(echo "$TOKENS_SAVED_LINE" | grep -oE '\(([0-9]+(\.[0-9]+)?%)\)' | grep -oE '[0-9]+(\.[0-9]+)?%' | head -1)
            # Extract raw token count with optional K/M/B suffix, e.g. 2.2M or 375.9K
            RAW_TOKEN=$(echo "$TOKENS_SAVED_LINE" | grep -oE '[0-9]+(\.[0-9]+)?[KMBkmb]?' | head -1)
            SUFFIX=$(echo "$RAW_TOKEN" | grep -oE '[KMBkmb]$')
            NUM=$(echo "$RAW_TOKEN" | grep -oE '^[0-9]+(\.[0-9]+)?')
            if [ -n "$NUM" ]; then
                case "$SUFFIX" in
                    [Kk]) TOKENS=$(awk "BEGIN {printf \"%d\", $NUM * 1000}") ;;
                    [Mm]) TOKENS=$(awk "BEGIN {printf \"%d\", $NUM * 1000000}") ;;
                    [Bb]) TOKENS=$(awk "BEGIN {printf \"%d\", $NUM * 1000000000}") ;;
                    *)    TOKENS=$(awk "BEGIN {printf \"%d\", $NUM}") ;;
                esac
                # savings_dollars = tokens * 30 / 1000000
                # (75% input @ $15/1M + 25% output @ $75/1M = $30/1M blended)
                RTK_DOLLARS=$(awk "BEGIN {printf \"\$%.0f\", $TOKENS * 30 / 1000000}")
            fi
        fi

        # Fallback percentage parsing if line format differs
        if [ -z "$RTK_PCT" ]; then
            RTK_PCT=$(echo "$RTK_OUT" | grep -oiE '[0-9]+(\.[0-9]+)?%\s*(saved|savings|reduction)' | grep -oE '[0-9]+(\.[0-9]+)?%' | head -1)
        fi
        if [ -z "$RTK_PCT" ]; then
            RTK_PCT=$(echo "$RTK_OUT" | grep -oiE '(saved|savings|reduction)[^0-9]*([0-9]+(\.[0-9]+)?%)' | grep -oE '[0-9]+(\.[0-9]+)?%' | head -1)
        fi
        if [ -z "$RTK_PCT" ]; then
            RTK_PCT=$(echo "$RTK_OUT" | grep -i 'token' | grep -oE '[0-9]+(\.[0-9]+)?%' | head -1)
        fi

        if [ -n "$RTK_PCT" ] && [ -n "$RTK_DOLLARS" ]; then
            RTK_SEGMENT=" ${SEP} ${GREEN}RTK ${RTK_PCT} ~${RTK_DOLLARS}${R}"
        elif [ -n "$RTK_PCT" ]; then
            RTK_SEGMENT=" ${SEP} ${GREEN}RTK ${RTK_PCT}${R}"
        fi
    fi
fi

# Status line — project + timer + metrics
echo -e "${CYAN}${PROJECT}${R} ${SEP} ${YELLOW}⏱ ${TIME_FMT}${R} ${SEP} ${WHITE}${MODEL}${R} ${SEP} ${CTX}ctx ${PCT}%${R} ${SEP} ${WHITE}↓${IN_FMT} ↑${OUT_FMT}${R} ${SEP} ${WHITE}${COST_FMT}${R}${RTK_SEGMENT}"

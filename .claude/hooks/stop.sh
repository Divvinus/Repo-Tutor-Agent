#!/bin/bash
echo "Session ended at $(date '+%Y-%m-%d %H:%M')" >> .tutor/stop_log.md
echo "Progress saved."

# Note: detailed session logging is handled by context-summarizer agent.
# This hook only records the raw stop timestamp as a fallback.

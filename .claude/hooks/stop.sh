#!/bin/bash
if [ -f ".tutor/progress.md" ]; then
  echo "Session ended at $(date '+%Y-%m-%d %H:%M')" >> .tutor/session_log.md
  echo "Progress saved."
fi
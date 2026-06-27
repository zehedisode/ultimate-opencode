#!/bin/bash
plugins=(
    "opencode-helicone-session"
    "opencode-gemini-auth"
    "opencode-gitlab-plugin"
    "opencode-poe-auth"
    "opencode-subagent-statusline"
    "opencode-websearch"
    "opencode-bridge"
    "opencode-cost-tracker"
)
for p in "${plugins[@]}"; do
    npm install -g "$p" 2>/dev/null || true
done

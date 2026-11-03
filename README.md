MacOS helper to use https://github.com/ForgetMeAI/FreeDeepseekAPI as launchctl agent (start on Mac boot)

1. Adjust path to `npm_start.sh` in `ru.freedeepseekapi.npm_start.plist`
2. Adjust path to FreeDeepseekAPI in `npm_start.sh`
3. Copy `ru.freedeepseekapi.npm_start.plist` to `~/Library/LaunchAgents`
4. Make `reload_plist.sh` executable with `chmod +x reload_plist.sh` and run it. This script helps to setup agent and troubleshoot launch errors like "Bootstrap failed: 5: Input/output error"
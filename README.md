MacOS helper to use https://github.com/ForgetMeAI/FreeDeepseekAPI as launchctl agent (start on Mac boot)

# General setup

1. Adjust path to `npm_start.sh` in `ru.freedeepseekapi.npm_start.plist`
2. Adjust path to FreeDeepseekAPI in `npm_start.sh`
3. Copy `ru.freedeepseekapi.npm_start.plist` to `~/Library/LaunchAgents`
4. Make `reload_plist.sh` executable with `chmod +x reload_plist.sh` and run it. This script helps to setup agent and troubleshoot launch errors like "Bootstrap failed: 5: Input/output error"

# Multi-account setup

https://github.com/ForgetMeAI/FreeDeepseekAPI#-multi-account-pool

In FreeDeepseekAPI directory: 

1. Rename `.env.example` to `.env`, uncomment `DEEPSEEK_AUTH_DIR=./data/accounts` there
2. Create `data/accounts` directory
3. Run `npm run auth` and complete new authentication **or** copy existing deepseek-auth.json to `data/accounts` **and** rename it
4. On new authentication `data/accounts/deepseek-auth.json` should be created 
5. **Copy/rename the file** (because it will be overwritten on repeated auth), repeat steps 3-5 again to add more accounts
6. Verify setup by running `npm run`, line like `[DS-API] Loaded 2 auth account(s): account_1, account_2` should appear

## Troubleshooting when creating accounts

- confirmation codes do not arrive sometimes from DeepSeek to Yandex email, use Google accounts (for instance)
- when creating Google accounts from PC Google requires confirmation via QR-code using phone camera and registration fails if camera does not support this feature. Add new accounts directly from Android Settings in this case


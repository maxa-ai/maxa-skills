# maxa-autopilot

Connect Claude Code to the Autopilot MCP server. The plugin adds the server to Claude Code. It includes the OAuth client ID and the callback port, so you do not copy a long `claude mcp add` command. The plugin asks for one value: the name of your Autopilot environment.

This plugin works only in Claude Code. It does not work in Codex, Cortex Code, or dbt Wizard.

## Install

The name of your Autopilot environment is the text before `.autopilot.maxa.ai` in your Autopilot address.

If you use `app` (`https://app.autopilot.maxa.ai`), run this command:

```bash
claude plugin install maxa-autopilot --marketplace maxa-ai/maxa-skills
```

If you use `partners` or `maxa-internal`, add `--config` with your name:

```bash
claude plugin install maxa-autopilot --marketplace maxa-ai/maxa-skills --config autopilot_instance=partners
```

The server then connects to `https://<name>.autopilot.maxa.ai/api/mcp`.

If you use `app` and do not set `--config`, Claude Code shows the message "1 userConfig option not yet set". Ignore this message. The default name is `app`.

In a Claude Code session, you can use the interactive form:

```bash
/plugin install maxa-autopilot --marketplace maxa-ai/maxa-skills
```

Or add the marketplace and install in two steps:

```bash
/plugin marketplace add maxa-ai/maxa-skills
/plugin install maxa-autopilot@maxa-skills
```

In the interactive install, enter only the name before `.autopilot.maxa.ai`. Do not enter the full address.

## Sign in

1. Restart Claude Code.
2. Type `/mcp`.
3. Select the server `plugin:maxa-autopilot:autopilot`.
4. Select **Authenticate**.
5. Sign in with your Maxa account in the browser.

After you sign in, the Autopilot tools appear in the session.

## Troubleshooting

- **The server does not connect.** Make sure that the name has no `https://`, no `.autopilot.maxa.ai`, and no `/`. Enter only the name, for example `partners`.
- **You need to change the name.** Claude Code stores the name under `pluginConfigs` in `~/.claude/settings.json`. Change it in `/plugin manage`, then restart Claude Code.
- **The server does not show in `/mcp`.** If you added a server with `claude mcp add` that uses the same URL, Claude Code hides the plugin server. Remove the earlier server.
- **The sign-in callback fails.** A different process uses port 8765. Stop that process and try again.

## Data

The plugin contains only the MCP server configuration. It has no skills and no scripts. When you use the Autopilot tools, Claude Code sends requests to your Autopilot server at `https://<name>.autopilot.maxa.ai`. See the [Maxa privacy policy](https://maxa.ai/privacy).

## License

MIT. See [LICENSE](https://github.com/maxa-ai/maxa-skills/blob/main/LICENSE).

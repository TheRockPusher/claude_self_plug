# Claude Code Plugin Marketplace

A personal collection of plugins for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Plugin Catalog

| Plugin                                | Description                                                                  | Includes         |
| ------------------------------------- | ---------------------------------------------------------------------------- | ---------------- |
| [dev-workflow](plugins/dev-workflow/) | Development workflow: context priming, planning, implementation, git commits | 4 skills, 1 hook |

## Other Installed Plugins

This project uses additional Claude Code plugins for development:

| Plugin                                                                                                           | Purpose                                                                                      | Installation                                         |
| ---------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| [plugin-dev@claude-plugins-official](https://github.com/anthropics/claude-plugins/tree/main/plugins/plugin-dev) | Plugin development toolkit with agents, skills, and hooks for creating Claude Code plugins   | `/plugin install plugin-dev@claude-plugins-official` |

## Other Useful Plugins

Community plugins worth checking out:

| Plugin                                                       | Description                          |
| ------------------------------------------------------------ | ------------------------------------ |
| [obsidian-skills](https://github.com/kepano/obsidian-skills) | Skills for working with Obsidian vaults |

## Installation

### Via marketplace (recommended)

```bash
# Add this marketplace
/plugin marketplace add owner/claude_self_plug

# Install a plugin
/plugin install dev-workflow@claude-self-plug
```

### Direct installation

```bash
# Clone and add a plugin directly
git clone https://github.com/owner/claude_self_plug.git
claude settings plugins add ~/claude_self_plug/plugins/dev-workflow
```

### Test temporarily

```bash
claude --plugin-dir /path/to/plugins/<plugin-name>
```

## Adding New Plugins

1. Create a new directory under `plugins/`:

   ```text
   plugins/my-plugin/
   ├── .claude-plugin/
   │   └── plugin.json
   ├── skills/
   ├── hooks/
   └── README.md
   ```

2. Add `plugin.json` with metadata:

   ```json
   {
     "name": "my-plugin",
     "version": "0.1.0",
     "description": "What it does"
   }
   ```

3. Add skills, hooks, or agents as needed

4. Add to `.claude-plugin/marketplace.json`:

   ```json
   {
     "name": "my-plugin",
     "source": "./plugins/my-plugin",
     "description": "What it does",
     "category": "development"
   }
   ```

5. Update this README's plugin catalog table

## Legacy Reference

The `reference/` directory contains legacy commands and settings for reference purposes.

## License

MIT

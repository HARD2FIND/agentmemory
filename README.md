<p align="center">
  <img src="assets/banner.png" alt="agentmemory — Persistent memory for AI coding agents" width="720" />
</p>

<p align="center">
  <strong>
    Your coding agent remembers everything. No more re-explaining.
    Built on <a href="https://github.com/iii-hq/iii">iii engine</a>
  </strong></br>
  Persistent memory for Claude Code, Cursor, Gemini CLI, Codex CLI, pi, OpenCode, and any MCP client.
</p>

---

# Agentic OS Integration (Zero-Friction Deployment)

agentmemory is the core of the **Agentic OS**. We have completely refactored the deployment process so you can integrate the full stack (AgentMemory + Obsidian Second Brain + n8n Automation) into **any project** with a single command.

## 🚀 One-Command Deployment

Run this script from the root of your project. It will automatically generate your `.env`, secure your API with a random secret, create your Obsidian vault structure, and launch all services via Docker.

```bash
./scripts/deploy-agentic-os.sh
```

During the script execution, you can choose to deploy locally or on a VPS (with automatic HTTPS and reverse proxy).

### What's included in the One-Command Stack?
1. **AgentMemory Core (`iii-engine`)**: The persistent memory server on port `3111`.
2. **Real-Time Viewer (GUI)**: The web interface to browse memories on port `3113`.
3. **Obsidian FS-Watcher**: Automatically syncs bidirectional changes between your Obsidian vault and AgentMemory.
4. **n8n Automation**: The visual workflow engine on port `5678`.
5. **Caddy Reverse Proxy**: (VPS only) Auto-SSL and basicauth for secure remote access.

## 🧠 Connecting your Agent

Once the script finishes, it will output the exact JSON block you need to paste into your agent's configuration (e.g., `~/.claude/settings.json` for Claude Code or Cursor's MCP settings).

Example output:
```json
"mcpServers": {
  "agentmemory": {
    "command": "npx",
    "args": ["-y", "@agentmemory/agentmemory", "mcp"],
    "env": {
      "AGENTMEMORY_URL": "http://localhost:3111",
      "AGENTMEMORY_SECRET": "your_auto_generated_secret"
    }
  }
}
```

## 📚 Documentation

For a deep dive into the Agentic OS architecture and components:
- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed architecture design
- [MEMORY.md](MEMORY.md) - Obsidian Second Brain integration details
- [VPS_DEPLOYMENT.md](VPS_DEPLOYMENT.md) - Manual VPS hosting guide
- [AUTOMATION_N8N.md](AUTOMATION_N8N.md) - n8n workflows guide
- [SECURITY_AND_GUARDRAILS.md](SECURITY_AND_GUARDRAILS.md) - Security policies

---

*(The rest of the original agentmemory documentation follows below)*

<p align="center">
  <a href="https://gist.github.com/rohitg00/2067ab416f7bbe447c1977edaaa681e2"><img src="https://img.shields.io/badge/Viral%20GitHub%20Gist-1050%20stars%20%2F%20150%20forks-FF6B35?style=for-the-badge&logo=github&logoColor=white&labelColor=1a1a1a" alt="Design doc: 1050 stars / 150 forks on the gist" /></a>
</p>

<p align="center">
  <a href="https://www.npmjs.com/package/@agentmemory/agentmemory"><img src="https://img.shields.io/npm/v/@agentmemory/agentmemory?color=CB3837&label=npm&style=for-the-badge&logo=npm" alt="npm version" /></a>
  <a href="https://github.com/rohitg00/agentmemory/actions"><img src="https://img.shields.io/github/actions/workflow/status/rohitg00/agentmemory/ci.yml?label=tests&style=for-the-badge&logo=github" alt="CI" /></a>
  <a href="https://github.com/rohitg00/agentmemory/blob/main/LICENSE"><img src="https://img.shields.io/github/license/rohitg00/agentmemory?color=blue&style=for-the-badge" alt="License" /></a>
  <a href="https://github.com/rohitg00/agentmemory/stargazers"><img src="https://img.shields.io/github/stars/rohitg00/agentmemory?style=for-the-badge&color=yellow&logo=github" alt="Stars" /></a>
</p>

<p align="center">
  <picture><source media="(prefers-color-scheme: dark)" srcset="assets/tags/light/stat-recall.svg"><img src="assets/tags/stat-recall.svg" alt="95.2% retrieval R@5" height="38" /></picture>
  <picture><source media="(prefers-color-scheme: dark)" srcset="assets/tags/light/stat-tokens.svg"><img src="assets/tags/stat-tokens.svg" alt="92% fewer tokens" height="38" /></picture>
  <picture><source media="(prefers-color-scheme: dark)" srcset="assets/tags/light/stat-tools.svg"><img src="assets/tags/stat-tools.svg" alt="51 MCP tools" height="38" /></picture>
  <picture><source media="(prefers-color-scheme: dark)" srcset="assets/tags/light/stat-hooks.svg"><img src="assets/tags/stat-hooks.svg" alt="12 auto hooks" height="38" /></picture>
  <picture><source media="(prefers-color-scheme: dark)" srcset="assets/tags/light/stat-deps.svg"><img src="assets/tags/stat-deps.svg" alt="0 external DBs" height="38" /></picture>
  <picture><source media="(prefers-color-scheme: dark)" srcset="assets/tags/light/stat-tests.svg"><img src="assets/tags/stat-tests.svg" alt="827 tests passing" height="38" /></picture>
</p>

<p align="center">
  <img src="assets/demo.gif" alt="agentmemory demo" width="720" />
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> &bull;
  <a href="#benchmarks">Benchmarks</a> &bull;
  <a href="#vs-competitors">vs Competitors</a> &bull;
  <a href="#works-with-every-agent">Agents</a> &bull;
  <a href="#how-it-works">How It Works</a> &bull;
  <a href="#mcp-server">MCP</a> &bull;
  <a href="#real-time-viewer">Viewer</a> &bull;
  <a href="#iii-console">iii Console</a> &bull;
  <a href="#powered-by-iii">Powered by iii</a> &bull;
</p>

## Quick Start (Standalone)

If you don't want to use the full Agentic OS stack and just want the bare minimum:

```bash
npm install -g @agentmemory/agentmemory
agentmemory
```

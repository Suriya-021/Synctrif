# Synctrif AI

**Autonomous DevOps, QA & Release Orchestrator**

AI-powered PR review, test planning, and release notes generation using MCP, RAG, and Multi-Agent Orchestration.

## Architecture

- **Frontend:** Next.js 14 + Tailwind CSS
- **Backend:** Node.js (TypeScript)
- **Database:** Supabase (PostgreSQL + pgvector)
- **AI:** Google Gemini (Flash + Pro) via Vercel AI SDK
- **Protocol:** Model Context Protocol (MCP)
- **Auth:** Supabase Auth
- **Payments:** Stripe

## Features

- 🔍 Automated PR code review
- 🧪 AI-generated QA test plans grounded in historical bugs (RAG)
- 📝 Human-readable release notes
- 📡 Multi-channel publishing (GitHub PR, Slack, Notion)
- 🤖 Multi-agent orchestration with supervisor pattern

## Tech Stack (Zero-Cost)

| Layer | Technology |
|---|---|
| Frontend | Next.js 14 + Tailwind CSS (Vercel) |
| Agents | Vercel AI SDK + Google Gemini |
| Database | Supabase PostgreSQL + pgvector |
| Protocol | @modelcontextprotocol/sdk |
| Auth | Supabase Auth |
| Hosting | Vercel (frontend) + Render (backend) |

## License

MIT

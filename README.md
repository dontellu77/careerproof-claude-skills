# CareerProof Skills for Claude Code

## What is CareerProof?

CareerProof is an AI-powered career and workforce intelligence platform built for two audiences navigating the same disruption from opposite sides: **professionals** rethinking their careers in the age of AI, and **organizations** redesigning their workforce to stay competitive.

The platform operates in two modes:

- **CeeVee** (Personal Career Intelligence) — Helps individuals understand how their experience translates in a rapidly shifting market, optimize their positioning, and make data-backed career decisions.
- **Atlas** (Workforce & Org Intelligence) — Gives HR leaders, talent acquisition teams, and consultants the analytical firepower to evaluate candidates, benchmark compensation, plan workforce transitions, and generate research-grade reports on org design, skills gaps, and talent strategy.

Both modes are powered by the same intelligence engine: a curated RAG (Retrieval-Augmented Generation) knowledge base drawn from 50+ premium sources — including HBR, McKinsey, BCG, Bain, Deloitte, PwC, Gartner, Forrester, WEF, MIT, and Stanford — combined with live web research via Tavily for real-time market data.

## What's Included

This plugin bundles **everything** you need in a single install:

| Component | What You Get |
|-----------|-------------|
| **13 Skills** | Guided slash-command workflows for career and workforce tasks |
| **67 MCP Tools** | Full CareerProof API as native Claude tools (via remote MCP server) |
| **OAuth Authentication** | Automatic login flow — no API keys to manage |

## Why It Matters

The workforce is being restructured by AI at every level. Job roles are morphing, entire functions are being automated, and organizations need to redesign around capabilities that didn't exist two years ago. CareerProof bridges the gap between individual career navigation and organizational workforce strategy by grounding both in the same deep research:

- **For professionals**: Move beyond generic career advice. Get intelligence calibrated to your actual experience, industry, and seniority — drawn from the same sources that inform executive strategy.
- **For organizations**: Replace gut-feel hiring and ad-hoc workforce planning with structured analysis. Evaluate talent against competency frameworks, benchmark against market data, and generate the kind of research reports that previously required expensive consulting engagements.

## The Intelligence Engine

Every CareerProof skill and tool is backed by a three-layer intelligence stack:

1. **Expert-Curated RAG** — A knowledge base of career, compensation, and workforce intelligence aggregated from premium research sources (McKinsey, BCG, HBR, Gartner, Forrester, WEF, and 50+ others). Updated 3x daily with executive-focused queries spanning 25+ industries.
2. **Live Web Research** — Real-time search and extraction via Tavily APIs, grounded in current market conditions rather than stale training data. Search results are automatically stored back into the knowledge base, making it smarter over time.
3. **CV/Candidate Context** — When available, analysis is calibrated to actual experience: role, seniority, industry, function, skills, and career trajectory. This transforms generic insights into personalized intelligence.

## Installation

### Claude Code (One Command)

```bash
# Add the marketplace and install
/plugin marketplace add careerproof-labs/careerproof-skills
/plugin install careerproof-skills@careerproof
```

That's it. The plugin installs both the skills and the MCP server connection. On first use, you'll be prompted to authenticate via OAuth — no API keys needed.

### Gemini CLI

**1. Install skills:**

```bash
# Clone the repo
git clone https://github.com/careerproof-labs/careerproof-skills.git
cd careerproof-skills

# Install globally (all projects)
bash gemini/install.sh --global

# Or install to current project only
bash gemini/install.sh
```

Windows:
```powershell
.\gemini\install.ps1 -Global
```

**2. Connect the MCP server:**

Add to your Gemini CLI settings (`~/.gemini/settings.json`):

```json
{
  "mcpServers": {
    "careerproof": {
      "url": "https://mcp.careerproof.ai/mcp/bearer",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY_HERE"
      }
    }
  }
}
```

Replace `YOUR_API_KEY_HERE` with your CareerProof API key (`cpk_...`).

**3. Verify:** Start Gemini CLI and run `/mcp` to confirm the server is connected.

## Skills Overview

### Atlas Skills — Workforce & Org Intelligence (9 skills)

| Skill | Purpose | Cost |
|-------|---------|------|
| **atlas-onboard** | Set up a hiring context — company profile, candidate CVs, job descriptions | Free |
| **atlas-gem** | GEM competency analysis — 10-factor scoring with strengths, gaps, and development areas | 5-10 credits |
| **atlas-fit** | CV-to-JD matching — fit scoring with strengths, gaps, and market context | 8 credits |
| **atlas-interview** | Interview question generation with configurable pressure levels + follow-up probing | 8 credits + 1/follow-up |
| **atlas-shortlist** | Batch evaluate and rank multiple candidates against a JD | 8-13 credits/candidate |
| **atlas-custom-eval** | Build custom hiring rubrics — upload examples, infer AI rubrics, batch-evaluate | Free setup, 5 credits/candidate |
| **atlas-jd-review** | Analyze a JD for quality, bias, salary benchmarks, and skills extraction | 5 credits |
| **atlas-chat** | Workforce intelligence chat — salary data, talent supply/demand, competitor intel | 2-3 credits/message |
| **atlas-report** | Generate research-grade PDF reports across 16 types | 15 credits/report |

#### Atlas Report Types (16)

**Recruitment:** Talent market landscape, salary benchmarking, competitor talent analysis, sourcing strategy

**Workforce Planning:** Skills gap analysis, succession planning, workforce demographics, attrition risk

**Strategic HR:** DEI assessment, employer branding, L&D strategy, org design, employee engagement, total rewards, HR technology, change management

### CeeVee Skills — Personal Career Intelligence (4 skills)

| Skill | Purpose | Cost |
|-------|---------|------|
| **ceevee-optimize** | Full interactive CV positioning pipeline — market analysis, career opportunities, targeted edits with trade-offs | 13 credits |
| **ceevee-quick-review** | Fast autonomous CV review in a single call — positioning, lens, and edits without interactive steps | 10 credits |
| **ceevee-career-intel** | Career intelligence chat with live web research, RAG knowledge base, and CV-aware personalization | 2 credits/message |
| **ceevee-report** | Generate career intelligence PDF reports — 17 types covering compensation, strategy, risk, and development | 15 credits/report |

#### CeeVee Report Types (17)

**Compensation & Offers:** Compensation benchmark, rate card, offer comparison

**Career Strategy:** Role evolution, pivot feasibility, learning path, career gap narrative

**Risk & Disruption:** AI displacement risk, skill decay risk, employer red flag

**Market Intelligence:** Industry switch, relocation impact, startup vs corporate

**Professional Development:** Credential ROI, interview prep, board readiness, fractional leadership

## MCP Tools (67)

When the MCP server is connected, you also get direct access to all 67 tools:

| Category | Tools | Examples |
|----------|-------|---------|
| **Universal** | 2 | Task status polling, result fetching |
| **Atlas CRUD** | 9 | Create contexts, upload candidates, manage JDs, analytics |
| **Atlas Analysis** | 4 | GEM competency analysis (full/lite/career_path), JD analysis |
| **Atlas Batch & Reports** | 13 | Batch GEM, batch JD-FIT, custom eval batch, report generation |
| **Atlas FIT & Utilities** | 5 | Enhanced fit match, fit ranking, interview generation, follow-ups |
| **Atlas Custom Eval** | 12 | Model CRUD, artifact upload, rubric inference, rubric overrides |
| **Atlas Chat** | 2 | Full workforce chat (live tools), lightweight advisor chat |
| **CeeVee Core** | 5 | CV upload, version management, session tracking |
| **CeeVee Analysis** | 4 | Positioning pipeline (3-step), autonomous full review |
| **CeeVee Reports** | 5 | Report generation, polling, download, listing |
| **CeeVee Chat** | 2 | Career intelligence chat, edit explanations |

Full tool catalog: [MCP Server Docs](https://mcp.careerproof.ai/docs)

## Usage

Once installed, invoke any skill by name:

```
# Atlas — Workforce & Hiring
/atlas-onboard          # Set up a new hiring context
/atlas-gem              # Run competency analysis on a candidate
/atlas-fit              # Match candidate(s) against a JD
/atlas-interview        # Generate tailored interview questions
/atlas-shortlist        # Batch evaluate and rank candidates
/atlas-custom-eval      # Build custom evaluation rubrics
/atlas-jd-review        # Analyze a job description
/atlas-chat             # Workforce intelligence Q&A
/atlas-report           # Generate workforce research reports

# CeeVee — Personal Career
/ceevee-optimize        # Full interactive CV optimization pipeline
/ceevee-quick-review    # Fast single-call CV review
/ceevee-career-intel    # Career intelligence chat
/ceevee-report          # Generate career intelligence reports
```

Skills accept optional arguments:

```
/atlas-report org design                    # Jump straight to org design report
/atlas-gem Sarah                            # Run GEM on a candidate named Sarah
/atlas-jd-review Senior Data Engineer       # Review a JD for this role
/ceevee-career-intel salary trends in AI    # Start with a salary question
/ceevee-report AI displacement risk         # Generate a specific report type
```

Or use MCP tools directly in conversation:

```
"Upload this CV and run a competency analysis"
"Compare these 5 candidates against the product manager JD"
"What's the salary benchmark for a senior data engineer in London?"
"Build a custom eval model for our data engineering hiring"
"Generate an AI displacement risk report for my role"
```

## Authentication

### Claude Code
OAuth is built in. On first use, a browser window opens for you to log in to CareerProof. Tokens are managed automatically after that.

### Gemini CLI / Programmatic Access
Use a bearer token (`cpk_...` API key) in the MCP server configuration. Get your API key at [careerproof.ai](https://careerproof.ai).

## Requirements

- An active CareerProof account with available credits
- Claude Code or Gemini CLI
- Get your account at [careerproof.ai](https://careerproof.ai)

## Links

- [CareerProof Platform](https://careerproof.ai)
- [MCP Server Docs](https://mcp.careerproof.ai/docs)
- [GitHub](https://github.com/careerproof-labs/careerproof-skills)
- [Support](mailto:support@careerproof.ai)

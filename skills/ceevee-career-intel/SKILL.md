---
name: ceevee-career-intel
description: Career intelligence chat powered by live web research and knowledge base. Get salary benchmarks, market trends, industry insights, skill gap analysis, and strategic career advice grounded in real data. Use when you need career intelligence, salary data, market research, or strategic career guidance.
disable-model-invocation: true
argument-hint: "[topic or question]"
---

# CeeVee Career Intel — AI Career Intelligence Chat

Start a career intelligence conversation with live web research, knowledge base context, and optional CV-awareness for personalized insights.

## Workflow

### Step 1: Set Up Context (FREE)

**Check for existing CV (optional but recommended):**
1. Call `ceevee_list_versions` to see if the user has uploaded CVs
2. If a CV exists, save the `cv_version_id` of the main version
   - CV context makes responses personalized to the user's seniority, industry, and skills
3. If no CV exists, that's fine — career intel works without one

**Check for existing conversations:**
1. Optionally call `ceevee_list_versions` to check for prior chat history
   - The user may want to continue an existing conversation thread

### Step 2: Start the Conversation (2 credits/message)

If the user provided a topic as `$ARGUMENTS`, use it as the first message. Otherwise, ask what they want to explore.

**Suggested starter topics:**
- "What's the salary range for [role] in [location]?"
- "What skills are most in-demand for [industry] in 2026?"
- "How is AI disrupting [function/industry]?"
- "What career paths lead from [current role] to [target role]?"
- "What should I negotiate for in a [role] offer?"
- "Compare compensation packages: [Company A] vs [Company B]"
- "What certifications matter most for [field]?"
- "How does the job market look for [role] in the next 12 months?"

Call `ceevee_chat` with:
- `message` — The user's question or topic
- `cv_version_id` — If available from Step 1
- `conversation_id` — Omit for first message, include for follow-ups

The response includes:
- **AI analysis** grounded in live web search and knowledge base
- **Sources** — Citations from both KB documents and live search results
- **Conversation ID** — Save this for follow-up messages

### Step 3: Continue the Thread (2 credits/message)

For follow-up questions, always pass the `conversation_id` from Step 2 to maintain conversation context.

The AI retains context from prior messages in the thread, so the user can:
- Drill deeper into a topic ("Tell me more about the AI skills gap")
- Compare alternatives ("How does that compare to cloud architecture roles?")
- Get actionable advice ("What steps should I take in the next 3 months?")
- Request specifics ("What companies in London are hiring for this?")

### Step 4: Alternative Channels

Depending on what the user needs, other tools may be more appropriate:

**For compensation-specific advice:**
- Use `atlas_advisor_chat` (2 credits) for lightweight hiring/compensation questions
- Use `atlas_chat` (3 credits) for workforce intelligence with live tool access to salary benchmarking, supply/demand analysis, and competitor intel

**For CV-specific optimization:**
- Direct to `/ceevee-optimize` for the full positioning pipeline

**For comprehensive research:**
- Direct to `/atlas-report` for a full PDF research report (15 credits)

## Credit Cost

| Action | Cost |
|--------|------|
| Check CV versions | FREE |
| Each chat message | 2 credits |
| Explain a CV edit | 1 credit |

**Typical session:** 3-5 messages = **6-10 credits**

## What Career Intel Covers

The AI combines three intelligence sources for every response:

1. **Knowledge Base** — Curated career intelligence from HBR, McKinsey, BCG, Gartner, and 50+ premium sources, refreshed 3x daily
2. **Live Web Search** — Real-time Tavily search for current salary data, job postings, and market trends
3. **CV Context** (when available) — Personalized to the user's experience level, industry, function, and skill profile

**Best for:**
- Salary and compensation intelligence
- Market trends and industry disruption analysis
- Skill gap identification and upskilling priorities
- Career trajectory planning and pivot analysis
- Negotiation preparation and offer comparison
- Industry-specific hiring trends

**Not for:**
- CV editing (use `/ceevee-optimize`)
- Candidate evaluation (use `/atlas-gem`, `/atlas-fit`, or `/atlas-shortlist`)
- Full research reports (use `/atlas-report`)

## Tips

- Including a CV makes responses significantly more relevant — the AI calibrates to seniority and industry
- Career intel automatically stores live search findings to the knowledge base, improving future responses
- For salary questions, be specific about role, location, and seniority for the most accurate data
- Conversations are persistent — you can return to a thread later by passing the same `conversation_id`
- Each message costs 2 credits regardless of response length — batch related questions together

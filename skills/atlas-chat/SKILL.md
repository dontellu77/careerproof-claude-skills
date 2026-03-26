---
name: atlas-chat
description: Conversational workforce intelligence — salary benchmarks, talent supply/demand data, competitor hiring intel, and hiring advice powered by live tools. Use this skill whenever a recruiter or hiring manager asks workforce questions like "what's the talent supply for X in Y", "what salary should I offer", "how are competitors hiring", "what's the market rate", or "should I include equity in this offer". Also triggers on hiring advice, compensation strategy, counter-offer guidance, or talent market questions. For quick simple hiring questions use the lightweight advisor (2 credits); for data-heavy questions use the full chat with live tools (3 credits). This is for RECRUITER/TA workforce questions — for personal career/salary questions as a job seeker, use ceevee-career-intel instead.
disable-model-invocation: true
argument-hint: "[question or topic]"
---

# Atlas Chat — Workforce Intelligence

Conversational workforce intelligence powered by live tools. Get salary benchmarks, talent supply/demand data, competitor intel, and hiring advice.

## Workflow

### Step 1: Determine Complexity

Choose the right tool based on the question:

**Simple hiring questions** → `atlas_advisor_chat` (2 credits, fast)
- "Should I include equity in this offer?"
- "What's a reasonable notice period for a VP?"
- "How should I structure this compensation package?"

**Data-heavy workforce questions** → `atlas_chat` (3 credits, live tools)
- "What's the talent supply for React developers in Berlin?"
- "Compare salaries for data scientists across NYC, London, and Singapore"
- "Which competitors are hiring aggressively for ML engineers?"

### Step 2: Set Up Context (FREE, optional)

Call `atlas_list_contexts` to check for existing hiring contexts. If one exists, pass `context_id` to the chat for context-aware responses.

### Step 3: Start Conversation

If the user provided a topic as `$ARGUMENTS`, use it as the first message. Otherwise, ask what they want to know.

**For simple questions:**
Call `atlas_advisor_chat` with `message`. Fast response, no live tool execution.

**For data questions:**
Call `atlas_chat` with `message` and optional `context_id`. May take 2-3 minutes as it executes live tools (salary APIs, talent supply data, competitor intel).

Optional: Include `conversation_id` from a previous response to continue a thread.

### Step 4: Follow-Up Questions

For follow-ups, always pass `conversation_id` to maintain context. The AI retains the thread history.

The user can:
- Drill deeper: "Break that down by seniority level"
- Compare: "How does that compare to the European market?"
- Get actionable: "Based on this data, what should our offer look like?"

### Step 5: When to Escalate

If the user needs more than chat can provide:
- **Full research report:** Direct to `/atlas-report` (15 credits) for a comprehensive PDF
- **Candidate evaluation:** Direct to `/atlas-gem`, `/atlas-fit`, or `/atlas-shortlist`
- **JD analysis:** Direct to `/atlas-jd-review` for job description quality check

## Credit Cost

| Action | Cost |
|--------|------|
| Advisor chat (lightweight) | 2 credits/message |
| Full workforce chat (live tools) | 3 credits/message |

**Typical session:** 3-5 messages = **6-15 credits**

## Tips

- `atlas_advisor_chat` is faster and cheaper — use for quick hiring questions that don't need data
- `atlas_chat` has live tool access (salary APIs, talent supply data) — use for data-heavy questions
- `atlas_chat` may take 2-3 minutes for complex queries due to live tool execution — set expectations
- Pass `conversation_id` for follow-up questions to maintain context
- For comprehensive research that you'll reference later, suggest `/atlas-report` instead (one-time 15 credits vs multiple chat messages)
- If you have a hiring context, pass `context_id` for more relevant responses

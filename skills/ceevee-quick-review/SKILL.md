---
name: ceevee-quick-review
description: Quick autonomous CV review in a single call — positioning analysis, lens detection, and targeted edits without interactive steps. 10 credits, 30-60 seconds. Use this skill whenever someone asks for a "quick review", "fast feedback", "just review my CV", or wants a one-shot CV analysis without going through the interactive 3-step pipeline. Especially useful when the user has a specific JD to target against. Also triggers on "ceevee full review", "autonomous CV review", or when the user seems in a hurry. For the interactive 3-step pipeline where the user chooses their lens and explores opportunities, use ceevee-optimize instead.
disable-model-invocation: true
argument-hint: "[role or 'with JD']"
---

# CeeVee Quick Review — Fast Autonomous CV Review

Fast single-call CV review that combines positioning analysis, lens detection, and targeted edits into one autonomous pass. Faster and cheaper than the full `/ceevee-optimize` pipeline.

## MCP Tools

| Tool | Cost | Notes |
|------|------|-------|
| `ceevee_upload_cv` | FREE | Upload CV (PDF/DOCX) |
| `ceevee_list_versions` | FREE | Find existing CVs |
| `ceevee_full_review` | 10 credits | Single-call autonomous review (sync 30-60s) |
| `ceevee_explain_change` | 1 credit | Explain individual edits (sync) |
| `ceevee_get_positioning_session` | FREE | Retrieve session data later |

## Workflow

### Step 1: Upload or Find CV (FREE)

Ask the user for their CV file (PDF or DOCX), or call `ceevee_list_versions` to find existing versions.

Call `ceevee_upload_cv` with base64-encoded file if uploading new. Save `cv_version_id`.

### Step 2: Collect Options

Ask the user (all optional):
- **Target lens** — e.g., "Technical Leader", "Scale-up Builder" (or let AI infer from CV)
- **Job description** — Paste JD text for role-targeted optimization
- **Include opportunities** — Whether to include career pivot suggestions (boolean)

### Step 3: Run Quick Review (10 credits)

Call `ceevee_full_review` with:
- `cv_version_id` (required)
- `requested_lens` (optional — let AI infer if not specified)
- `jd_text` (optional — for role-targeted optimization)
- `include_opportunities` (optional boolean)
- `session_id` (optional — link to existing positioning session)

Takes 30-60 seconds. **Confirm 10 credit cost before running.**

### Step 4: Present Results

**Important:** The response is large. Parse and present concisely:

1. **Positioning snapshot** and detected lens
2. **Recruiter inference** — What a recruiter would assume
3. **Edits summary** — For each edit:
   - **Section** being modified
   - **Key changes** — 1-2 sentence summary
   - **Trade-off** — What this edit gains vs. sacrifices
4. **Opportunities** (if included)

Offer to show full before/after text for any specific section the user wants to see in detail.

### Step 5: Optional — Explain Edits (1 credit each)

If the user wants deeper reasoning on a specific edit:

Call `ceevee_explain_change` with `cv_version_id` and the `change_id` from the edits array.

### Step 6: Next Steps

- `/ceevee-optimize` for the interactive 3-step pipeline with more control over lens and opportunities
- `/ceevee-career-intel` for market research and salary data
- `/ceevee-report` for comprehensive PDF career intelligence reports

## Credit Cost

| Action | Cost |
|--------|------|
| Upload CV | FREE |
| Quick review | 10 credits |
| Explain edit | 1 credit each |

## Tips

- Quick review is 10 credits vs 13 for the full pipeline — faster and cheaper
- Pass `jd_text` for role-targeted optimization — the AI aligns edits to the specific JD
- If the user wants more control over lens/opportunities, direct them to `/ceevee-optimize`
- Response is large — always parse and summarize, never dump raw response
- Session persists — call `ceevee_get_positioning_session` to retrieve data later

---
name: ceevee-optimize
description: Full interactive CV optimization pipeline — upload your CV, get market positioning analysis, explore career pivot opportunities, then receive targeted section-by-section edits with trade-offs. 3-step process where YOU choose the lens and opportunities. Use this skill whenever someone asks to optimize their CV, improve their resume, reposition their career narrative, fix mixed signals in their CV, get CV edits with trade-offs, or run the positioning pipeline. Also triggers on "help me with my CV", "my resume needs work", "how does the market read my CV", or "I'm pivoting careers and need to update my resume". For a faster non-interactive review, use ceevee-quick-review instead (10 credits, single call).
disable-model-invocation: true
---

# CeeVee Optimize — CV Positioning Pipeline

Upload a CV and run the full 3-step positioning pipeline: market analysis, opportunity exploration, and targeted edits with before/after suggestions.

## MCP Tools

| Tool | Cost | Notes |
|------|------|-------|
| `ceevee_upload_cv` | FREE | Upload CV (PDF/DOCX) |
| `ceevee_list_versions` | FREE | Find existing CVs |
| `ceevee_analyze_positioning` | 5 credits | Step 1: Market positioning (sync 20-30s) |
| `ceevee_get_opportunities` | 3 credits | Step 2: Career pivots (sync 20-30s) |
| `ceevee_confirm_lens` | 5 credits | Step 3: Targeted edits (sync 20-30s) |
| `ceevee_explain_change` | 1 credit | Optional: explain individual edits (sync) |
| `ceevee_get_positioning_session` | FREE | Retrieve session data later |

## Workflow

### Step 1: Upload CV (FREE)

Ask the user for their CV file (PDF or DOCX).

Call `ceevee_upload_cv` with the file (base64 encoded) and optional filename.

Save the returned `cv_version_id`. The response includes parsed sections and word count — briefly confirm the CV was parsed correctly.

If the user already has a CV uploaded, call `ceevee_list_versions` to find existing versions instead.

### Step 2: Market Positioning Analysis (5 credits)

Run the positioning analysis to understand how the CV reads to the market:

Call `ceevee_analyze_positioning` with `cv_version_id`.

This takes 20-30 seconds. Save the returned `session_id` for subsequent steps.

Present the results:
- **Positioning snapshot** — How the market currently reads this CV
- **Detected narrative lens** — The strongest story the CV tells (e.g., "Technical Leader", "Scale-up Builder")
- **Recruiter inference** — What a recruiter would assume about this person
- **Mixed signal flags** — Where the CV sends contradictory messages

Ask the user if the detected lens matches their intent, or if they want to explore alternatives.

### Step 3: Career Opportunities (3 credits)

Explore career pivots and opportunities based on the CV and selected lens:

Call `ceevee_get_opportunities` with `cv_version_id`, the `lens` from Step 2, and `session_id`.

This takes 20-30 seconds.

Present 2-4 career opportunities, each with:
- Opportunity title and description
- Rationale (why this person is suited)
- CV signals that support the pivot
- Market context

Ask the user which opportunities interest them, or if they want to proceed with the original lens.

### Step 4: Targeted Edits (5 credits)

Generate section-by-section CV edits with trade-off analysis:

Call `ceevee_confirm_lens` with:
- `cv_version_id`
- `confirmed_lens` — The lens the user chose (detected or custom)
- `session_id`
- Optionally include `positioning_snapshot`, `detected_lens_full`, `recruiter_inference`, and `selected_opportunities` from prior steps for richer edits
- Optionally include `custom_positioning` if the user described their own positioning

This takes 20-30 seconds.

**Important:** The `ceevee_confirm_lens` response can be very large (50,000-100,000+ characters) because it contains full before/after text for every CV section. Do not try to display the raw response. Instead:

1. Parse the response to extract the `edits` array
2. For each edit, present a concise summary:
   - **Section** being modified
   - **Key changes** — A 1-2 sentence summary of what changed
   - **Trade-off** — What this edit gains vs. what it sacrifices
3. Offer to show the full before/after text for any specific section the user wants to see in detail

This keeps the output readable while giving the user access to the full detail on demand.

### Step 5: Optional — Explain Individual Edits (1 credit each)

If the user wants deeper reasoning on any specific edit:

Call `ceevee_explain_change` with `cv_version_id` and the `change_id` from the edits array.

### Step 6: Next Steps

- `/ceevee-career-intel` for salary data and market research
- `/ceevee-report` for comprehensive career intelligence reports
- Session persists: `ceevee_get_positioning_session(session_id)` retrieves all data later

## Credit Cost

| Step | Cost |
|------|------|
| Upload CV | FREE |
| Positioning analysis | 5 credits |
| Opportunities | 3 credits |
| Targeted edits | 5 credits |
| Explain edit | 1 credit each |
| **Pipeline total** | **13 credits** |

## Tips

- The 3-step pipeline gives the user more control — they choose the lens and opportunities before edits are generated
- For a faster single-call alternative, use `/ceevee-quick-review` (10 credits)
- If the user has a specific target role, suggest `/ceevee-quick-review` with `jd_text` instead
- Edits include trade-off notes — always present these so the user can make informed decisions
- The session persists — call `ceevee_get_positioning_session` with `session_id` to retrieve all data later

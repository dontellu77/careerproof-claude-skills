---
name: ceevee-optimize
description: Full CV optimization pipeline — upload your CV, get market positioning analysis, explore career opportunities, and receive targeted section-by-section edits with trade-offs. Use when you want to improve, optimize, or reposition your CV/resume.
disable-model-invocation: true
---

# CeeVee Optimize — CV Positioning Pipeline

Upload a CV and run the full 3-step positioning pipeline: market analysis, opportunity exploration, and targeted edits with before/after suggestions.

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

Present each edit with:
- **Section** being modified
- **Before text** — Current version
- **After text** — Suggested revision
- **Trade-off notes** — What this change gains and what it sacrifices

### Step 5: Optional — Explain Individual Edits (1 credit each)

If the user wants deeper reasoning on any specific edit:

Call `ceevee_explain_change` with `cv_version_id` and the `change_id` from the edits array.

### Step 6: Optional — Interactive Discussion (2 credits/message)

For ongoing CV coaching:

Call `ceevee_chat` with `cv_version_id` and the user's message. Include `conversation_id` from previous messages to maintain context.

### Step 7: Alternative — Quick Review (10 credits)

If the user wants everything in one call instead of the 3-step pipeline:

Call `ceevee_full_review` with:
- `cv_version_id`
- `requested_lens` (optional — let AI infer if not specified)
- `jd_text` (optional — for role-targeted optimization)
- `include_opportunities` (boolean)

This runs the full pipeline autonomously in 30-60 seconds and costs 10 credits (vs 13 for the 3-step pipeline).

## Credit Cost

| Step | Cost |
|------|------|
| Upload CV | FREE |
| Positioning analysis | 5 credits |
| Opportunities | 3 credits |
| Targeted edits | 5 credits |
| Explain edit | 1 credit each |
| Chat follow-up | 2 credits/message |

**3-step pipeline total:** 13 credits
**Quick review alternative:** 10 credits

## Tips

- The 3-step pipeline gives the user more control — they choose the lens and opportunities before edits are generated
- The quick review is faster and cheaper but less interactive
- If the user has a specific target role, pass `jd_text` to `ceevee_full_review` for role-targeted optimization
- Edits include trade-off notes — always present these so the user can make informed decisions
- The session persists — call `ceevee_get_positioning_session` with `session_id` to retrieve all data later

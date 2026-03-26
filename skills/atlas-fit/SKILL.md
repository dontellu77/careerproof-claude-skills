---
name: atlas-fit
description: Match candidates against a job description — CV-to-JD fit scoring with strengths, gaps, and market context. Use this skill whenever someone asks to match a CV against a JD, check fit score, compare a candidate to role requirements, see how well someone aligns with a position, rank a few candidates against a JD, or run a FIT match. Also triggers on "does this person match the role", "how well do they fit", or "compare CV to job description". For batch ranking of many candidates (5+), use atlas-shortlist instead. For competency scoring without a JD, use atlas-gem.
disable-model-invocation: true
argument-hint: "[candidate name or 'rank all']"
---

# Atlas FIT — CV-to-JD Matching

Match a single candidate or rank multiple candidates against a job description. Returns fit scores, strengths, gaps, and market context.

## Workflow

### Step 1: Identify Candidates and JD (FREE)

1. Call `atlas_list_contexts` to find the hiring context
2. Call `atlas_list_candidates` with `context_id` to find candidates
3. Call `atlas_list_jds` with `context_id` to get the job description

If no context/candidates/JD exist, direct user to `/atlas-onboard` first.

### Step 2: Determine Mode

**Single candidate** — Use `atlas_fit_match_enhanced` (synchronous, preferred)
**Multiple candidates** — Use `atlas_start_fit_rank` (async, min 2 candidates)

For batch matching of many candidates (5+), recommend `/atlas-shortlist` instead (3 credits/candidate vs 8).

### Step 3a: Single Candidate Match (8 credits)

Call `atlas_fit_match_enhanced` with `context_id`, `candidate_id`, and `jd_text`.

This is synchronous — no polling needed. Returns:
- **Fit score** (0-100)
- **Strengths** — Where the candidate aligns with the JD
- **Gaps** — Where the candidate falls short
- **Market context** — KB-augmented recommendations and benchmarks

Present the results with actionable insights.

### Step 3b: Multi-Candidate Ranking (8 credits)

1. Call `atlas_start_fit_rank` with `context_id`, `candidate_ids` (min 2), and `jd_text`
   - This is async — save the returned `task_id`

2. Poll `careerproof_task_status` with `task_id` every 5-10 seconds until `completed`

3. Retrieve results and present ranked list with scores

### Step 4: Next Steps

After presenting results, offer:
- **Competency deep-dive:** Run `/atlas-gem` on top candidates
- **Interview prep:** Run `/atlas-interview` to generate tailored questions
- **Full shortlist:** Run `/atlas-shortlist` for batch evaluation of many candidates

## Credit Cost

| Action | Cost |
|--------|------|
| Setup & identification | FREE |
| Single FIT match (enhanced) | 8 credits |
| Multi-candidate ranking | 8 credits |

## Tips

- `atlas_fit_match_enhanced` is synchronous and includes KB-augmented market context — preferred for single candidates
- `atlas_start_fit_rank` requires minimum 2 candidates
- For batch matching of many candidates, use `/atlas-shortlist` instead (3 credits/candidate vs 8 — much cheaper at scale)
- JD text is required — get it from `atlas_list_jds` or ask the user to paste it
- Fit score ranges: 80+ = strong match, 60-79 = moderate, below 60 = weak

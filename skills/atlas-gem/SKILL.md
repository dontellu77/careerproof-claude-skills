---
name: atlas-gem
description: Run GEM competency analysis on a single candidate — 10-factor scoring with strengths, gaps, development areas, and cultural inference. Use this skill whenever someone asks to score, assess, or evaluate a candidate's competencies, run a GEM analysis, check a candidate's strengths and weaknesses, do a talent evaluation, or get a competency breakdown. Also use when asking for gem_full, gem_lite, or career_path analysis. This is for SINGLE candidate analysis only — for batch scoring across multiple candidates, use atlas-shortlist instead.
disable-model-invocation: true
argument-hint: "[candidate name]"
---

# Atlas GEM — Competency Analysis

Run a GEM competency analysis on a single candidate. Choose from full 10-factor scoring, lightweight snapshot, or career trajectory mapping.

## Workflow

### Step 1: Identify the Candidate (FREE)

1. Call `atlas_list_contexts` to find the hiring context
2. Call `atlas_list_candidates` with `context_id` to find the candidate
3. Call `atlas_get_candidate` with `context_id` and `candidate_id` to:
   - Verify CV parsing is `completed`
   - Review the parsed CV content

If no context/candidates exist, direct user to `/atlas-onboard` first.

### Step 2: Check for Existing Analyses (FREE)

Call `atlas_list_analyses` with `context_id` and `candidate_id` to check if a GEM analysis already exists.

If a matching analysis type exists (e.g., `ypgem_full`, `ypgem_lite`, or `career_path`):
1. Call `atlas_get_analysis` with the existing `analysis_id` to get full detailed results
2. Present those results to the user — no need to spend credits on a new analysis
3. Skip Steps 3 and 4, go directly to Step 5 (Present Results)
4. Mention to the user that you reused an existing analysis and how many credits were saved

### Step 3: Choose Analysis Depth

Ask the user which analysis type:
- **gem_full** (10 credits) — Full 10-factor competency scoring with detailed breakdown
- **gem_lite** (5 credits) — Lightweight competency snapshot
- **career_path** (5 credits) — Career trajectory and progression mapping

Confirm the credit cost before proceeding.

### Step 4: Run Analysis (5-10 credits)

1. Call `atlas_start_gem_analysis` with `context_id`, `candidate_id`, and `analysis_type`
   - This is async — save the returned `task_id` and `analysis_id`

2. Poll `careerproof_task_status` with `task_id` every 5-10 seconds until `status` is `completed`

3. Call `atlas_get_analysis` with `analysis_id` to get full results

### Step 5: Present Results

Present the GEM results:
- **Overall score** and rating
- **Competency breakdown** — Scores across all factors
- **Top strengths** — Highest-scoring competencies
- **Development areas** — Lowest-scoring competencies with improvement recommendations
- **Recommendations** — Overall assessment and next steps

### Step 6: Next Steps

After presenting results, offer:
- **JD matching:** Run `/atlas-fit` to see how the candidate matches a specific role
- **Interview prep:** Run `/atlas-interview` to generate tailored interview questions
- **Batch analysis:** Run `/atlas-shortlist` to compare against other candidates
- **Full report:** Run `/atlas-report` for a comprehensive research report

## Credit Cost

| Action | Cost |
|--------|------|
| Setup & identification | FREE |
| Check existing analyses | FREE |
| GEM Full analysis | 10 credits |
| GEM Lite analysis | 5 credits |
| Career Path analysis | 5 credits |

## Tips

- Check `atlas_list_analyses` first to avoid re-running existing analyses — saves credits
- gem_full gives the most comprehensive 10-factor breakdown — best for final-stage candidates
- gem_lite is good for initial screening — faster and cheaper
- career_path focuses on trajectory and progression mapping — best for leadership pipeline assessment
- If no context exists, direct user to `/atlas-onboard` first

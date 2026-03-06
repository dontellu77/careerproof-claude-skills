---
name: atlas-shortlist
description: Batch evaluate and rank multiple candidates against a job description to produce a hiring shortlist. Use when you need to screen, score, rank, or shortlist candidates for a role.
disable-model-invocation: true
---

# Atlas Shortlist — Batch Evaluate & Rank Candidates

Run batch GEM competency analysis and JD-FIT matching across multiple candidates, then produce a ranked shortlist.

## Workflow

### Step 1: Identify Context and Candidates (FREE)

1. Call `atlas_list_contexts` to find the hiring context
   - If none exists, direct user to `/atlas-onboard` first
2. Call `atlas_list_candidates` with `context_id` to get all candidates
3. Call `atlas_list_jds` with `context_id` to get the job description
   - If no JD exists, ask user for JD text and call `atlas_create_jd`

Save `context_id`, all `candidate_ids`, and the JD content.

### Step 2: Batch GEM Analysis (10 credits/candidate)

Run competency scoring across all candidates:

1. Ask the user which analysis depth they want:
   - **gem_full** (10 credits/candidate) — Full 10-factor competency analysis
   - **gem_lite** (5 credits/candidate) — Lightweight competency snapshot
   - **career_path** (5 credits/candidate) — Career trajectory mapping

2. Confirm the total credit cost: `cost_per_candidate x number_of_candidates`

3. Call `atlas_start_batch_gem` with `context_id`, `candidate_ids`, and `analysis_type`
   - This is async — save the returned `job_id`

4. Poll `atlas_get_batch_gem_status` with `job_id` every 10-15 seconds until status is `completed`

5. Call `atlas_get_batch_gem_results` with `job_id` to get all results

### Step 3: Batch JD-FIT Matching (3 credits/candidate)

Match all candidates against the job description:

1. Confirm the additional credit cost: `3 x number_of_candidates`

2. Call `atlas_start_jd_fit_batch` with `context_id`, `candidate_ids`, and optionally `jd_content`
   - This is async — save the returned `batch_id`

3. Poll `atlas_get_jd_fit_batch_status` with `context_id` and `batch_id` every 10-15 seconds until `completed`

4. Call `atlas_get_jd_fit_results` with `context_id` to get ranked results with fit scores
   - **Fallback:** If `atlas_get_jd_fit_results` returns an error, use the ranking data from `atlas_get_jd_fit_batch_status` instead — it includes candidate scores and rankings in the completed response

### Step 4: Build the Shortlist

Combine GEM competency scores with JD-FIT rankings to present a shortlist:

1. Present a ranked table with:
   - Candidate name
   - GEM overall score
   - JD-FIT score (0-100)
   - Top strengths (from FIT results)
   - Key gaps (from FIT results)

2. Recommend the top 3-5 candidates as the shortlist

3. For each shortlisted candidate, optionally call `atlas_get_candidate` to review their full parsed CV

### Step 5: Optional — Analytics Dashboard (FREE)

Call `atlas_get_analytics` with `context_id` for a visual summary of:
- Candidate distribution across score ranges
- Analysis coverage metrics
- Fit score distributions

### Step 6: Next Steps

For each shortlisted candidate, offer:
- **Interview prep:** Call `atlas_generate_interview` (8 credits) for tailored questions
- **Deep evaluation:** `/atlas-deep-eval` for a full single-candidate deep-dive
- **Research report:** `/atlas-report` for market context on the role

## Credit Cost

| Step | Cost |
|------|------|
| Setup & identification | FREE |
| Batch GEM (full) | 10 credits x candidates |
| Batch GEM (lite/path) | 5 credits x candidates |
| Batch JD-FIT | 3 credits x candidates |
| Analytics | FREE |

**Example:** 8 candidates with gem_full + JD-FIT = (10 + 3) x 8 = **104 credits**

## Tips

- Always confirm total credit cost before running batch operations
- gem_lite is sufficient for initial screening; save gem_full for shortlisted candidates
- If candidates haven't been uploaded yet, direct user to `/atlas-onboard`
- JD-FIT results include strengths and gaps — use these to guide interview questions
- **Session timeout:** Batch operations with many candidates can take 10+ minutes. If you hit a 403 Forbidden error during polling, the MCP session may have expired. Retry the workflow — completed analyses are persisted and won't be re-charged

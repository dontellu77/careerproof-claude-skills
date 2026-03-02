---
name: atlas-deep-eval
description: Run a comprehensive single-candidate evaluation — GEM competency analysis, JD-FIT matching, and tailored interview questions with follow-up probing. Use when you need a full 360-degree view of one candidate.
disable-model-invocation: true
---

# Atlas Deep Eval — Single Candidate 360 Evaluation

Chain GEM competency analysis, JD-FIT matching, and interview question generation for a thorough evaluation of one candidate.

## Workflow

### Step 1: Identify the Candidate (FREE)

1. Call `atlas_list_contexts` to find the hiring context
2. Call `atlas_list_candidates` with `context_id` to find the candidate
3. Call `atlas_get_candidate` with `context_id` and `candidate_id` to:
   - Verify CV parsing is `completed`
   - Review the parsed CV content
4. Call `atlas_list_jds` with `context_id` to get the JD (needed for FIT matching and interview prep)

If no context/candidates exist, direct user to `/atlas-onboard` first.

### Step 2: GEM Competency Analysis (5-10 credits)

Ask the user which analysis depth:
- **gem_full** (10 credits) — Full 10-factor competency scoring with detailed breakdown
- **gem_lite** (5 credits) — Lightweight competency snapshot
- **career_path** (5 credits) — Career trajectory and progression mapping

1. Call `atlas_start_gem_analysis` with `context_id`, `candidate_id`, and `analysis_type`
   - This is async — save the returned `task_id` and `analysis_id`

2. Poll `careerproof_task_status` with `task_id` every 5-10 seconds until `completed`

3. Call `atlas_get_analysis` with `analysis_id` to get full results

Present the GEM results: overall score, competency breakdown, strengths, development areas, and recommendations.

### Step 3: JD-FIT Matching (8 credits)

Match the candidate against the job description:

1. Get the JD text from Step 1 (or ask user to provide it)
2. Call `atlas_fit_match_enhanced` with `context_id`, `candidate_id`, and `jd_text`
   - This is synchronous and includes KB-augmented market context
   - Returns fit score (0-100), strengths, gaps, and recommendations

Present the FIT results alongside the GEM scores for a complete picture.

### Step 4: Interview Questions (8 credits)

Generate tailored interview questions based on the candidate's profile:

1. Ask the user for:
   - **Pressure level:** supportive / standard / aggressive (default: standard)
   - **Number of questions:** 1-15 (default: 5)

2. Call `atlas_generate_interview` with `context_id`, `candidate_id`, `jd_text`, `pressure_level`, and `num_questions`

Present each question with its rationale (why this question matters for this candidate).

### Step 5: Optional — Follow-Up Probing (1 credit each)

If the user has candidate answers from a real interview:

1. For each question-answer pair, call `atlas_interview_followup` with:
   - `context_id`, `candidate_id`
   - `original_question` — the question text
   - `candidate_answer` — what the candidate said
   - `pressure_level`

2. Present the AI-generated follow-up probe with rationale

### Step 6: Summary

Present a consolidated evaluation summary:
- **GEM Score:** Overall competency rating and top factors
- **FIT Score:** Role match percentage with key strengths/gaps
- **Interview Focus Areas:** Questions targeting the candidate's specific profile
- **Recommendation:** Hire / Maybe / Pass with reasoning

## Credit Cost

| Step | Cost |
|------|------|
| Setup & identification | FREE |
| GEM Full | 10 credits |
| GEM Lite / Career Path | 5 credits |
| FIT Match Enhanced | 8 credits |
| Interview Questions | 8 credits |
| Follow-up Probes | 1 credit each |

**Typical total (gem_full):** 10 + 8 + 8 = **26 credits** (plus 1 per follow-up)

## Tips

- Check for existing analyses first: call `atlas_list_analyses` with `context_id` and `candidate_id` to avoid re-running analyses
- FIT match enhanced (synchronous) is preferred over `atlas_start_fit_match` (async) for single candidates — richer results with KB augmentation
- Interview questions are most useful when the JD is provided — include it from Step 1
- The aggressive pressure level generates harder probing questions — good for senior roles

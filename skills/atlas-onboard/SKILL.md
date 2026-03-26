---
name: atlas-onboard
description: Set up a new Atlas hiring context with company profile, upload candidate CVs, and create a job description. Use when starting a new hiring project, onboarding a client, or setting up candidate evaluation from scratch.
disable-model-invocation: true
---

# Atlas Onboard — Set Up Hiring Context

Guide the user through creating a complete Atlas hiring workspace from scratch.

## Workflow

### Step 1: Create Hiring Context (FREE)

Ask the user for company details, then create the context:

- **Required:** Company name
- **Optional:** Industry, company size (startup/small/medium/large/enterprise), location, website
- **Optional:** Hiring context details — open roles, team structure, budget ranges, hiring goals, timeline, key requirements, competitor context

Call `atlas_create_context` with the provided details. Save the returned `id` as `context_id` for all subsequent steps.

### Step 2: Upload Candidate CVs (FREE)

Ask the user to provide candidate CV files (PDF or DOCX).

For each CV file:
1. Call `atlas_upload_candidate` with `context_id` and the file (base64 encoded)
2. Optionally include `candidate_name`, `candidate_email`, `tags`, and `notes`
3. Save the returned `id` as `candidate_id`
4. CV parsing starts automatically in the background

After uploading all candidates, verify parsing is complete:
- Call `atlas_get_candidate` for each candidate
- Check that parse status is `completed` before proceeding to analysis
- If still parsing, wait 10-15 seconds and check again

### Step 3: Create Job Description (FREE)

Ask the user for the job description:

- **Required:** Job title and full JD text (minimum 50 characters)

Call `atlas_create_jd` with `context_id`, `title`, and `content`. Save the returned `id` as `jd_id`.

### Step 4: Verify Setup (FREE)

Confirm everything is ready:
1. Call `atlas_list_candidates` with `context_id` — verify all candidates appear
2. Call `atlas_list_jds` with `context_id` — verify JD is stored

### Step 5: Next Steps

Present the user with what they can do now:

- **Batch evaluate candidates:** `/atlas-shortlist` — Rank all candidates against the JD (5-13 credits per candidate)
- **Competency scoring:** `/atlas-gem` — GEM 10-factor competency analysis (5-10 credits)
- **JD matching:** `/atlas-fit` — CV-to-JD fit scoring (8 credits)
- **Interview prep:** `/atlas-interview` — Tailored interview questions (8 credits)
- **Generate a research report:** `/atlas-report` — Market intel, talent landscape, or workforce planning (15 credits)
- **Analyze the JD:** `/atlas-jd-review` — Bias detection, salary benchmarking, and clarity scoring (5 credits)
- **Custom evaluation:** `/atlas-custom-eval` — Build bespoke scoring rubrics (FREE setup, 5 credits/candidate to evaluate)
- **Workforce chat:** `/atlas-chat` — Hiring advice and talent market intelligence (2-3 credits/message)

## Credit Cost

All steps in this workflow are **FREE** (0 credits). Paid analysis starts in follow-up workflows.

## Tips

- You can upload candidates incrementally — the context persists across sessions
- Tags on candidates (e.g., "senior", "engineering", "referred") help with filtering later
- If the user has an existing context, call `atlas_list_contexts` first to find it instead of creating a new one
- The hiring_context object is optional but significantly improves AI analysis quality when provided

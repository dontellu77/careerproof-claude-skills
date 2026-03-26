---
name: atlas-jd-review
description: Analyze a job description for quality, bias, market competitiveness, salary benchmarks, and skills extraction. Use this skill whenever someone asks to review a JD, check a job posting for bias or inclusivity issues, benchmark salary for a role, analyze job requirements, optimize a job listing, check if compensation is competitive, or extract skills from a JD. Also triggers on "is this JD any good", "review my job posting", "is the salary competitive for this role", or "check for bias in this listing". This analyzes the JD itself — for matching candidates AGAINST a JD, use atlas-fit instead.
disable-model-invocation: true
argument-hint: "[role title or 'paste JD']"
---

# Atlas JD Review — Job Description Analysis

Analyze a job description for market competitiveness, clarity, bias, salary benchmarks, and skills extraction.

## Workflow

### Step 1: Get JD Text

Two options:
- **Paste JD:** Ask the user to paste the job description text (minimum 50 characters)
- **From context:** Call `atlas_list_contexts` then `atlas_list_jds` to find an existing JD

### Step 2: Collect Optional Hints

Ask for optional context that improves accuracy:
- **Industry hint** — e.g., "fintech", "healthcare", "SaaS" (improves salary benchmarks)
- **Location hint** — e.g., "London", "San Francisco", "Singapore" (improves salary and market data)

### Step 3: Confirm and Analyze (5 credits)

Confirm the 5 credit cost, then call `atlas_start_jd_analysis` with:
- `jd_text` — The job description text (min 50 chars)
- `include_live_search` — Set to `true` for real-time salary and market data (recommended)
- `industry_hint` — If provided
- `location_hint` — If provided

This is synchronous — results return directly.

### Step 4: Present Results

Present the analysis organized by section:

**Market Competitiveness**
- How this JD compares to similar roles in the market
- Salary benchmark ranges for the role/location

**Clarity & Structure**
- Clarity score and readability assessment
- Suggestions for improving JD structure

**Bias & Inclusivity**
- Flagged language that may deter diverse candidates
- Gender-coded or exclusionary terms
- Recommendations for more inclusive language

**Skills & Requirements**
- Extracted required skills and qualifications
- Nice-to-have vs must-have classification
- Whether requirements are realistic for the seniority level

**Salary Benchmarks**
- Market salary ranges for the role
- Comparison to posted compensation (if included in JD)
- Regional variations

### Step 5: Next Steps

After presenting the analysis, offer:
- **Create a hiring context:** `/atlas-onboard` to start recruiting for this role
- **Deeper market research:** `/atlas-report` for a full talent market landscape report
- **Workforce intelligence:** `/atlas-chat` for follow-up questions about the role market

## Credit Cost

| Action | Cost |
|--------|------|
| JD Analysis with live search | 5 credits |

## Tips

- JD text must be minimum 50 characters
- `include_live_search=true` adds real-time salary and market benchmarks — always recommended
- Industry and location hints significantly improve salary accuracy — always ask for them
- Great for checking JDs before posting — catches bias, unclear requirements, and uncompetitive compensation
- For existing JDs in a context, pull text from `atlas_list_jds` to save the user from pasting
- This is a one-shot analysis — for ongoing JD iteration, use `/atlas-chat` to discuss improvements

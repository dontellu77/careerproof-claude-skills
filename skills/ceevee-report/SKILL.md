---
name: ceevee-report
description: Generate career intelligence PDF reports — 17 types including compensation benchmark, AI displacement risk, pivot feasibility, credential ROI, role evolution, skill decay risk, employer red flags, relocation impact, and more. Use this skill whenever someone asks for a career report, salary research document, AI displacement analysis, career pivot assessment, credential evaluation, board readiness report, or any comprehensive career intelligence PDF. Also triggers on "generate a report about my career", "AI risk for my role", "should I get an MBA or certifications", "red flags about this employer", or "what happens if I relocate". This produces PDF REPORTS — for quick salary/career questions, use ceevee-career-intel chat instead (2 credits/msg vs 15 credits/report).
disable-model-invocation: true
argument-hint: "[report type]"
---

# CeeVee Report — Career Intelligence PDF Reports

Generate comprehensive career intelligence PDF reports covering compensation benchmarks, role evolution, AI displacement risk, pivot feasibility, credential ROI, and more.

## MCP Tools

| Tool | Cost | Notes |
|------|------|-------|
| `ceevee_list_report_types` | FREE | List all 17 report types with descriptions, required inputs, credit costs |
| `ceevee_generate_report` | 15 credits | Queue report generation (async). Returns report_id |
| `ceevee_get_report` | FREE | Poll report status. Poll every 30s, max 40 polls (20 min) |
| `ceevee_list_reports` | FREE | List user's generated reports with pagination and status filter |
| `ceevee_download_report` | FREE | Download completed report as base64 PDF |
| `ceevee_list_versions` | FREE | Find CV for CV-aware reports |

## Report Type Enums

**Important:** `ceevee_list_report_types` may return Atlas report types instead of CeeVee career-intel types. Use these exact enum values when calling `ceevee_generate_report`:

| Category | Report Type Enum | Display Name |
|----------|-----------------|--------------|
| Compensation | `ceevee_comp_benchmark` | Compensation Benchmark |
| Compensation | `ceevee_rate_card` | Rate Card |
| Compensation | `ceevee_offer_comparison` | Offer Comparison |
| Career Strategy | `ceevee_role_evolution` | Role Evolution |
| Career Strategy | `ceevee_pivot_feasibility` | Pivot Feasibility |
| Career Strategy | `ceevee_learning_path` | Learning Path |
| Career Strategy | `ceevee_career_gap_narrative` | Career Gap Narrative |
| Risk | `ceevee_ai_displacement_risk` | AI Displacement Risk |
| Risk | `ceevee_skill_decay_risk` | Skill Decay Risk |
| Risk | `ceevee_employer_red_flag` | Employer Red Flag |
| Market Intel | `ceevee_industry_switch` | Industry Switch |
| Market Intel | `ceevee_relocation_impact` | Relocation Impact |
| Market Intel | `ceevee_startup_vs_corporate` | Startup vs Corporate |
| Professional Dev | `ceevee_credential_roi` | Credential ROI |
| Professional Dev | `ceevee_interview_prep` | Interview Prep |
| Professional Dev | `ceevee_board_readiness` | Board Readiness |
| Professional Dev | `ceevee_fractional_leadership` | Fractional Leadership |

All enum values use the `ceevee_` prefix. Do not omit this prefix.

## Workflow

### Step 1: Discover Report Types (FREE)

Call `ceevee_list_report_types` to get available types. If it returns Atlas-style types instead of the CeeVee career-intel types above, use the enum table above as the source of truth.

If user provided a type as `$ARGUMENTS`, match against the enum table above.

Present organized by category:

**Compensation & Offers:**
- Compensation Benchmark
- Rate Card
- Offer Comparison

**Career Strategy:**
- Role Evolution
- Pivot Feasibility
- Learning Path
- Career Gap Narrative

**Risk & Disruption:**
- AI Displacement Risk
- Skill Decay Risk
- Employer Red Flag

**Market Intelligence:**
- Industry Switch
- Relocation Impact
- Startup vs Corporate

**Professional Development:**
- Credential ROI
- Interview Prep
- Board Readiness
- Fractional Leadership

For each type show: name, description, credit cost, required inputs.

### Step 2: Collect Inputs

Based on the selected report type, collect required and optional inputs.

Check if the user has a CV uploaded (`ceevee_list_versions`) — many reports benefit from CV context for personalization.

### Step 3: Confirm and Generate

1. Show summary of report type and inputs
2. Confirm credit cost (typically 15-18 credits)
3. Note that generation takes 2-5 minutes
4. Call `ceevee_generate_report` with:
   - `report_type` — Must use the exact `ceevee_` prefixed enum from the table above (e.g., `ceevee_ai_displacement_risk`, not `ai_displacement_risk`)
   - `inputs` — Object with fields like `role_title`, `location`, `industry`, and any type-specific fields
5. Save the returned `report_id`

**Critical:** Poll with `ceevee_get_report(report_id)` every **30 seconds**, max 40 polls. Do NOT use `careerproof_task_status` — it does not work for CeeVee reports.

### Step 4: Monitor Progress

Poll `ceevee_get_report` every 30 seconds until `status=completed`.

Show progress updates to the user while waiting.

### Step 5: Download Report

Call `ceevee_download_report` with `report_id` to get the base64-encoded PDF.

Present a summary of the report findings.

### Step 6: Next Steps

- Generate another related report
- View past reports: `ceevee_list_reports`
- Discuss findings: `/ceevee-career-intel` for follow-up questions
- Optimize CV based on findings: `/ceevee-optimize`

## Credit Cost

| Action | Cost |
|--------|------|
| Browse report types | FREE |
| Generate report | 15 credits (varies by type) |
| Download PDF | FREE |
| List past reports | FREE |

## Tips

- Always call `ceevee_list_report_types` first — do not guess required inputs
- Reports are persisted and can be re-downloaded later via `ceevee_download_report`
- Use `ceevee_list_reports` to check for similar recent reports before generating a new one
- Poll `ceevee_get_report` every 30s — do NOT use `careerproof_task_status` (it does not work for CeeVee reports)
- CV context improves report personalization — check `ceevee_list_versions` before generating
- For salary questions that do not need a full report, use `/ceevee-career-intel` (2 credits/msg) instead

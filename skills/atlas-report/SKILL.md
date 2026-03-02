---
name: atlas-report
description: Generate comprehensive research reports — talent market landscape, salary benchmarking, workforce planning, competitor analysis, and more. Use when you need a research report, market analysis, talent intelligence, or data-driven hiring insights. 16 report types available.
disable-model-invocation: true
argument-hint: "[report-type]"
---

# Atlas Report — Research Report Generator

Browse 16 report types and generate comprehensive PDF research reports with market data, talent intelligence, and strategic recommendations.

## Workflow

### Step 1: Discover Report Types (FREE)

Call `atlas_list_report_types` to get all 16 available report types.

If the user provided a report type as `$ARGUMENTS`, match it against the available types and skip the browsing step.

Otherwise, present the report types organized by category:

**Recruitment Reports:**
- Talent market landscape
- Salary benchmarking
- Competitor talent analysis
- Sourcing strategy

**Workforce Planning Reports:**
- Skills gap analysis
- Succession planning
- Workforce demographics
- Attrition risk assessment

**Strategic HR Reports:**
- DEI analysis
- Employer branding
- Learning & development
- Organization design
- Employee engagement
- Total rewards benchmarking
- HR technology assessment
- Change management

For each type, show: name, description, credit cost, and required inputs.

Ask the user which report type they want to generate.

### Step 2: Collect Report Inputs

Based on the selected report type, collect the required and optional inputs from the user.

Common inputs across report types include:
- **Industry/sector** — Target industry for the analysis
- **Role/function** — Specific role or job family
- **Location/region** — Geographic scope
- **Company context** — Company name, size, or specific requirements
- **Time horizon** — Analysis period (e.g., 6 months, 1 year, 3 years)

Present the required fields first, then ask about optional fields that would enrich the report.

### Step 3: Confirm and Generate (15 credits)

Before starting generation:
1. Show a summary of the selected report type and all inputs
2. Confirm the cost: **15 credits**
3. Note that generation takes **2-10 minutes** depending on complexity

Call `atlas_start_report` with:
- `report_type` — The selected report type string
- `inputs` — Object containing all collected inputs

Save the returned `report_id` and `task_id`.

### Step 4: Monitor Progress

Poll `careerproof_task_status` with `task_id` every **15-30 seconds** (reports take longer than analyses).

Show progress updates to the user:
- "Researching market data..."
- "Analyzing trends..."
- "Generating report..."

When status reaches `completed`, proceed to download.

Alternatively, call `atlas_get_report` with `report_id` to check status and see the report title and summary.

### Step 5: Download Report

Call `atlas_download_report` with `report_id` to get the PDF.

The PDF is returned as base64-encoded content. Present the report summary to the user and confirm the download.

### Step 6: Next Steps

After delivering the report, offer:
- **Generate another report** on a related topic
- **View all reports:** Call `atlas_list_reports` to see previously generated reports
- **Use insights for hiring:** Start a `/atlas-shortlist` workflow informed by the report findings
- **Discuss findings:** Use `atlas_chat` (3 credits/message) for follow-up questions about the data

## Credit Cost

| Action | Cost |
|--------|------|
| Browse report types | FREE |
| Generate report | 15 credits |
| Download PDF | FREE |
| List past reports | FREE |

## Tips

- Call `atlas_list_report_types` first to see exact required inputs for each type — don't guess
- Reports are persisted and can be re-downloaded later via `atlas_download_report`
- Use `atlas_list_reports` to check if a similar report was already generated recently
- For salary-specific questions that don't need a full report, consider `atlas_chat` (3 credits) instead
- Reports use live web research — results reflect current market conditions
- If generation fails, check the error in `atlas_get_report` response and retry with adjusted inputs

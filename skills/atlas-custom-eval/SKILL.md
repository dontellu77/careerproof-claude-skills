---
name: atlas-custom-eval
description: Build and run custom hiring evaluation models — upload example strong/weak CVs, have AI infer scoring rubrics, customize evaluation dimensions and weights, then batch-evaluate candidates against your bespoke criteria. Use this skill whenever someone wants to create a custom scoring model, build a tailored rubric, define their own evaluation criteria, train a hiring model on examples, upload annotated CVs to teach the system what "good" looks like, or evaluate candidates against company-specific standards. Also triggers on "custom eval", "bespoke rubric", "our own scoring criteria", or "teach it what we look for". This is different from atlas-gem (standard 10-factor scoring) — use this when the user wants THEIR OWN criteria, not the default framework.
disable-model-invocation: true
argument-hint: "[model name or 'evaluate']"
---

# Atlas Custom Eval — Build & Run Custom Hiring Models

Create custom evaluation models by teaching the AI what good and bad candidates look like, then batch-evaluate candidates against your bespoke rubric.

## Workflow

### Phase 1: Create Model (FREE)

1. Call `atlas_list_custom_eval_models` to check for existing models
2. If creating new: Call `atlas_create_custom_eval_model` with `name` and optional `description`
3. Save the returned `model_id`

### Phase 2: Teach the Model (FREE)

Upload artifacts that teach the model what strong, weak, and mixed candidates look like:

**File artifacts** — Call `atlas_upload_custom_eval_artifact` with:
- `model_id`
- `file` — Base64-encoded PDF or DOCX
- `artifact_type` — One of: `cv_with_notes`, `template`, `free_text`, `jd`
- `label` — One of: `strong`, `weak`, `mixed`
- Optional: `filename`, `notes`

**Text artifacts** — Call `atlas_add_custom_eval_text_artifact` with:
- `model_id`
- `artifact_type` — One of: `cv_with_notes`, `template`, `free_text`, `jd`
- `text_content` — The text to add
- `label` — One of: `strong`, `weak`, `mixed`

**Guidelines:**
- Upload 3-5 artifacts minimum (mix of strong + weak examples)
- Label accuracy is critical — this drives rubric quality
- Include JDs to teach role context
- Include templates or free text notes to communicate specific criteria

Verify uploads with `atlas_list_custom_eval_artifacts`.

### Phase 3: Infer & Customize Rubric (FREE + optional 5 credits)

1. Call `atlas_infer_custom_eval_rubric` with `model_id`
   - Takes 30-60 seconds (synchronous with progress notifications)
   - AI generates evaluation dimensions and scoring criteria from your artifacts

2. Call `atlas_get_custom_eval_rubric` to review the generated rubric
   - Shows dimensions, scoring criteria, and weights

3. Present the rubric to the user for review

4. If adjustments needed: Call `atlas_set_custom_eval_rubric_overrides` with `model_id` and `overrides` object to:
   - Adjust dimension weights
   - Rename dimensions
   - Add custom criteria

5. If want to start over: Call `atlas_clear_custom_eval_rubric_overrides` to revert to AI-inferred rubric

6. **Optional:** Call `atlas_start_custom_eval_inference` (5 credits, async) for AI-generated evaluation dimensions
   - Poll `careerproof_task_status` every 5-10s until completed

### Phase 4: Evaluate Candidates (5 credits/candidate)

You need a hiring context with uploaded candidates. If none exist, direct user to `/atlas-onboard`.

1. Call `atlas_start_custom_eval_batch` with:
   - `custom_model_id` — The model to evaluate against
   - `candidate_ids` — Array of candidate IDs
   - `context_id` — The hiring context
   - Optional: `detail_level` (brief/standard/deep)

2. Confirm the credit cost: 5 credits per candidate

3. Poll `atlas_get_custom_eval_batch_status` with `batch_id` every 5-10 seconds until completed

4. Call `atlas_get_custom_eval_batch_results` with `batch_id` for results

5. Present ranked results with:
   - Per-candidate overall scores
   - Dimension-level breakdowns
   - Strengths and gaps per candidate

### Next Steps

- **Compare with standard analysis:** Run `/atlas-gem` for standard competency scoring
- **JD matching:** Run `/atlas-fit` for CV-to-JD alignment
- **Full shortlist:** Run `/atlas-shortlist` for batch GEM + FIT analysis

## Credit Cost

| Action | Cost |
|--------|------|
| Create/manage model | FREE |
| Upload artifacts | FREE |
| Infer rubric from artifacts | FREE |
| Customize rubric overrides | FREE |
| AI dimension inference | 5 credits |
| Batch evaluation | 5 credits/candidate |

**Example:** Model setup (FREE) + evaluate 8 candidates = **40 credits**

## Tips

- More artifacts = better rubric. Aim for 3+ strong and 3+ weak examples
- Label artifacts accurately (`strong`/`weak`/`mixed`) — this is the #1 factor in rubric quality
- The rubric can be customized after inference — adjust weights to match your priorities
- Models persist across sessions — use `atlas_list_custom_eval_models` to find existing ones
- Custom eval works alongside GEM and FIT — they measure different things
- Use `atlas_update_custom_eval_model` to update model metadata without rebuilding
- Use `atlas_delete_custom_eval_model` to clean up models you no longer need

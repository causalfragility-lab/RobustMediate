## Resubmission (v0.1.1)

This resubmission addresses all issues raised in previous reviews:

(1) Removed the pkgdown URL that was returning 404. The URL field in
    DESCRIPTION now contains only the GitHub repository URL:
    https://github.com/causalfragility-lab/RobustMediate

(2) Fixed bootstrap confidence interval computation. The previous
    version used stats::update() to refit models on bootstrap samples,
    which failed silently on data frames with duplicate row names
    produced by sampling with replacement, causing all CIs to return NA.
    Replaced with direct stats::glm() calls and row name reset.
    CIs now compute correctly (200/200 replicates succeed).

(3) Removed the invalid standalone References: field from DESCRIPTION
    in a prior resubmission (already fixed).

## R CMD check results
0 errors | 0 warnings | 0 notes

## Test environments
* Windows 11 x64, R 4.5.1 (local)

## Downstream dependencies
None - this is a new submission.


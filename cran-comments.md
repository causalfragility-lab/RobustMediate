## Resubmission (v0.1.1 - second attempt)

Changes made since last submission:

* Wrapped the robustmediate() example in \donttest{} to fix
  the "examples with CPU time > 10s" NOTE. The example runs
  R = 100 bootstrap replicates which takes ~20-40 seconds
  depending on platform.

* Added inst/WORDLIST with technical terms (IPW, ITCV, Imai,
  VanderWeele, Yamamoto, ignorability, medITCV) to address
  the "possibly misspelled words" NOTE.

## Previous fixes (already in this version)
* Removed pkgdown URL returning 404 from DESCRIPTION.
* Fixed bootstrap CIs returning NA (replaced stats::update()
  with stats::glm() and reset rownames on bootstrap samples).

## R CMD check results
0 errors | 0 warnings | 0 notes

## Test environments
* Windows 11 x64, R 4.5.1 (local)

## Downstream dependencies
None - this is a new submission.


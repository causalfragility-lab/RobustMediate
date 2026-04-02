# =============================================================================
# cran_prep.R
# Run this script from your package root directory.
# It does four things:
#   1. Runs a tiny simulation to verify all functions work correctly
#   2. Patches all exported .Rd files to add missing \value tags
#   3. Wraps slow examples in \donttest{} so CRAN < 5 sec limit is met
#   4. Adds properly formatted references to DESCRIPTION
# =============================================================================


# ── 0. Load package ───────────────────────────────────────────────────────────
devtools::load_all(".")


# =============================================================================
# PART 1: Simulation test
# =============================================================================
cat("\n============================================================\n")
cat("PART 1: Simulation test\n")
cat("============================================================\n\n")

set.seed(42)
n  <- 150
Z1 <- rnorm(n); Z2 <- rbinom(n, 1, 0.5)
X  <- 0.5 * Z1 + 0.3 * Z2 + rnorm(n)
M  <- 0.4 * X  + 0.2 * Z1 + rnorm(n)
Y  <- 0.3 * X  + 0.5 * M  + 0.1 * Z1 + rnorm(n)
dat <- data.frame(Y, X, M, Z1, Z2)

fit <- robustmediate(
  treatment_formula = X ~ Z1 + Z2,
  mediator_formula  = M ~ X + Z1 + Z2,
  outcome_formula   = Y ~ X + M + Z1 + Z2,
  data    = dat,
  R       = 50,
  verbose = FALSE
)

# -- Check 1: correct slots
stopifnot(
  inherits(fit, "robmedfit"),
  all(c("models", "balance", "effects", "sensitivity",
        "meditcv", "meditcv_profile", "meta") %in% names(fit))
)
cat("[OK] robustmediate() returns robmedfit with correct slots\n")

# -- Check 2: meditcv
med <- fit$meditcv
stopifnot(
  inherits(med, "meditcv"),
  is.numeric(med$a_path$meditcv),
  is.numeric(med$b_path$meditcv),
  isTRUE(all.equal(med$indirect$meditcv_indirect,
                   min(med$a_path$meditcv, med$b_path$meditcv)))
)
cat("[OK] sensitivity_meditcv() - minimum robustness principle holds\n")

# -- Check 3: meditcv_profile
mp <- fit$meditcv_profile
stopifnot(
  inherits(mp, "meditcv_profile"),
  isTRUE(all.equal(mp$meditcv_indirect, min(mp$a_path, mp$b_path)))
)
cat("[OK] sensitivity_meditcv_profile() - structure correct\n")

# -- Check 4: fragility_table
ft <- fragility_table(fit)
stopifnot(
  nrow(ft) == 3,
  all(c("medITCV", "medITCV_pct", "bottleneck", "fragility") %in% names(ft)),
  ft$bottleneck[3] == TRUE
)
cat("[OK] fragility_table() - 3 rows, correct columns\n")

# -- Check 5: all plot types
p1 <- plot(fit);                         stopifnot(inherits(p1, "gg")); cat("[OK] plot(fit)\n")
p2 <- plot(fit, type = "balance");       stopifnot(inherits(p2, "gg")); cat("[OK] plot(fit, type='balance')\n")
p3 <- plot(fit, type = "sensitivity");   stopifnot(inherits(p3, "gg")); cat("[OK] plot(fit, type='sensitivity')\n")
p4 <- plot(fit, type = "meditcv");       stopifnot(inherits(p4, "gg")); cat("[OK] plot(fit, type='meditcv')\n")
p5 <- plot(fit, type = "meditcv_profile"); stopifnot(inherits(p5, "gg")); cat("[OK] plot(fit, type='meditcv_profile')\n")
p6 <- plot(fit, type = "curvature");     stopifnot(inherits(p6, "gg")); cat("[OK] plot(fit, type='curvature')\n")

# -- Check 6: diagnose
out <- capture.output(diag_out <- diagnose(fit))
stopifnot(
  all(c("balance", "effects", "sensitivity", "meditcv", "meditcv_profile")
      %in% names(diag_out))
)
cat("[OK] diagnose() - correct return slots\n")

# -- Check 7: broom methods
td <- tidy(fit);   stopifnot(nrow(td) == 3, "estimate" %in% names(td)); cat("[OK] tidy()\n")
gl <- glance(fit); stopifnot(nrow(gl) == 1);                             cat("[OK] glance()\n")

# -- Check 8: tipping_table
tt <- tipping_table(fit)
stopifnot(nrow(tt) == 2, "tipping_value" %in% names(tt))
cat("[OK] tipping_table()\n")

# -- Check 9: sensitivity_curvature
cv <- sensitivity_curvature(fit)
stopifnot(is.data.frame(cv), "frag_local" %in% names(cv))
cat("[OK] sensitivity_curvature()\n")

# -- Check 10: print methods produce output without error
capture.output(print(fit))
capture.output(print(fit$meditcv))
capture.output(print(fit$meditcv_profile))
cat("[OK] print methods\n")

cat("\n[ALL SIMULATION TESTS PASSED]\n\n")


# =============================================================================
# PART 2: Patch missing \value tags in man/*.Rd
# =============================================================================
cat("============================================================\n")
cat("PART 2: Patching missing \\value tags in man/*.Rd\n")
cat("============================================================\n\n")

value_map <- list(

  "robustmediate.Rd" =
    "An object of class \\code{\"robmedfit\"}: a named list with slots\n\\code{models}, \\code{balance}, \\code{effects}, \\code{sensitivity},\n\\code{meditcv}, \\code{meditcv_profile}, \\code{cluster}, and \\code{meta}.\nUse \\code{print()}, \\code{diagnose()}, or \\code{plot()} to explore.",

  "sensitivity_meditcv.Rd" =
    "An object of class \\code{\"meditcv\"}: a named list with elements\n\\code{a_path}, \\code{b_path}, \\code{indirect}, and \\code{alpha}.\nEach pathway element contains the observed partial correlation, critical\npartial correlation, medITCV value, and benchmark confounder impacts.",

  "sensitivity_meditcv_profile.Rd" =
    "An object of class \\code{\"meditcv_profile\"}: a named list with elements\n\\code{a_path}, \\code{b_path}, \\code{meditcv_indirect}, \\code{bottleneck},\n\\code{robustness_profile}, \\code{fragility_ratio}, \\code{meditcv_detail},\nand \\code{alpha}.",

  "sensitivity_curvature.Rd" =
    "A data frame with one row per dose value and columns \\code{dose},\n\\code{estimate}, \\code{lower}, \\code{upper}, \\code{se_approx},\n\\code{frag_local}, \\code{curvature}, and \\code{in_fragility_zone}.",

  "plot.robmedfit.Rd"       = "A \\code{ggplot2} object.",
  "plot_meditcv.Rd"         = "A \\code{ggplot2} object.",
  "plot_meditcv_profile.Rd" = "A \\code{ggplot2} object.",
  "plot_curvature.Rd"       = "A \\code{ggplot2} object.",
  "plot_balance.Rd"         = "A \\code{ggplot2} object.",
  "plot_mediation.Rd"       = "A \\code{ggplot2} object.",
  "plot_sensitivity.Rd"     = "A \\code{ggplot2} object.",
  "compare_fits.Rd"         = "A \\code{ggplot2} object.",

  "fragility_table.Rd" =
    "A data frame with three rows (a-path, b-path, indirect effect) and columns\n\\code{pathway}, \\code{coefficient}, \\code{SE}, \\code{t_stat}, \\code{df},\n\\code{r_obs}, \\code{r_crit}, \\code{medITCV}, \\code{medITCV_pct},\n\\code{fragility}, \\code{tipping_r_confounder}, and \\code{bottleneck}.",

  "tipping_table.Rd" =
    "A data frame with two rows and columns \\code{parameter},\n\\code{tipping_value}, and \\code{interpretation}.",

  "print.robmedfit.Rd" =
    "The input object, invisibly. Called for its side effect of printing\na formatted summary to the console.",

  "print.meditcv.Rd" =
    "The input object, invisibly. Called for its side effect of printing\na formatted medITCV report to the console.",

  "print.meditcv_profile.Rd" =
    "The input object, invisibly. Called for its side effect of printing\na formatted medITCV robustness profile to the console.",

  "summary.robmedfit.Rd" =
    "Invisibly returns a list with elements \\code{effects} and \\code{balance}.\nCalled primarily for its side effect of printing.",

  "diagnose.Rd" =
    "Invisibly returns a named list with elements \\code{balance},\n\\code{effects}, \\code{sensitivity}, \\code{meditcv}, and\n\\code{meditcv_profile}. Called primarily for its side effect of printing\na formatted diagnostics report.",

  "tidy.robmedfit.Rd" =
    "A data frame with three rows (NDE, NIE, TE) and columns \\code{term},\n\\code{estimate}, \\code{conf.low}, \\code{conf.high}, and \\code{ref_dose}.",

  "glance.robmedfit.Rd" =
    "A one-row data frame with columns \\code{n_obs}, \\code{R},\n\\code{ref_dose}, \\code{pct_mediated}, \\code{evalue_NIE},\n\\code{rho_min_NIE}, \\code{max_smd_treat}, and \\code{max_smd_med}.",

  "augment.robmedfit.Rd" =
    "The original data frame augmented with columns \\code{.ipw_weight},\n\\code{.fitted_mediator}, \\code{.fitted_outcome}, \\code{.resid_mediator},\nand \\code{.resid_outcome}.",

  "as.data.frame.robmedfit.Rd" =
    "A data frame with columns \\code{dose}, \\code{estimand},\n\\code{estimate}, \\code{lower}, and \\code{upper}, containing the\nNDE/NIE/TE curves over the full dose grid."
)

patch_value <- function(rd_path, value_text) {
  if (!file.exists(rd_path)) {
    cat("  [SKIP - not found]", basename(rd_path), "\n"); return(invisible(NULL))
  }
  txt <- readLines(rd_path)
  if (any(grepl("^\\\\value", txt))) {
    cat("  [SKIP - exists] ", basename(rd_path), "\n"); return(invisible(NULL))
  }
  insert_at <- which(grepl("^\\\\examples", txt))[1]
  value_block <- c("", "\\value{", value_text, "}")
  if (!is.na(insert_at)) {
    txt <- c(txt[seq_len(insert_at - 1)], value_block, txt[insert_at:length(txt)])
  } else {
    txt <- c(txt, value_block)
  }
  writeLines(txt, rd_path)
  cat("  [PATCHED]", basename(rd_path), "\n")
}

for (nm in names(value_map)) {
  patch_value(file.path("man", nm), value_map[[nm]])
}


# =============================================================================
# PART 3: Wrap slow examples in \donttest{}
# =============================================================================
cat("\n============================================================\n")
cat("PART 3: Wrapping slow examples in \\donttest{}\n")
cat("============================================================\n\n")

# Any Rd whose example actually fits a model will be slow.
# Wrap them all so CRAN's 5-second limit is not hit.
slow_rds <- c(
  "man/robustmediate.Rd",
  "man/diagnose.Rd",
  "man/tidy.robmedfit.Rd",
  "man/glance.robmedfit.Rd",
  "man/augment.robmedfit.Rd",
  "man/as.data.frame.robmedfit.Rd",
  "man/plot.robmedfit.Rd",
  "man/fragility_table.Rd",
  "man/tipping_table.Rd",
  "man/compare_fits.Rd",
  "man/sensitivity_meditcv.Rd",
  "man/sensitivity_meditcv_profile.Rd",
  "man/sensitivity_curvature.Rd",
  "man/plot_meditcv.Rd",
  "man/plot_meditcv_profile.Rd",
  "man/plot_curvature.Rd"
)

wrap_donttest <- function(rd_path) {
  if (!file.exists(rd_path)) {
    cat("  [SKIP - not found]", basename(rd_path), "\n"); return(invisible(NULL))
  }
  txt <- readLines(rd_path)
  if (any(grepl("\\\\donttest", txt))) {
    cat("  [SKIP - exists] ", basename(rd_path), "\n"); return(invisible(NULL))
  }
  ex_start <- which(grepl("^\\\\examples\\{", txt))[1]
  if (is.na(ex_start)) {
    cat("  [SKIP - no examples]", basename(rd_path), "\n"); return(invisible(NULL))
  }
  # Find matching closing brace of \examples{ ... }
  depth <- 0; ex_end <- NA
  for (i in ex_start:length(txt)) {
    depth <- depth + lengths(regmatches(txt[i], gregexpr("\\{", txt[i])))
    depth <- depth - lengths(regmatches(txt[i], gregexpr("\\}", txt[i])))
    if (depth <= 0) { ex_end <- i; break }
  }
  if (is.na(ex_end)) {
    cat("  [SKIP - unmatched brace]", basename(rd_path), "\n"); return(invisible(NULL))
  }
  # Insert \donttest{ after opening line and } before closing line
  txt <- append(txt, "\\donttest{", after = ex_start)
  ex_end <- ex_end + 1   # shifted by insertion
  txt <- append(txt, "}", after = ex_end - 1)
  writeLines(txt, rd_path)
  cat("  [PATCHED]", basename(rd_path), "\n")
}

for (rd in slow_rds) wrap_donttest(rd)


# =============================================================================
# PART 4: Add references to DESCRIPTION
# =============================================================================
cat("\n============================================================\n")
cat("PART 4: Adding references to DESCRIPTION\n")
cat("============================================================\n\n")

desc_path <- "DESCRIPTION"
desc <- readLines(desc_path)

if (!any(grepl("doi:", desc, fixed = TRUE))) {
  # Find end of Description: block
  desc_line <- which(grepl("^Description:", desc))[1]
  end_of_desc <- desc_line
  for (i in (desc_line + 1):length(desc)) {
    if (grepl("^[A-Za-z]", desc[i])) { end_of_desc <- i - 1; break }
    end_of_desc <- i
  }
  refs <- c(
    "    References: Frank (2000) <doi:10.1177/0049124100029002002>;",
    "    VanderWeele and Ding (2017) <doi:10.7326/M16-2607>;",
    "    Imai, Keele, and Yamamoto (2010) <doi:10.1214/10-STS321>."
  )
  desc <- c(desc[seq_len(end_of_desc)], refs,
            desc[(end_of_desc + 1):length(desc)])
  writeLines(desc, desc_path)
  cat("  [PATCHED] DESCRIPTION - references added\n")
} else {
  cat("  [SKIP] DESCRIPTION already has doi references\n")
}


# =============================================================================
# DONE - rebuild docs
# =============================================================================
cat("\n============================================================\n")
cat("Running devtools::document() ...\n")
cat("============================================================\n\n")
devtools::document()

cat("\n============================================================\n")
cat("All done. Now run:  devtools::check()\n")
cat("============================================================\n\n")

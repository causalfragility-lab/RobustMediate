## Run this ONCE from your RobustMediate project root to create the bundled dataset:
##
##   source("data-raw/generate_sim_data.R")
##
## Requires: usethis (install.packages("usethis"))

set.seed(2024)

n_schools <- 30
n_per     <- 20
n         <- n_schools * n_per
school    <- rep(seq_len(n_schools), each = n_per)

u_x <- rnorm(n_schools, 0, 0.4)[school]
u_m <- rnorm(n_schools, 0, 0.3)[school]
u_y <- rnorm(n_schools, 0, 0.3)[school]

Z1 <- rnorm(n)
Z2 <- rbinom(n, 1, 0.45)
Z3 <- rnorm(n, mean = 0.3 * Z1)

X_raw <- 2 + 0.6 * Z1 - 0.4 * Z2 + 0.2 * Z3 + u_x + rnorm(n, sd = 0.9)
X     <- pmax(X_raw, 0)

M <- 50 + 0.5 * X + 0.3 * Z1 - 0.2 * Z2 + 0.15 * Z3 + u_m + rnorm(n, sd = 2.5)
Y <- 10 + 0.25 * X + 0.70 * M + 0.15 * Z1 - 0.10 * Z2 + 0.10 * Z3 +
     u_y + rnorm(n, sd = 3.0)

sim_mediation <- data.frame(
  school = factor(school),
  Y, X, M, Z1, Z2, Z3
)

usethis::use_data(sim_mediation, overwrite = TRUE)

cat("\u2713 data/sim_mediation.rda created\n")
cat("  True NDE \u2248 0.25 | True NIE \u2248 0.35 | % mediated \u2248 58%\n")

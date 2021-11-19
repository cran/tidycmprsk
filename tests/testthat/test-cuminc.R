test_that("cuminc() works", {
  cmprsk_cuminc1 <-
    cmprsk::cuminc(
      ftime = trial$ttdeath,
      fstatus = as.numeric(trial$death_cr) - 1L
    )
  cmprsk_cuminc2 <-
    cmprsk::cuminc(
      ftime = trial$ttdeath,
      fstatus = as.numeric(trial$death_cr) - 1L,
      group = trial$trt
    )

  expect_error(
    cuminc1 <- cuminc(Surv(ttdeath, death_cr) ~ 1, trial),
    NA
  )
  expect_equal(
    cuminc1$cmprsk,
    cmprsk_cuminc1
  )

  expect_error(
    cuminc2 <- cuminc(Surv(ttdeath, death_cr) ~ trt, trial),
    NA
  )
  expect_equal(
    cuminc2$cmprsk,
    cmprsk_cuminc2
  )

  expect_equal(
    names(cuminc1$failcode),
    c("death from cancer", "death other causes")
  )
  expect_equal(
    names(cuminc2$failcode),
    c("death from cancer", "death other causes")
  )

  # test base methods
  expect_equal(
    model.frame(cuminc1),
    model.frame(Surv(ttdeath, death_cr) ~ 1, data = trial),
    ignore_attr = TRUE
  )
  expect_equal(
    model.frame(cuminc2),
    model.frame(Surv(ttdeath, death_cr) ~ trt, data = trial),
    ignore_attr = TRUE
  )
})

test_that("base methods", {
  cuminc2 <- cuminc(Surv(ttdeath, death_cr) ~ trt, trial)

  expect_error(
    print(cuminc2),
    NA
  )

  expect_error(
    model.matrix(cuminc2),
    NA
  )

  expect_error(
    model.frame(cuminc2),
    NA
  )
})

test_that("broom methods", {
  cuminc2 <- cuminc(Surv(ttdeath, death_cr) ~ trt, trial)

  expect_error(
    glance(cuminc2),
    NA
  )
  expect_error(
    tidy(cuminc2),
    NA
  )
  expect_error(
    tidy(cuminc2, conf.int = TRUE),
    NA
  )

})


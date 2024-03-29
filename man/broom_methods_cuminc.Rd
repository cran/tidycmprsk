% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/broom_methods.R
\name{broom_methods_cuminc}
\alias{broom_methods_cuminc}
\alias{tidy.tidycuminc}
\alias{glance.tidycuminc}
\title{Broom methods for tidy cuminc objects}
\usage{
\method{tidy}{tidycuminc}(x, times = NULL, conf.int = TRUE, conf.level = x$conf.level, ...)

\method{glance}{tidycuminc}(x, ...)
}
\arguments{
\item{x}{object of class 'tidycuminc'}

\item{times}{Numeric vector of times to obtain risk estimates at}

\item{conf.int}{Logical indicating whether or not to include a confidence
interval in the tidied output. Defaults to \code{FALSE}.}

\item{conf.level}{Level of the confidence interval. Default matches that in
\code{cuminc(conf.level=)} (typically, 0.95)}

\item{...}{not used}
}
\value{
a tibble
}
\description{
Broom methods for tidy cuminc objects
}
\section{\code{tidy()} data frame}{


The returned \code{tidy()} data frame returns the following columns:\tabular{ll}{
   \strong{Column Name} \tab \strong{Description} \cr
   \code{outcome} \tab Competing Event Outcome \cr
   \code{time} \tab Numeric follow-up time \cr
   \code{estimate} \tab Risk estimate \cr
   \code{std.error} \tab Standard Error \cr
   \code{n.risk} \tab Number at risk at the specified time \cr
   \code{n.event} \tab If the \verb{times=} argument is missing, then the number of events that occurred at time \code{t}. Otherwise, it is the cumulative number of events that have occurred since the last time listed. \cr
   \code{n.censor} \tab If the \verb{times=} argument is missing, then the number of censored obs at time \code{t}. Otherwise, it is the cumulative number of censored obs that have occurred since the last time listed. \cr
   \code{cum.event} \tab Cumulative number of events at specified time \cr
   \code{cum.censor} \tab Cumulative number of censored observations at specified time \cr
}


If \code{tidy(time=)} is specified, then \code{n.event} and \code{n.censor} are the
cumulative number of events/censored in the interval. For example, if
\code{tidy(time = c(0, 12, 18))} is passed, \code{n.event} and \code{n.censor} at \code{time = 18}
are the cumulative number of events/censored in the interval \verb{(12, 18]}.
}

\section{p-values}{


The p-values reported in \code{cuminc()}, \code{glance.tidycuminc()} and \code{add_p.tbl_cuminc()}
are Gray's test as described in
Gray RJ (1988) \emph{A class of K-sample tests for comparing the cumulative incidence of a competing risk}, Annals of Statistics, 16:1141-1154.
}

\section{Confidence intervals}{


The confidence intervals for cumulative incidence estimates use the recommended method in
\emph{Competing Risks: A Practical Perspective} by Melania Pintilie.

\deqn{x^{exp(±z * se / (x * log(x)))}}

where \eqn{x} is the cumulative incidence estimate, \eqn{se} is the
standard error estimate, and \eqn{z} is the z-score associated with the
confidence level of the interval, e.g. \eqn{z = 1.96} for a 95\% CI.
}

\examples{
cuminc <- cuminc(Surv(ttdeath, death_cr) ~ trt, trial)

tidy(cuminc)

glance(cuminc)

# restructure glance to one line per outcome
glance(cuminc) \%>\%
  tidyr::pivot_longer(
    everything(),
    names_to = c(".value", "outcome_id"),
    names_pattern = "(.*)_(.*)"
  )
}
\seealso{
Other cuminc() functions: 
\code{\link{cuminc}()}
}
\concept{cuminc tidiers}
\concept{cuminc() functions}
\concept{tidycuminc tidiers}

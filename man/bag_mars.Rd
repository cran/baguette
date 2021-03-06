% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bag_mars.R
\name{bag_mars}
\alias{bag_mars}
\alias{update.bag_mars}
\title{General Interface for Bagged MARS Models}
\usage{
bag_mars(
  mode = "unknown",
  num_terms = NULL,
  prod_degree = NULL,
  prune_method = NULL
)

\method{update}{bag_mars}(
  object,
  parameters = NULL,
  num_terms = NULL,
  prod_degree = NULL,
  prune_method = NULL,
  fresh = FALSE,
  ...
)
}
\arguments{
\item{mode}{A single character string for the type of model.
Possible values for this model are "unknown", "regression", or
"classification".}

\item{num_terms}{The number of features that will be retained in the
final model, including the intercept.}

\item{prod_degree}{The highest possible interaction degree.}

\item{prune_method}{The pruning method.}

\item{object}{A bagged MARS model specification.}

\item{parameters}{A 1-row tibble or named list with \emph{main}
parameters to update. If the individual arguments are used,
these will supersede the values in \code{parameters}. Also, using
engine arguments in this object will result in an error.}

\item{fresh}{A logical for whether the arguments should be
modified in-place of or replaced wholesale.}

\item{...}{Not used for \code{update()}.}
}
\description{
\code{bag_mars()} is a way to generate a \emph{specification} of a model
before fitting and allows the model to be created using
different packages in R. The main arguments for the
model are:
\itemize{
\item \code{num_terms}: The number of features that will be retained in the
final model.
\item \code{prod_degree}: The highest possible degree of interaction between
features. A value of 1 indicates and additive model while a value of 2
allows, but does not guarantee, two-way interactions between features.
\item \code{prune_method}: The type of pruning. Possible values are listed
in \code{?earth}.
}
These arguments are converted to their specific names at the
time that the model is fit. Other options and argument can be
set using \code{set_engine()}. If left to their defaults
here (\code{NULL}), the values are taken from the underlying model
functions. If parameters need to be modified, \code{update()} can be used
in lieu of recreating the object from scratch.
}
\details{
The model can be created using the \code{fit()} function using the
following \emph{engines}:
\itemize{
\item \pkg{R}:  \code{"earth"}  (the default)
}
}
\examples{
library(parsnip)

set.seed(7396)
bag_mars(num_terms = 7) \%>\%
  set_mode("regression") \%>\%
  set_engine("earth", times = 3) \%>\%
  fit(mpg ~ ., data = mtcars)


model <- bag_mars(num_terms = 10, prune_method = "none")
model
update(model, num_terms = 2)
update(model, num_terms = 2, fresh = TRUE)
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load_truth.R
\name{load_truth}
\alias{load_truth}
\title{Load truth data under multiple target variables
from multiple truth sources
using files in reichlab/covid19-forecast-hub.}
\usage{
load_truth(
  truth_source = NULL,
  target_variable = NULL,
  as_of = NULL,
  truth_end_date = NULL,
  temporal_resolution = NULL,
  locations = NULL,
  data_location = NULL,
  local_repo_path = NULL,
  hub = c("US", "ECDC")
)
}
\arguments{
\item{truth_source}{character vector specifying where the truths will
be loaded from: currently support "JHU", "USAFacts", "NYTimes", "HealthData" and "ECDC".
If \code{NULL}, default for US hub is c("JHU", "HealthData").
If \code{NULL}, default for ECDC hub is c("JHU").}

\item{target_variable}{string specifying target type It should be one or more of
"cum death", "inc case", "inc death", "inc hosp".
If \code{NULL}, default for US hub is c("inc case", "inc death", "inc hosp").
If \code{NULL}, default for ECDC hub is c("inc case", "inc death").}

\item{as_of}{character vector of "as of" dates to use for querying truths in
format 'yyyy-mm-dd'. For each spatial unit and temporal reporting unit, the last
available data with an issue date on or before the given \code{as_of} date are returned.
This is only available for covidData now.}

\item{truth_end_date}{date to include the last available truth point in 'yyyy-mm-dd' format.
If \code{NULL},default to system date.}

\item{temporal_resolution}{character specifying temporal resolution
to include: currently support "weekly" and "daily".
If \code{NULL}, default to 'weekly' for cases and deaths, 'daily' for hospitalizations.
Weekly temporal_resolution will not be applied to "inc hosp" when
multiple target variables are specified.
"ECDC" truth data is weekly by default. Daily level data is not available.}

\item{locations}{vector of valid location code.
If \code{NULL}, default to all locations with available forecasts.
US hub is using FIPS code and ECDC hub is using country name abbreviation.}

\item{data_location}{character specifying the location of truth data.
Currently only supports "local_hub_repo","remote_hub_repo" and "covidData".
If \code{NULL}, default to "remote_hub_repo".}

\item{local_repo_path}{path to local clone of the reichlab/covid19-forecast-hub
repository. Only used when data_location is "local_hub_repo"}

\item{hub}{character, which hub to use. Default is "US", other option is
"ECDC"}
}
\value{
data frame with columns model, inc_cum, death_case, target_end_date,
location, value, location_name, population, geo_type, geo_value, abbreviation
}
\description{
"inc hosp" is only available from "HealthData" and "ECDC" and this function is not loading
data for other target variables from "HealthData".
}
\details{
When loading data for multiple target_variables, temporal_resolution will be applied
to all target variables but "inc hosp". In that case, the function will return
daily incident hospitalization counts along with other data.

Weekly temporal resolution will be applied to "inc hosp" if the user specifies "inc hosp"
as the only target_variable.

When loading weekly data, if there are not enough observations for a week, the corresponding
weekly count would be NA in resulting data frame.
}
\examples{
library(covidHubUtils)

# load for US
load_truth(
  truth_source = c("JHU", "HealthData"),
  target_variable = c("inc case", "inc death", "inc hosp")
)

# load for ECDC
load_truth(
  truth_source = c("JHU"),
  target_variable = c("inc case", "inc death"),
  hub = "ECDC"
)
}

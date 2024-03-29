% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hello.R
\name{gd_authenticate}
\alias{gd_authenticate}
\title{Authenticate with Google Earth Engine using \code{gcloud}, "Notebook Authenticator" or other method}
\usage{
gd_authenticate(
  authorization_code = NULL,
  quiet = FALSE,
  code_verifier = NULL,
  auth_mode = NULL,
  scopes = NULL,
  force = TRUE
)
}
\arguments{
\item{authorization_code}{Default: \code{NULL}}

\item{quiet}{Suppress warnings, errors, messages? Default: \code{FALSE}}

\item{code_verifier}{Code verifier (required if \code{authorization_code} is specified). Default: \code{NULL}}

\item{auth_mode}{One of \code{"notebook"}, \code{"colab"}, \code{"gcloud"}, \code{"gcloud-legacy"} or (default) \code{NULL} to guess based on the current environment.}

\item{scopes}{List of scopes to use for authentication. Defaults \code{NULL} corresponds to \code{c('https://www.googleapis.com/auth/earthengine', 'https://www.googleapis.com/auth/devstorage.full_control')}}

\item{force}{Force authentication even if valid credentials exist? Default: \code{TRUE}}
}
\value{
This function is primarily used for the side-effect of authentication with the 'Google Earth Engine' servers. Invisibly returns \code{try-error} on error.
}
\description{
Calls \code{ee.Authenticate(...)} to create a local instance of persistent credentials for  Google Earth Engine. These credentials are used on subsequent calls to \code{ee.Initialize(...)} via \code{gd_initialize()}.
}
\details{
This method should be called once to set up a machine/project with a particular authentication method.
\itemize{
\item \code{auth_mode="gcloud"} (default) fetches credentials using \code{gcloud}. Requires installation of command-line Google Cloud tools; see \url{https://cloud.google.com/cli} for details. This mode will open a web page where you can sign into your Google Account, then a local JSON file will be stored in \code{gcloud} configuration folder with your credentials. These credentials will be used by any library that requests Application Default Credentials (ADC) which are preferred for long-term storage.
\item \code{auth_mode="notebook"} argument is intended primarily for interactive or other short-term use. This mode will open a web page where you can sign into your Google Account to generate a short-term, revocable token to paste into the console prompt.
\item \code{auth_mode="appdefault"} mode uses locally stored credentials \code{gcloud} configuration stored in 'application_default_credentials.json' or JSON file specified by \code{GOOGLE_APPLICATION_CREDENTIALS} environment variable.
}
}
\examples{
\dontrun{
# opens web page to complete authentication/provide authorization code
gd_authenticate(auth_mode = "notebook")
}
}

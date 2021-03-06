\name{fmri.pvalue}
\alias{fmri.pvalue}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ P-values }
\description{
  Determine p-values.
}
\usage{
fmri.pvalue(spm, mode="basic", delta=NULL, na.rm=FALSE, minimum.signal = 0, alpha= 0.05)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{spm}{ \code{fmrispm} object }
  \item{mode}{ type of pvalue definition}
  \item{delta}{ physically meaningful range of latency for HRF }
  \item{na.rm}{\code{na.rm} specifies how NA's in the SPM are handled. NA's may occur
   in voxel where the time series information did not allow for estimating parameters and their variances
   or where the time series information where constant over time. A high (1e19) value of the variance 
   and a parameter of 0 are used to characterize NA's. If \code{na.rm=TRUE} the pvalue for the corresponding voxels
   is set to 1. Otehrwise pvalues are assigned according to the information found in the SPM at the voxel.}
  \item{minimum.signal}{allows to specify a (positive) minimum value for detected signals. If minimum.signal >0
   the thresholds are to conservative, this case needs further improvements.}
  \item{alpha}{Significance level in case of \code{mode="FDA"}}
}
\details{
  If only a contrast is given in \code{spm}, we simply use a t-statistic
  and define p-values according to random field theory for the resulting gaussian
  field (sufficiently large number of df - see ref.). If \code{spm} is a
  vector of length larger than one for each voxel, a chisq field is 
  calculated and evaluated (see
  Worsley and Taylor (2006)). If \code{delta} is given, a cone statistics is
  used.

  The parameter \code{mode} allows for different kinds of p-value
  calculation. "basic" corresponds to a global definition of the
  resel counts based on the amount of smoothness achieved by an equivalent
  Gaussian filter. The propagation condition ensures, that under the
  hypothesis
  \deqn{\hat{\Theta} = 0}
  adaptive smoothing performs like a
  non adaptive filter with the same kernel function which justifies this
  approach. "local"
  corresponds to a more conservative setting, where the p-value is
  derived from the estimated local resel counts that has been achieved by
  adaptive smoothing. In contrast to "basic", "global" takes a global
  median to adjust for the randomness of the weighting scheme generated
  by adaptive smoothing. "global" and "local" are more conservative than
  "basic", that is, they generate sligthly larger p-values. 
  The alternative is \code{mode="FDA"} specifying signal detection by False Discovery Rate (FDR) with significance level specified by \code{alpha}.}
\value{
  Object with class attributes "fmripvalue" and "fmridata"
  \item{pvalue}{ p-value. use with \code{\link{plot}} for thresholding.}
  \item{weights}{ voxelsize ratio }
  \item{dim}{ data dimension }
  \item{hrf}{ expected BOLD response for contrast (single stimulus only)}
}
\references{
  Polzehl, J. and Tabelow, K. (2007)
  \emph{fmri: A Package for Analyzing fmri Data},
  R News, 7:13-17 .

  Tabelow, K., Polzehl, J., Voss, H.U., and Spokoiny, V. (2006). 
\emph{Analysing {fMRI}
    experiments with structure adaptive smoothing procedures},
  NeuroImage, 33:55-62. 

  Worsley, K.J., and Taylor, J.E., \emph{Detecting fMRI activation
    allowing for unknown latency of the hemodynamic response},
  NeuroImage 29:649-654 (2006).
}
\author{ Karsten Tabelow \email{tabelow@wias-berlin.de} }
\note{Unexpected side effects may occur if spm does not meet the
  requirements, especially if a parameter estimate vector of length greater than 2 through
  argument \code{vvector} in \code{\link{fmri.lm}} has beeen produced for every voxel.}
\seealso{ \code{\link{fmri.smooth}}, \code{\link{plot.fmridata}}  }
\examples{
\dontrun{fmri.pvalue(smoothresult)}
}
\keyword{ htest }% at least one, from doc/KEYWORDS

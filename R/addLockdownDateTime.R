#' \code{addLockdownDateTime} takes a plot where the x axis is a daterTime and adds a 
#' rectangle to denote lockdown.
#' 
#' It assumes `myParams$lockDownStartDate` and `myParams$lockDownEndDate` define 
#' the start & end. Yes, they should be parameters.
#' 
#' It also assumed `myParams$myAlpha`and `myParams$vLineCol` exist.
#'
#' @param p the plot
#' @param yMin the min y value of the plot (we -1 for visibility)
#' @param yMax the max y value of the plot (we +1 for visibility)
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'
addLockdownDateTime <- function(p, yMin, yMax){
  # assumes p has x = obsDateTime
  # p <- p + annotate("text", x = myParams$lockDownStartDateTime, 
  #            y = yMax * 0.4, angle = 10,size = myParams$myTextSize,
  #            label = "UK covid lockdown to date", hjust = 0.5)
  p <- p + annotate("rect", xmin = myParams$lockDownStartDateTime,
                    xmax = myParams$lockDownEndDateTime, 
                    ymin = yMin-1, ymax = yMax+1, 
                    alpha = myParams$myAlpha, 
                    fill = myParams$vLineCol, 
                    colour = myParams$vLineCol) 
  
  return(p)
}

#' \code{compareYearsDiffPlotWeekly} makes a geom_step() plot from the dt passed in by
#' aggregating dt to weeks.
#' 
#' It assumes `compareYear` exists and has the values "2017-2019" and "2020". It compares the `value`
#' variable (doesn't care what it is) and prints min/max difference for info. 
#' Should use scales::percent() but doesn't.
#'
#' @param dt the data to plot
#' @param ldStart lockdown start date (for annotation)
#' @param ldEnd lockdown end date (for annotation)
#' 
#' @import data.table
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'
compareYearsDiffPlotWeekly <- function(dt, ldStart, ldEnd){
  # final plot - adds annotations
  # use means for consistency with comparison plots where we use WHO thresholds (means)
  
  p <- ggplot2::ggplot(dt, aes(x = weekNo, y = pcDiffMean)) +
    geom_step() +
    theme(axis.text.x=element_text(angle=90, hjust=1)) +
    labs(x = "Week",
         y = "% difference 2020 vs 2017-2019"
    ) +  
    theme(legend.position="bottom") +
    geom_hline(yintercept = 0,linetype = 3) + 
    facet_grid(site ~ .) +
    theme(strip.text.y.right = element_text(angle = 90))

  return(p)
}
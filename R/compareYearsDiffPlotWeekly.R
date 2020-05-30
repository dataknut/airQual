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
  yMin <- min(dt$pcDiffMean)
  yMax <- max(dt$pcDiffMean)
  p <- ggplot2::ggplot(dt, aes(x = weekNo, y = pcDiffMean)) +
    geom_step() +
    theme(axis.text.x=element_text(angle=90, hjust=1)) +
    labs(x = "Week",
         y = "% difference 2020 vs 2017-2019"
    ) +  
    theme(legend.position="bottom") +
    geom_hline(yintercept = 0,linetype = 3)
  # lubridate::week(as.Date("2020-03-24"))
  p <- p + annotate("rect", xmin = (lubridate::week(ldStart) - 0.1),
                    xmax = (lubridate::week(ldEnd) + 0.1), 
                    ymin = yMin - 1, ymax = yMax + 1, 
                    alpha = myParams$myAlpha, 
                    fill = myParams$vLineCol, 
                    colour = myParams$vLineCol)
  #p <- addLockdownDate(p, yMin, yMax)
  p <- p + facet_grid(site ~ .) +
    theme(strip.text.y.right = element_text(angle = 90))
  #p <- addWeekendsDate(p, yMin, yMax) + scale_x_date(date_breaks = "7 day",
  #                                             date_labels =  "%a %d %b",
  #                                            date_minor_breaks = "1 day")
  return(p)
}
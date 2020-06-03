#' \code{compareYearsDiffPlotDaily} makes a geom_step() plot from the dt passed in by
#' aggregating dt to dates.
#' 
#' It assumes `compareYear` exists and has the values "2017-2019" and "2020". It compares the `value`
#' variable (doesn't care what it is) and prints min/max difference for info. 
#' Should use scales::percent() but doesn't.
#'
#' @param dt the data to plot
#' 
#' @import data.table
#' @author Ben Anderson, \email{b.anderson@@soton.ac.uk} (original)
#' @export
#' @family plots
#'
compareYearsDiffPlotDaily <- function(dt){
  # use means for consistency with comparison plots where we use WHO thresholds (means)
  p <- ggplot2::ggplot(dt, aes(x = fixedDate, y = pcDiffMean 
                               #color = pos, group=NA)
  )
  ) +
    geom_step() +
    scale_x_date(date_breaks = "2 days", date_labels =  "%a %d %b")  +
    theme(axis.text.x=element_text(angle=90, hjust=1, size = 5)) +
    labs(x = "Date",
         y = "% difference 2020 vs 2017-2019",
         caption = paste0(myParams$lockdownCap, myParams$weekendCap)) +  
    theme(legend.position="bottom") +
    geom_hline(yintercept = 0, linetype = 3) + 
    facet_grid(site ~ .) +
    theme(strip.text.y.right = element_text(angle = 90))

  return(p)
}
